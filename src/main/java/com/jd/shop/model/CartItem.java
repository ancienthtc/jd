package com.jd.shop.model;

public class CartItem {
    private Integer id;

    private Double amount;

    private Double tprice;

    private Integer itemFormat;

    private Integer itemGoods;

    private Integer itemCart;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public Double getTprice() {
        return tprice;
    }

    public void setTprice(Double tprice) {
        this.tprice = tprice;
    }

    public Integer getItemFormat() {
        return itemFormat;
    }

    public void setItemFormat(Integer itemFormat) {
        this.itemFormat = itemFormat;
    }

    public Integer getItemGoods() {
        return itemGoods;
    }

    public void setItemGoods(Integer itemGoods) {
        this.itemGoods = itemGoods;
    }

    public Integer getItemCart() {
        return itemCart;
    }

    public void setItemCart(Integer itemCart) {
        this.itemCart = itemCart;
    }
}