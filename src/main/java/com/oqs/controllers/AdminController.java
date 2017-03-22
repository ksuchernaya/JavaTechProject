package com.oqs.controllers;

import com.oqs.crud.ServiceDAO;
import com.oqs.crud.UserDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AdminController {

    @Autowired
    ServiceDAO serviceDAO;

    @Autowired
    UserDAO userDAO;

    @RequestMapping(value = "/admin-page", method = RequestMethod.GET)
    public String adminPage(Model model) {
        model.addAttribute("services", serviceDAO.getServiceList());
        model.addAttribute("users", userDAO.getUserList());
        return "admin-page";
    }

//    @RequestMapping(value = "/")

//    @RequestMapping(value = "/user-delete/{userId}", method = RequestMethod.POST)
//    public String userDelete(@PathVariable("userId") long userId) {
//        System.out.println("1");
//        userDAO.delete(userId);
//        System.out.println("2");
//        return "redirect:/admin-page";
//    }

}
