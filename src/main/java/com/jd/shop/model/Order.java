package com.jd.shop.model;

import java.util.Date;

public class Order {
    private Integer id;

    private Date ordertime;

    private Integer shopstatus;

    private Integer paystatus;

    private Date paytime;

    private Integer limit;

    private Double amount;

    private Double allprice;    //新增-支付总价

    private Integer orderUser;

    private Integer orderGoods;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public Double getAllprice() {
        return allprice;
    }

    public void setAllprice(Double allprice) {
        this.allprice = allprice;
    }

    public Integer getOrderUser() {
        return orderUser;
    }

    public void setOrderUser(Integer orderUser) {
        this.orderUser = orderUser;
    }

    public Integer getOrderGoods() {
        return orderGoods;
    }

    public void setOrderGoods(Integer orderGoods) {
        this.orderGoods = orderGoods;
    }
}