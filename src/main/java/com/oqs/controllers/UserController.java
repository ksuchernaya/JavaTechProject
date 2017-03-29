package com.oqs.controllers;

import com.oqs.crud.*;
import com.oqs.email.GoogleMail;
import com.oqs.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;

@Controller
public class UserController {

    @Autowired
    MasterDAO masterDAO;

    @Autowired
    ScheduleDAO scheduleDAO;

    @Autowired
    ServiceDAO serviceDAO;

    @Autowired
    TypeDAO typeDAO;

    @Autowired
    UserDAO userDAO;

    @Autowired
    PasswordEncoder passwordEncoder;

    @RequestMapping(value = "/authorization", method = RequestMethod.GET)
    public String authorizationForm() {
        return "authorization";
    }

    @RequestMapping(value = "/registration", method = RequestMethod.GET)
    public String registration(Model model) {
        model.addAttribute("types", typeDAO.getTypeList());
        return "registration";
    }

    @RequestMapping(value = "/registration", method = RequestMethod.POST)
    public String addUserToDB(User user, BindingResult result, HttpServletRequest request) {
        String typeName = request.getParameter("typeComboBoxName");

        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setRole(request.getParameter("role"));

        if (user.getRole().equals("ROLE_USER")) {
            user.setType(typeDAO.get(1));
        } else {
            user.setType(typeDAO.get(typeDAO.getIdByTypeName(typeName)));
        }

        if (result.hasErrors()) {
            return "registration";
        }
        userDAO.add(user);

        return "redirect:/";
    }

    @RequestMapping(value = "/user/{userId}", method = RequestMethod.GET)
    public String myProfile(@PathVariable("userId") long userId, Model model) {
        User user = userDAO.get(userId);
        if(user.getRole().equals("ROLE_USER")) {
            model.addAttribute("user", user);
            model.addAttribute("schedule", scheduleDAO.getScheduleListByUserId(userId));
            return "my-profile";
        } else if(user.getRole().equals("ROLE_BUSINESS")) {
            return "redirect:/organization/{userId}";
        }
        return "my-profile";
    }

    @RequestMapping(value = "/user/{userId}/change-info", method = RequestMethod.GET)
    public String changeInfoForm(@PathVariable("userId") long userId, Model model) {
        model.addAttribute("user", userDAO.get(userId));
        return "change-info";
    }

    @RequestMapping(value = "/user/{userId}/change-info", method = RequestMethod.POST)
    @ResponseBody
    public String saveFirstName(@RequestParam("firstname") String firstname,
                                @RequestParam("lastname") String lastname,
                                @RequestParam("phone") String phone,
                                @PathVariable("userId") long userId, User user) {
        String userInfo = firstname + "," + lastname + "," + phone;

        user = userDAO.get(userId);

        user.setFirstname(firstname);
        user.setLastname(lastname);
        user.setPhone(phone);

        userDAO.update(user);

        return userInfo;
    }

    @RequestMapping(value = "/user/{userId}/change-password", method = RequestMethod.POST)
    @ResponseBody
    public void savePassword(@RequestParam("oldpassword") String oldPassword,
                             @RequestParam("newpassword1") String newPassword1,
                             @RequestParam("newpassword2") String newPassword2,
                             @PathVariable("userId") long userId, User user) {
        user = userDAO.get(userId);

        if (passwordEncoder.matches(oldPassword, user.getPassword()))
            if (newPassword1.equals(newPassword2))
                user.setPassword(passwordEncoder.encode(newPassword1));

        userDAO.update(user);
    }

    @RequestMapping(value = "/check-user-in-db", method = RequestMethod.POST)
    @ResponseBody
    public boolean checkUserInDB(@RequestParam("email") String email) {
        try {
            userDAO.getUserIdByUsername(email);
            return true;
        } catch (Exception e) {
            System.out.println("Пользователь не найден");
            return false;
        }
    }

    @RequestMapping(value = "/send-message-to-us", method = RequestMethod.POST)
    @ResponseBody
    public void sendMessageToUs(@RequestParam("name") String name,
                                @RequestParam("email") String email,
                                @RequestParam("phone") String phone,
                                @RequestParam("message") String message) throws MessagingException {
        GoogleMail.Send("online.queue.system", "Password1234567890", "online.queue.system@gmail.com",
                "from " + email + " to online.queue.system@gmail.com",
                "name: " + name + "\nphone: " + phone + "\n" + message);
    }

}
