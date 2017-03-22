package com.oqs.crud;

import com.oqs.model.Type;
import org.springframework.transaction.annotation.Transactional;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import java.util.List;

@Transactional
public class TypeDAO {

    @PersistenceContext
    public EntityManager entityManager;

    public Type add(Type type) {
        return entityManager.merge(type);
    }

    public void delete(long id) {
        entityManager.remove(entityManager.getReference(Type.class, id));
    }

    public Type get(long id) {
        return entityManager.find(Type.class, id);
    }

    public void update(Type type) {
        entityManager.merge(type);
    }

    public List<Type> getTypeList() {
        TypedQuery<Type> query = entityManager.createQuery(
                "select t from Type t order by t.name", Type.class
        );
        List<Type> result = query.getResultList();
        for(Type t : result)
            if(t.getName().equals("None"))
                result.remove(t);
        return result;
    }

    public long getIdByTypeName(String typeName) {
        Query query = entityManager.createQuery("select t.id from Type t where t.name='" + typeName + "'");
        long result = Long.valueOf(query.getSingleResult().toString());
        return result;
    }
}
