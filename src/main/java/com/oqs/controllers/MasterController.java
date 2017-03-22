package com.oqs.controllers;

import com.oqs.crud.MasterDAO;
import com.oqs.crud.ServiceDAO;
import com.oqs.crud.UserDAO;
import com.oqs.model.Master;
import com.oqs.model.Service;
import com.oqs.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

@Controller
public class MasterController {
    @Autowired
    MasterDAO masterDAO;

    @Autowired
    ServiceDAO serviceDAO;

    @Autowired
    UserDAO userDAO;

    @RequestMapping(value = "/add-master/{organizationId}", method = RequestMethod.POST)
    @ResponseBody
    public long masterAdd(@PathVariable("organizationId") long organizationId,
                          @RequestParam("masterName") String masterName, Master master) {
        User bsn = userDAO.get(organizationId);
        long masterId;
        master.setName(masterName);
        master.setUser(bsn);


        masterId = masterDAO.add(master);
        return masterId;
    }

    @RequestMapping(value = "/delete-master", method = RequestMethod.POST)
    @ResponseBody
    public void masterDelete(@RequestParam("masterId") long masterId) {
        masterDAO.delete(masterId);
    }

    @RequestMapping(value = "/organization/{userId}/change-master-name/{masterId}", method = RequestMethod.POST)
    @ResponseBody
    public List<Master> changeMasterName(@RequestParam("newMasterName") String newMasterName,
                                         @PathVariable("userId") long userId,
                                         @PathVariable("masterId") long masterId, Master master) {
        master = masterDAO.get(masterId);

        master.setId(masterId);
        master.setName(newMasterName);

        masterDAO.update(master);
        List<Master> masterList = masterDAO.getMasterListByOrganization(userId);
        return masterDAO.getMasterListByOrganization(userId);
    }

    @RequestMapping(value = "/change-master-service/{masterId}", method = RequestMethod.POST)
    @ResponseBody
    public void changeMasterService(@PathVariable("masterId") long masterId,
                                    @RequestParam("selected") long[] selected,
                                    @RequestParam("nonSelected") long[] nonSelected) {
        boolean add = false;

        for (long serviceId : selected) {
            Service service = serviceDAO.get(serviceId);
            Set<Master> masterSet = service.getMasters();
            Iterator<Master> masterIterator = masterSet.iterator();
            while (masterIterator.hasNext())
                if (masterIterator.next().getId() == masterId) {
                    add = true;
                    break;
                }
            if (!add)
                masterSet.add(masterDAO.get(masterId));
            else
                add = false;
            serviceDAO.update(service);
        }

        for (long serviceId : nonSelected) {
            Service service = serviceDAO.get(serviceId);
            Set<Master> masterSet = service.getMasters();
            Iterator<Master> masterIterator = masterSet.iterator();
            while (masterIterator.hasNext()) {
                if (masterIterator.next().getId() == masterId) {
                    masterIterator.remove();
                    break;
                }
            }
            serviceDAO.update(service);
        }
    }

    @RequestMapping(value = "/addCheckBoxes/{userId}/{masterId}", method = RequestMethod.GET)
    @ResponseBody
    public List<List<Service>> createCheckBoxes(@PathVariable("masterId") long masterId,
                                                @PathVariable("userId") long userId,
                                                @RequestParam("selected") String[] selected,
                                                Master master) {
        List<Service> serviceListByOrganization = serviceDAO.getServiceListByOrganization(userId);
        List<Service> serviceListByMaster = serviceDAO.getServiceListByMaster(masterId);

        List<List<Service>> listOfServiceList = new ArrayList<List<Service>>();

        listOfServiceList.add(serviceListByOrganization);
        listOfServiceList.add(serviceListByMaster);

        return listOfServiceList;
    }

}
