package com.oqs.crud;

import com.oqs.model.User;
import org.springframework.transaction.annotation.Transactional;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import java.util.List;

@Transactional
public class UserDAO {

    @PersistenceContext
    public EntityManager entityManager;

    public User add(User user) {
        return entityManager.merge(user);
    }

    public void delete(long id) {
        entityManager.remove(entityManager.getReference(User.class, id));
    }

    public User get(long id) {
        return entityManager.find(User.class, id);
    }

    public void update(User user) {
        entityManager.merge(user);
    }

    public List<User> getUserList() {
        TypedQuery<User> query = entityManager.createQuery(
                "select u from User u", User.class
        );
        List<User> result = query.getResultList();
        return result;
    }

//    public List<User> getBsnList() {
//        TypedQuery<User> query = entityManager.createQuery(
//                "select u from User u where u.role='ROLE_BUSINESS'", User.class
//        );
//        List<User> result = query.getResultList();
//        return result;
//    }

    public List<User> getBsnListByType(String typeId) {
        if(typeId.equals("0"))
            typeId = "any(select t from Type t)";
        String queryString = "select u from User u where u.role='ROLE_BUSINESS' and u.type=" + typeId + " order by u.name";
        TypedQuery<User> query = entityManager.createQuery(queryString, User.class);
        List<User> result = query.getResultList();
        return result;
    }

    public long getUserIdByUsername(String email) {
        Query query = entityManager.createQuery(
                "select u.id from User u where u.email= :email").setParameter("email", email);
        long result = (Long)query.getSingleResult();
        return result;
    }
}
