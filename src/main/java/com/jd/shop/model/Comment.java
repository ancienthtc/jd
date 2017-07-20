package com.jd.shop.model;

import java.util.Date;

public class Comment {
    private Integer id;

    private Integer grade;

    private Date time;

    private String comment;

    private Integer commentUser;

    private Integer commentGoods;

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