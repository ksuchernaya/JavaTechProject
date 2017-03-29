package com.oqs.crud;

import com.oqs.model.Schedule;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

@Transactional
public class ScheduleDAO {

    @PersistenceContext
    EntityManager entityManager;

    public Schedule add(Schedule schedule) {
        return entityManager.merge(schedule);
    }

    public void delete(long id) {
        entityManager.remove(entityManager.getReference(Schedule.class, id));
    }

    public Schedule get(long id) {
        return entityManager.find(Schedule.class, id);
    }

    public void update(Schedule schedule) {
        entityManager.merge(schedule);
    }

    public List<Schedule> getScheduleListByUserId(long userId) {
        TypedQuery<Schedule> query = entityManager.createQuery(
                "select s from Schedule s where s.user.id=" + userId, Schedule.class
        );
        List<Schedule> result = query.getResultList();
        return result;
    }

    public List<Schedule> getScheduleListByMasterId(long masterId) {
        TypedQuery<Schedule> query = entityManager.createQuery(
                "select s from Schedule s where s.master.id=" + masterId, Schedule.class
        );
        List<Schedule> result = query.getResultList();
        return result;
    }

    public List<Time> getTimeListByMasterAndDate(long masterId, Date date) {
        Query query = entityManager.createQuery(
                "select s.time from Schedule s where s.master.id=" + masterId + " and s.date='" + date + "'");
        List<Time> result = query.getResultList();
        return result;
    }
}
