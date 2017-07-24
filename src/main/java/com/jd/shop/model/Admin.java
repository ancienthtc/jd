package com.jd.shop.model;

import java.util.Date;

public class Admin {
    private Integer id;

    private String admin;

    private String apass;

    private Date alogin;

    private Integer alevel;//管理员权限 新增

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getAdmin() {
        return admin;
    }

    public void setAdmin(String admin) {
        this.admin = admin == null ? null : admin.trim();
    }

    public String getApass() {
        return apass;
    }

    public void setApass(String apass) {
        this.apass = apass == null ? null : apass.trim();
    }

    public Date getAlogin() {
        return alogin;
    }

    public void setAlogin(Date alogin) {
        this.alogin = alogin;
    }

    public Integer getAlevel() {
        return alevel;
    }

    public void setAlevel(Integer alevel) {
        this.alevel = alevel;
    }
}