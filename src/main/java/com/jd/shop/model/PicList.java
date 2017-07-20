package com.jd.shop.model;

public class PicList {
    private Integer id;

    private String listname;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getListname() {
        return listname;
    }

    public void setListname(String listname) {
        this.listname = listname == null ? null : listname.trim();
    }
}