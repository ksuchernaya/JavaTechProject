package com.oqs.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "master")
public class Master {
    @Id
    @GeneratedValue
    @Column(name = "master_id")
    private long id;

    @Column(name = "master_name")
    private String name;

    @JsonIgnore
    @ManyToOne(optional = false)
    @JoinColumn(name = "master_user")
    private User user;

    @JsonIgnore
    @ManyToMany (fetch = FetchType.EAGER, mappedBy = "masters")
    private Set<Service> services = new HashSet<Service>();

    @JsonIgnore
    @OneToMany(mappedBy = "master", cascade = CascadeType.ALL)
    private Collection<Schedule> schedules = new ArrayList<Schedule>();

    public Master(String name, User user, Set<Service> services, Collection<Schedule> schedules) {
        this.name = name;
        this.user = user;
        this.services = services;
        this.schedules = schedules;
    }

    public Master() {
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

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Set<Service> getServices() {
        return services;
    }

    public void setServices(Set<Service> services) {
        this.services = services;
    }

    public Collection<Schedule> getSchedules() {
        return schedules;
    }

    public void setSchedules(Collection<Schedule> schedules) {
        this.schedules = schedules;
    }

    @Override
    public String toString() {
        return "Master{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", user=" + user +
                ", services=" + services +
                ", schedules=" + schedules +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Master master = (Master) o;

        return name.equals(master.name);

    }

}
