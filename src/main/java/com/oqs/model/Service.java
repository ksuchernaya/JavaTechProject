package com.oqs.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "service")
public class Service {
    @Id
    @GeneratedValue
    @Column(name = "service_id")
    private long id;

    @Column(name = "service_name")
    private String name;

    @JsonIgnore
    @ManyToOne(optional = false)
    @JoinColumn(name = "service_type")
    private Type type;

    @JsonIgnore
    @ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinTable(name = "service_master",
            joinColumns = @JoinColumn(name = "service_master_service"),
            inverseJoinColumns = @JoinColumn(name = "service_master_master"))
    private Set<Master> masters = new HashSet<Master>();

    @JsonIgnore
    @ManyToMany(mappedBy = "services")
    private Set<User> bsns = new HashSet<User>();

    @JsonIgnore
    @OneToMany(mappedBy = "service", cascade = CascadeType.ALL)
    private Collection<Schedule> schedules = new ArrayList<Schedule>();

    public Service(String name, Type type, Set<Master> masters, Set<User> bsns, Collection<Schedule> schedules) {
        this.name = name;
        this.type = type;
        this.masters = masters;
        this.bsns = bsns;
        this.schedules = schedules;
    }

    public Service() {
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

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    public Set<Master> getMasters() {
        return masters;
    }

    public void setMasters(Set<Master> masters) {
        this.masters = masters;
    }

    public Set<User> getBsns() {
        return bsns;
    }

    public void setBsns(Set<User> bsns) {
        this.bsns = bsns;
    }

    public Collection<Schedule> getSchedules() {
        return schedules;
    }

    public void setSchedules(Collection<Schedule> schedules) {
        this.schedules = schedules;
    }

    @Override
    public String toString() {
        return "Service{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", type=" + type +
                ", masters=" + masters +
                ", bsns=" + bsns +
                ", schedules=" + schedules +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Service service = (Service) o;

        return name.equals(service.name);

    }

}
