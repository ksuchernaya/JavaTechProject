package com.oqs.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue
    @Column(name = "user_id")
    private long id;

    @Column(name = "user_email")
    private String email;

    @Column(name = "user_password")
    private String password;

    @Column(name = "user_role")
    private String role;

    @Column(name = "user_firstname")
    private String firstname;

    @Column(name = "user_lastname")
    private String lastname;

    @Column(name = "user_phone")
    private String phone;

    @Column(name = "bsn_name")
    private String name;

    @JsonIgnore
    @ManyToOne(optional = false)
    @JoinColumn(name = "bsn_type")
    private Type type;

    @Column(name = "bsn_description")
    private String description;

    @Column(name = "bsn_address")
    private String address;

    @ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinTable(name = "bsn_service",
    joinColumns = @JoinColumn(name = "bsn_service_bsn"),
    inverseJoinColumns = @JoinColumn(name = "bsn_service_service"))
    private Set<Service> services = new HashSet<Service>();

    @JsonIgnore
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private Collection<Master> masters = new ArrayList<Master>();

    @JsonIgnore
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private Collection<Schedule> schedules = new ArrayList<Schedule>();

    @JsonIgnore
    @OneToMany(mappedBy = "bsn", cascade = CascadeType.ALL)
    private Collection<Schedule> schedules2 = new ArrayList<Schedule>();

    public User(String email, String password, String role, String firstname, String lastname, String phone, String name, Type type, String description, String address, Set<Service> services, Collection<Master> masters, Collection<Schedule> schedules, Collection<Schedule> schedules2) {
        this.email = email;
        this.password = password;
        this.role = role;
        this.firstname = firstname;
        this.lastname = lastname;
        this.phone = phone;
        this.name = name;
        this.type = type;
        this.description = description;
        this.address = address;
        this.services = services;
        this.masters = masters;
        this.schedules = schedules;
        this.schedules2 = schedules2;
    }

    public User() {
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Set<Service> getServices() {
        return services;
    }

    public void setServices(Set<Service> services) {
        this.services = services;
    }

    public Collection<Master> getMasters() {
        return masters;
    }

    public void setMasters(Collection<Master> masters) {
        this.masters = masters;
    }

    public Collection<Schedule> getSchedules() {
        return schedules;
    }

    public void setSchedules(Collection<Schedule> schedules) {
        this.schedules = schedules;
    }

    public Collection<Schedule> getSchedules2() {
        return schedules2;
    }

    public void setSchedules2(Collection<Schedule> schedules2) {
        this.schedules2 = schedules2;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                ", role='" + role + '\'' +
                ", firstname='" + firstname + '\'' +
                ", lastname='" + lastname + '\'' +
                ", phone='" + phone + '\'' +
                ", name='" + name + '\'' +
                ", type=" + type +
                ", description='" + description + '\'' +
                ", address='" + address + '\'' +
                ", services=" + services +
                ", masters=" + masters +
                ", schedules=" + schedules +
                ", schedules2=" + schedules2 +
                '}';
    }
}
