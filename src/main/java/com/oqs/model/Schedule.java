package com.oqs.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.sql.Time;
import java.sql.Date;

@Entity
@Table(name = "schedule")
public class Schedule {
    @Id
    @GeneratedValue
    @Column(name = "schedule_id")
    private long id;

    @Column(name = "schedule_date")
    private Date date;

    @Column(name = "schedule_time")
    private Time time;

    @Column(name = "schedule_visit")
    private boolean visit;

    @Column(name = "schedule_comment")
    private String comment;

    @JsonIgnore
    @ManyToOne(optional = false)
    @JoinColumn(name = "schedule_user")
    private User user;

    @JsonIgnore
    @ManyToOne(optional = false)
    @JoinColumn(name = "schedule_bsn")
    private User bsn;

    @ManyToOne(optional = false)
    @JoinColumn(name = "schedule_service")
    private Service service;

    @ManyToOne(optional = false)
    @JoinColumn(name = "schedule_master")
    private Master master;

    public Schedule(Date date, Time time, boolean visit, String comment, User user, User bsn, Service service, Master master) {
        this.date = date;
        this.time = time;
        this.visit = visit;
        this.comment = comment;
        this.user = user;
        this.bsn = bsn;
        this.service = service;
        this.master = master;
    }


    public Schedule() {
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Time getTime() {
        return time;
    }

    public void setTime(Time time) {
        this.time = time;
    }

    public boolean isVisit() {
        return visit;
    }

    public void setVisit(boolean visit) {
        this.visit = visit;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public User getBsn() {
        return bsn;
    }

    public void setBsn(User bsn) {
        this.bsn = bsn;
    }

    public Service getService() {
        return service;
    }

    public void setService(Service service) {
        this.service = service;
    }

    public Master getMaster() {
        return master;
    }

    public void setMaster(Master master) {
        this.master = master;
    }

    public SimpleUser getSimpleUser(Schedule s){
        SimpleUser user = new SimpleUser(s);
        return user;
    }

    @Override
    public String toString() {
        return "Schedule{" +
                "id=" + id +
                ", date=" + date +
                ", time=" + time +
                ", visit=" + visit +
                ", comment='" + comment + '\'' +
                ", user=" + user +
                ", bsn=" + bsn +
                ", service=" + service +
                ", master=" + master +
                '}';
    }
     public class SimpleUser{
        private Date simpleDate;
        private String simpleUser;
        private String simpleService;


        public SimpleUser(Schedule s){
            simpleDate = s.getDate();
            simpleService = s.getService().getName();
            simpleUser = s.getUser().getEmail();
        }


        public Date getSimpleDate() {
            return simpleDate;
        }

        public void setSimpleDate(Date simpleDate) {
            this.simpleDate = simpleDate;
        }

        public String getSimpleUser() {
            return simpleUser;
        }

        public void setSimpleUser(String simpleUser) {
            this.simpleUser = simpleUser;
        }

        public String getSimpleService() {
            return simpleService;
        }

        public void setSimpleService(String simpleService) {
            this.simpleService = simpleService;
        }
    }
}
