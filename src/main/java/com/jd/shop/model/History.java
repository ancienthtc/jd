package com.jd.shop.model;

import javax.persistence.Transient;
import java.util.Date;

public class History {
    private Integer id;

    private Date viewtime;

    private Integer userHistory;

    private Integer goodsHistory;

    @Transient
    private Integer goodId;

    @Transient
    private String name;//goods name

    @Transient
    private String title;//image title

    @Transient
    private Double price;//goods price


    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Integer getGoodId() {
        return goodId;
    }

    public String getName() {
        return name;
    }

    public Double getPrice() {
        return price;
    }

    public void setGoodId(Integer goodId) {
        this.goodId = goodId;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getViewtime() {
        return viewtime;
    }

    public void setViewtime(Date viewtime) {
        this.viewtime = viewtime;
    }

    public Integer getUserHistory() {
        return userHistory;
    }

    public void setUserHistory(Integer userHistory) {
        this.userHistory = userHistory;
    }

    public Integer getGoodsHistory() {
        return goodsHistory;
    }

    public void setGoodsHistory(Integer goodsHistory) {
        this.goodsHistory = goodsHistory;
    }
}