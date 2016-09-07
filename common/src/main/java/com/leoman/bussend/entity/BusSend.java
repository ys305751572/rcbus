package com.leoman.bussend.entity;

import com.leoman.bus.entity.Bus;
import com.leoman.entity.BaseEntity;

import javax.persistence.*;

/**
 * 巴士派遣
 * Created by 史龙 on 2016/9/7.
 */
@Entity
@Table(name = "t_bus_send")
public class BusSend extends BaseEntity{

    //关联id
    @Column(name = "contact_id")
    private Long contactId;

    //巴士id
    @ManyToOne
    @JoinColumn(name = "bus_id")
    private Bus bus;

    //类型 1:路线 2:租车
    @Column(name = "type")
    private Integer type;

    public Long getContactId() {
        return contactId;
    }

    public void setContactId(Long contactId) {
        this.contactId = contactId;
    }

    public Bus getBus() {
        return bus;
    }

    public void setBus(Bus bus) {
        this.bus = bus;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }
}
