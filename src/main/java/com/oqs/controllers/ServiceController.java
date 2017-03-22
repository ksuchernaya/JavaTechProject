package com.oqs.controllers;

import com.oqs.crud.*;
import com.oqs.model.Master;
import com.oqs.model.Service;
import com.oqs.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class ServiceController {

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

    //TODO sometimes don't word because of OLD service_master records (need to delete records during deleting objects)
    @RequestMapping(value = "/add-service/{organizationId}", method = RequestMethod.POST)
    @ResponseBody
    public String serviceAdd(@PathVariable("organizationId") long organizationId,
                             @RequestParam("serviceId") long serviceId) {
        User bsn = userDAO.get(organizationId);
        Set<Service> serviceSet = bsn.getServices();
        Iterator<Service> serviceIterator = serviceSet.iterator();
        Service service = serviceDAO.get(serviceId);
        while (serviceIterator.hasNext())
            if (serviceIterator.next().getName().equals(service.getName())) {
                System.out.println("сервис есть");
                return "";
            }
        serviceSet.add(service);
        bsn.setId(organizationId);
        userDAO.update(bsn);

        return service.getName();
    }

    //TODO delete service don't delete from dropdownlist after adding with no updating page (go to ajax)
    @RequestMapping(value = "/add-new-service/{organizationId}", method = RequestMethod.POST)
    @ResponseBody
    public long newServiceAdd(@PathVariable("organizationId") long organizationId,
                              @RequestParam("serviceName") String serviceName, Service service) {
        User bsn = userDAO.get(organizationId);
        long serviceId = 0;
        if (!serviceName.equals("")) {
            service.setName(serviceName);
            service.setType(typeDAO.get(bsn.getType().getId()));
            bsn.getServices().add(service);

            bsn.setId(organizationId);

            serviceId = serviceDAO.add(service);
            service.setId(serviceId);
            userDAO.update(bsn);
        }

        return serviceId;
    }

    //TODO add deleting records from service_master
    @RequestMapping(value = "/delete-service/{organizationId}", method = RequestMethod.POST)
    @ResponseBody
    public void serviceDelete(@PathVariable("organizationId") long organizationId,
                              @RequestParam("serviceId") long serviceId) {
        User bsn = userDAO.get(organizationId);
        System.out.println("1");
        Set<Service> serviceList = bsn.getServices();
        Iterator<Service> serviceIterator = serviceList.iterator();

        while (serviceIterator.hasNext()) {
            if (serviceIterator.next().getName().equals(serviceDAO.get(serviceId).getName()))
                serviceIterator.remove();
        }

        bsn.setId(organizationId);
        userDAO.update(bsn);
    }

    @RequestMapping(value = "/change-service-master/{serviceId}", method = RequestMethod.POST)
    @ResponseBody
    public void changeServiceMaster(@PathVariable("serviceId") long serviceId,
                                    @RequestParam("selected") long[] selected) {
        Service service = serviceDAO.get(serviceId);
        Set<Master> masterSet = new HashSet<Master>();
        for (long masterId : selected)
            masterSet.add(masterDAO.get(masterId));
        service.setMasters(masterSet);
        serviceDAO.update(service);
    }

    @RequestMapping(value = "/addCheckBoxesForService/{userId}/{serviceId}", method = RequestMethod.GET)
    @ResponseBody
    public List<List<Master>> createCheckBoxesForService(@PathVariable("serviceId") long serviceId,
                                                         @PathVariable("userId") long userId) {
        List<Master> masterListByOrganization = masterDAO.getMasterListByOrganization(userId);
        List<Master> masterListByService = masterDAO.getMasterListByServiceAndOrganization(serviceId, userId);

        List<List<Master>> listOfMasterLists = new ArrayList<List<Master>>();
        listOfMasterLists.add(masterListByOrganization);
        listOfMasterLists.add(masterListByService);

        return listOfMasterLists;
    }

    @RequestMapping(value = "/scheduleByMaster", method = RequestMethod.GET)
    @ResponseBody
    public List<List<Time>> scheduleByMaster(@RequestParam("masterId") long masterId,
                                             @RequestParam("date") String dateString) throws ParseException {
        final String OLD_FORMAT = "dd-MM-yyyy";
        final String NEW_FORMAT = "yyyy-MM-dd";

        SimpleDateFormat sdf = new SimpleDateFormat(OLD_FORMAT);
        java.util.Date date = sdf.parse(dateString);
        sdf.applyPattern(NEW_FORMAT);
        java.sql.Date sqlDate = new java.sql.Date(date.getTime());

        List<Time> timeList = new ArrayList<Time>();

        for (int i = 10; i < 19; i++) {
            timeList.add(java.sql.Time.valueOf(i + ":00:00"));
        }

        List<Time> timeListByMasterAndDate = scheduleDAO.getTimeListByMasterAndDate(masterId, sqlDate);

        List<List<Time>> listOfTimeLists = new ArrayList<List<Time>>();
        listOfTimeLists.add(timeList);
        listOfTimeLists.add(timeListByMasterAndDate);

        return listOfTimeLists;
    }
}
