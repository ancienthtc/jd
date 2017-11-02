package com.jd.shop.service;

import com.jd.shop.model.Format;

import java.util.List;

/**
 * Created by ThinkPad on 2017/10/25.
 */
public interface FormatService {

    int FormatAdd(Format format);

    List<Format> getGoodsFormat(Integer gid);

    Format getFormat(Integer fid);

    int delFormat(Integer fid);

    int addFormat(String json);

    int alterFormat(String json);

    //int delFormat(String id);
}
