package com.hospital.user.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hospital.user.entity.User;

/**
 * 用户Mapper接口
 * 继承自MyBatis-Plus的BaseMapper
 * 提供用户表的基本CRUD操作
 */
public interface UserMapper extends BaseMapper<User> {
    // 这里可以定义额外的数据库操作方法
    // 例如复杂查询、批量操作等
}