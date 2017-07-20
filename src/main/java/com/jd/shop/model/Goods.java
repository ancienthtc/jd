package com.jd.shop.model;

import java.util.Date;
import java.util.List;

public class Goods {
    private Integer id;

    private String name;

    private Double price;

    private String gclass;

    private String parameter1;

    private String parameter2;

    private String parameter3;

    private Double freight;

    private String detail;

    private Double sales;

    private Double stock;

    private Date shelf;

    private Integer partGoods;

    private Integer piclistGoods;

    private Image image;

    public Image getImage() {
        return image;
    }

    public void setImage(Image image) {
        this.image = image;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getGclass() {
        return gclass;
    }

    public void setGclass(String gclass) {
        this.gclass = gclass == null ? null : gclass.trim();
    }

    public String getParameter1() {
        return parameter1;
    }

    public void setParameter1(String parameter1) {
        this.parameter1 = parameter1 == null ? null : parameter1.trim();
    }

    public String getParameter2() {
        return parameter2;
    }

    public void setParameter2(String parameter2) {
        this.parameter2 = parameter2 == null ? null : parameter2.trim();
    }

    public String getParameter3() {
        return parameter3;
    }

    public void setParameter3(String parameter3) {
        this.parameter3 = parameter3 == null ? null : parameter3.trim();
    }

    public Double getFreight() {
        return freight;
    }

    public void setFreight(Double freight) {
        this.freight = freight;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail == null ? null : detail.trim();
    }

    public Double getSales() {
        return sales;
    }

    public void setSales(Double sales) {
        this.sales = sales;
    }

    public Double getStock() {
        return stock;
    }

    public void setStock(Double stock) {
        this.stock = stock;
    }

    public Date getShelf() {
        return shelf;
    }

    public void setShelf(Date shelf) {
        this.shelf = shelf;
    }

    public Integer getPartGoods() {
        return partGoods;
    }

    public void setPartGoods(Integer partGoods) {
        this.partGoods = partGoods;
    }

    public Integer getPiclistGoods() {
        return piclistGoods;
    }

    public void setPiclistGoods(Integer piclistGoods) {
        this.piclistGoods = piclistGoods;
    }
}