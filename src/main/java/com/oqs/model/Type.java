package com.oqs.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Collection;

@Entity
@Table(name = "type")
public class Type {

    @Id
    @GeneratedValue
    @Column(name = "type_id")
    private long id;

    @Column(name = "type_name")
    private String name;

    @JsonIgnore
    @OneToMany(fetch = FetchType.EAGER, mappedBy = "type", cascade = CascadeType.ALL)
    private Collection<User> users = new ArrayList<User>();

    @JsonIgnore
    @OneToMany(mappedBy = "type", cascade = CascadeType.ALL)
    private Collection<Service> services = new ArrayList<Service>();

    public Type(String name, Collection<User> users, Collection<Service> services) {
        this.name = name;
        this.users = users;
        this.services = services;
    }

    public Type() {
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Collection<User> getUsers() {
        return users;
    }

    public void setUsers(Collection<User> users) {
        this.users = users;
    }

    public Collection<Service> getServices() {
        return services;
    }

    public void setServices(Collection<Service> services) {
        this.services = services;
    }

    @Override
    public String toString() {
        return "Type{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", users=" + users +
                ", services=" + services +
                '}';
    }
}
