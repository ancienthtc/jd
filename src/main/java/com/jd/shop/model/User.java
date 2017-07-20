package com.jd.shop.model;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class User {
    private Integer id;

    private String nickname;

    private String tel;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date birth;

    private String sex;

    private String live;

    private String pass;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date login;

    private Integer score;

    private Integer tellogin;

    private Integer userPiclist;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname == null ? null : nickname.trim();
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel == null ? null : tel.trim();
    }

    public Date getBirth() {
        return birth;
    }

    public void setBirth(Date birth) {
        this.birth = birth;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex == null ? null : sex.trim();
    }

    public String getLive() {
        return live;
    }

    public void setLive(String live) {
        this.live = live == null ? null : live.trim();
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass == null ? null : pass.trim();
    }

    public Date getLogin() {
        return login;
    }

    public void setLogin(Date login) {
        this.login = login;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    public Integer getTellogin() {
        return tellogin;
    }

    public void setTellogin(Integer tellogin) {
        this.tellogin = tellogin;
    }

    public Integer getUserPiclist() {
        return userPiclist;
    }

    public void setUserPiclist(Integer userPiclist) {
        this.userPiclist = userPiclist;
    }
}