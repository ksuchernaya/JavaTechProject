package com.oqs.controllers;

import com.oqs.crud.ServiceDAO;
import com.oqs.crud.TypeDAO;
import com.oqs.model.Service;
import com.oqs.model.Type;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;

@RestController
@RequestMapping("rest")
public class WebServiceController {

    @Autowired
    ServiceDAO serviceDAO;

    @Autowired
    TypeDAO typeDAO;

    @RequestMapping(value = "services", produces = "application/json")
    public List<Service> getServices() {
        return serviceDAO.getServiceList();
    }

    @RequestMapping(value = "types", produces = "application/json")
    public List<Type> getTypes() {
        return typeDAO.getTypeList();
    }
}
