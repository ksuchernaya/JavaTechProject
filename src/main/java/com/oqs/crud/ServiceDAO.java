package com.oqs.crud;

import com.oqs.model.Service;
import org.springframework.transaction.annotation.Transactional;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import java.util.List;

@Transactional
public class ServiceDAO {

    @PersistenceContext
    EntityManager entityManager;

    public long add(Service service) {
        return entityManager.merge(service).getId();
    }

    public void delete(long id) {
        entityManager.remove(entityManager.getReference(Service.class, id));
    }

    public Service get(long id) {
        return entityManager.find(Service.class, id);
    }

    public void update(Service service) {
        entityManager.merge(service);
    }

    public List<Service> getServiceList() {
        TypedQuery<Service> query = entityManager.createQuery(
                "select s from Service s order by s.name", Service.class
        );
        List<Service> result = query.getResultList();
        return result;
    }

    public List<Service> getServiceListByMaster(long masterId) {
        Query query = entityManager.createNativeQuery("select s.* from service s, service_master sm " +
                "where s.service_id = sm.service_master_service and sm.service_master_master=" + masterId, Service.class);
        List<Service> result = query.getResultList();
        return result;
    }

    public List<Service> getServiceListByType(long typeId) {
        TypedQuery<Service> query = entityManager.createQuery(
                "select s from Service s where s.type=" + typeId + "order by s.name", Service.class
        );
        List<Service> result = query.getResultList();
        return result;
    }

    public List<Service> getServiceListByOrganization(long organizationId) {
        Query query = entityManager.createNativeQuery("select s.* from service s, bsn_service bs " +
                "where s.service_id = bs.bsn_service_service and bs.bsn_service_bsn=" + organizationId + " order by s.service_name", Service.class);
        List<Service> result = query.getResultList();
        return result;
    }
}
