package com.jd.shop.model;

import java.util.Date;

public class Public {
    private Integer id;

    private Date publictime;

    private String title;

    private String context;

    private String type;

    private Integer publicPiclist;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getPublictime() {
        return publictime;
    }

    public void setPublictime(Date publictime) {
        this.publictime = publictime;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public String getContext() {
        return context;
    }

    public void setContext(String context) {
        this.context = context == null ? null : context.trim();
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type == null ? null : type.trim();
    }

    public Integer getPublicPiclist() {
        return publicPiclist;
    }

    public void setPublicPiclist(Integer publicPiclist) {
        this.publicPiclist = publicPiclist;
    }
}