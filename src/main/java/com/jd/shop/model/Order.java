package com.jd.shop.model;

import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.Transient;
import java.util.Date;

public class Order {
    private Integer id;

    private String uuid;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date ordertime;

    private Integer shopstatus;

    private Integer paystatus;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date paytime;

    private Integer limit;

    private Double allprice;

    private String detail;

    private Integer orderUser;

    @Transient
    private String limit2;//计算后的limit值

    @Transient
    private String ordertime2;//格式化ordertime

    public String getOrdertime2() {
        return ordertime2;
    }

    public void setOrdertime2(String ordertime2) {
        this.ordertime2 = ordertime2;
    }

    public String getLimit2() {
        return limit2;
    }

    public void setLimit2(String limit2) {
        this.limit2 = limit2;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid == null ? null : uuid.trim();
    }

    public Date getOrdertime() {
        return ordertime;
    }

    public void setOrdertime(Date ordertime) {
        this.ordertime = ordertime;
    }

    public Integer getShopstatus() {
        return shopstatus;
    }

    public void setShopstatus(Integer shopstatus) {
        this.shopstatus = shopstatus;
    }

    public Integer getPaystatus() {
        return paystatus;
    }

    public void setPaystatus(Integer paystatus) {
        this.paystatus = paystatus;
    }

    public Date getPaytime() {
        return paytime;
    }

    public void setPaytime(Date paytime) {
        this.paytime = paytime;
    }

    public Integer getLimit() {
        return limit;
    }

    public void setLimit(Integer limit) {
        this.limit = limit;
    }

    public Double getAllprice() {
        return allprice;
    }

    public void setAllprice(Double allprice) {
        this.allprice = allprice;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail == null ? null : detail.trim();
    }

    public Integer getOrderUser() {
        return orderUser;
    }

    public void setOrderUser(Integer orderUser) {
        this.orderUser = orderUser;
    }
}