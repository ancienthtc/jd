package com.jd.shop.dao;

import com.jd.shop.model.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

    //User login(String name,String pass);
    User login(@Param("name")String name , @Param("pass")String pass);

    List<User> getAll();

    List<String> username(@Param("nickname") String nickname);

    //新需求
    User login_name(@Param("name")String name , @Param("pass")String pass);
    User login_tel(@Param("name")String name , @Param("pass")String pass);
}