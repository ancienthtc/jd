package com.jd.shop.model;

import javax.persistence.Transient;
import java.util.Date;

public class Comment {
    private Integer id;

    private Integer grade;

    private Date time;

    private String comment;

    private Integer commentUser;

    private Integer commentGoods;

    @Transient
    private Integer goodId;

    @Transient
    private String name;

    @Transient
    private Double price;


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

    public Integer getGrade() {
        return grade;
    }

    public void setGrade(Integer grade) {
        this.grade = grade;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment == null ? null : comment.trim();
    }

    public Integer getCommentUser() {
        return commentUser;
    }

    public void setCommentUser(Integer commentUser) {
        this.commentUser = commentUser;
    }

    public Integer getCommentGoods() {
        return commentGoods;
    }

    public void setCommentGoods(Integer commentGoods) {
        this.commentGoods = commentGoods;
    }
}