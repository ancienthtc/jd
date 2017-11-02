package com.jd.shop.model;

import javax.persistence.Transient;

public class Format {
    private Integer id;

    private String fname;

    private Double fprice;

    private Double fstock;

    private Double fsale;

    private String attr3;

    private Integer goodsFormat;

    @Transient
    private Integer gid;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname == null ? null : fname.trim();
    }

    public Double getFprice() {
        return fprice;
    }

    public void setFprice(Double fprice) {
        this.fprice = fprice;
    }

    public Double getFstock() {
        return fstock;
    }

    public void setFstock(Double fstock) {
        this.fstock = fstock;
    }

    public Double getFsale() {
        return fsale;
    }

    public void setFsale(Double fsale) {
        this.fsale = fsale;
    }

    public String getAttr3() {
        return attr3;
    }

    public void setAttr3(String attr3) {
        this.attr3 = attr3 == null ? null : attr3.trim();
    }

    public Integer getGoodsFormat() {
        return goodsFormat;
    }

    public void setGoodsFormat(Integer goodsFormat) {
        this.goodsFormat = goodsFormat;
    }

    public Integer getGid() {
        return gid;
    }

    public void setGid(Integer gid) {
        this.gid = gid;
    }
}