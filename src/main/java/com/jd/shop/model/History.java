package com.jd.shop.model;

import java.util.Date;

public class History {
    private Integer id;

    private Date viewtime;

    private Integer userHistory;

    private Integer goodsHistory;

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