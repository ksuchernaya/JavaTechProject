package com.oqs.controllers;

import com.oqs.crud.*;
import com.oqs.model.Master;
import com.oqs.model.Schedule;
import com.oqs.model.*;
import com.oqs.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import javax.servlet.http.HttpServletRequest;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

@Controller
public class OrganizationController {

    @Autowired
    UserDAO userDAO;

    @Autowired
    ServiceDAO serviceDAO;

    @Autowired
    MasterDAO masterDAO;

    @Autowired
    ScheduleDAO scheduleDAO;

    @Autowired
    TypeDAO typeDAO;

    @RequestMapping(value = "/organizations", method = RequestMethod.GET)
    public String organizations(@ModelAttribute("typeId") String typeId, Model model) {
        if(typeId.equals(""))
            typeId = "0";
        model.addAttribute("typeId", typeId);
        model.addAttribute("organizations", userDAO.getBsnListByType(typeId));
        model.addAttribute("types", typeDAO.getTypeList());
        return "organizations";
    }

    @RequestMapping(value = "/organizations-sort-by", method = RequestMethod.POST)
    public String organizationsSortBy(@RequestParam("typeId") String typeId,
                                RedirectAttributes redirectAttributes) {
        redirectAttributes.addFlashAttribute("typeId", typeId);
        return "redirect:/organizations";
    }

    @RequestMapping(value = "/organizations-sort-by", method = RequestMethod.GET)
    @ResponseBody
    public List<User.SimpleUser> organizationsBySort(@RequestParam("typeId") String typeId) {
        List<User> organizationList = userDAO.getBsnListByType(typeId);
        List<User.SimpleUser> su = new ArrayList<User.SimpleUser>();
        for(User u: organizationList){
            su.add(u.getSmplUser(u));
        }
        return su;
    }

    @RequestMapping(value = "/organization/{organizationId}", method = RequestMethod.GET)
    public String organization(@PathVariable("organizationId") long organizationId, Model model) {
        User organization = userDAO.get(organizationId);
        model.addAttribute("services", serviceDAO.getServiceListByOrganization(organizationId));
        model.addAttribute("servicesByType", serviceDAO.getServiceListByType(organization.getType().getId()));
        model.addAttribute("organization", organization);
        model.addAttribute("allMasters", masterDAO.getMasterListByOrganization(organizationId));
        return "organization";
    }

    @RequestMapping(value = "/organization/{organizationId}/service/{serviceId}", method = RequestMethod.GET)
    public String service(@PathVariable("organizationId") long organizationId,
                          @PathVariable("serviceId") long serviceId, Model model) {
        List<Master> masterList = masterDAO.getMasterListByServiceAndOrganization(serviceId, organizationId);
        model.addAttribute("service", serviceDAO.get(serviceId));
        model.addAttribute("organization", userDAO.get(organizationId));
        model.addAttribute("masters", masterList);
        return "service";
    }

    @RequestMapping(value = "/booking-add/{organizationId}/{username}/{serviceId}", method = RequestMethod.POST)
    public String bookingAdd(@PathVariable("username") String username,
                             @PathVariable("organizationId") long organizationId,
                             @PathVariable("serviceId") long serviceId,
                             HttpServletRequest request, Schedule schedule) throws ParseException {

        final String OLD_FORMAT = "dd-MM-yyyy";
        final String NEW_FORMAT = "yyyy-MM-dd";

        String dateString = request.getParameter("dateName");

        SimpleDateFormat sdf = new SimpleDateFormat(OLD_FORMAT);
        java.util.Date date = sdf.parse(dateString);
        sdf.applyPattern(NEW_FORMAT);
        java.sql.Date sqlDate = new java.sql.Date(date.getTime());

        schedule.setBsn(userDAO.get(organizationId));
        schedule.setComment(request.getParameter("bookingComment"));
        schedule.setDate(sqlDate);
        schedule.setMaster(masterDAO.get(Long.valueOf(request.getParameter("masterDropDownListName"))));
        schedule.setService(serviceDAO.get(serviceId));
        schedule.setTime(Time.valueOf(request.getParameter("timeDropDownListName")));
        schedule.setUser(userDAO.get(userDAO.getUserIdByUsername(username)));
        schedule.setVisit(false);
        scheduleDAO.add(schedule);

        return "redirect:/user/" + userDAO.getUserIdByUsername(username);
    }

    @RequestMapping(value = "/delete-booking/{scheduleId}", method = RequestMethod.POST)
    @ResponseBody
    public void bookingDelete(@PathVariable("scheduleId") long scheduleId) {
        scheduleDAO.delete(scheduleId);
    }

    @RequestMapping(value = "/masters-schedule", method = RequestMethod.GET)
    @ResponseBody
    public List<Schedule.SimpleUser> showMastersSchedule(@RequestParam("masterId") long masterId) {
        List<Schedule> list = scheduleDAO.getScheduleListByMasterId(masterId);
        List<Schedule.SimpleUser> smpl = new ArrayList<Schedule.SimpleUser>();
        for (Schedule s:list){
            smpl.add(s.getSimpleUser(s));
        }
        return smpl;
    }

}
