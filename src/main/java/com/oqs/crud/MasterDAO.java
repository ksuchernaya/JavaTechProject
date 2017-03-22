package com.oqs.crud;

import com.oqs.model.Master;
import com.oqs.model.Service;
import org.springframework.transaction.annotation.Transactional;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import java.util.List;

@Transactional
public class MasterDAO {

    @PersistenceContext
    public EntityManager entityManager;

    public Long add(Master master) {
        return entityManager.merge(master).getId();
    }

    public void delete(long id) {
        entityManager.remove(entityManager.getReference(Master.class, id));
    }

    public Master get(long id) {
        return entityManager.find(Master.class, id);
    }

    public void update(Master master) {
        entityManager.merge(master);
    }

    public List<Master> getMasterList() {
        TypedQuery<Master> query = entityManager.createQuery(
                "select m from Master m order by m.name", Master.class
        );
        List<Master> result = query.getResultList();
        return result;
    }

    public List<Master> getMasterListByOrganization(long organizationId) {
        TypedQuery<Master> query = entityManager.createQuery(
                "select m from Master m where m.user='" + organizationId + "'", Master.class
        );
        List<Master> result = query.getResultList();
        return result;
    }

    public List<Master> getMasterListByServiceAndOrganization(long serviceId, long organizationId) {
        Query query = entityManager.createNativeQuery("select m.* from master m, service_master sm  " +
                "where sm.service_master_service = " + serviceId + " and m.master_id = sm.service_master_master and m.master_user=" + organizationId, Master.class);
        List<Master> result = query.getResultList();
        return result;
    }
}
