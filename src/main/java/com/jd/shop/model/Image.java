package com.jd.shop.model;

public class Image {
    private Integer id;

    private String title;

    private String filename;

    private String server;

    private Integer imageList;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename == null ? null : filename.trim();
    }

    public String getServer() {
        return server;
    }

    public void setServer(String server) {
        this.server = server == null ? null : server.trim();
    }

    public Integer getImageList() {
        return imageList;
    }

    public void setImageList(Integer imageList) {
        this.imageList = imageList;
    }
}