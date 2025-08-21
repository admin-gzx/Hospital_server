CREATE TABLE IF NOT EXISTS `sys_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(100) NOT NULL COMMENT '密码',
  `real_name` varchar(50) DEFAULT NULL COMMENT '真实姓名',
  `department` varchar(50) DEFAULT NULL COMMENT '部门',
  `position` varchar(50) DEFAULT NULL COMMENT '职位',
  `phone` varchar(20) DEFAULT NULL COMMENT '电话',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `status` int(11) DEFAULT '1' COMMENT '状态(0:禁用,1:启用)',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- 初始化管理员账号
INSERT INTO `sys_user` (`username`, `password`, `real_name`, `department`, `position`, `phone`, `email`, `status`, `role_id`) 
VALUES ('admin', '$2a$10$7JB720yOZir6d1IRUKY7C.oyqyP6RAxZJ3.Ggzr5W8wrwCskF59e', '管理员', '信息科', '系统管理员', '13800138000', 'admin@hospital.com', 1, 1);

-- 创建角色表
CREATE TABLE sys_role (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '角色ID',
    name VARCHAR(50) NOT NULL COMMENT '角色名称',
    description VARCHAR(255) COMMENT '角色描述',
    status TINYINT DEFAULT 1 COMMENT '角色状态(0:禁用,1:启用)',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    UNIQUE KEY uk_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色表';

-- 初始化角色数据
INSERT INTO sys_role (name, description, status)
VALUES ('ADMIN', '管理员角色，拥有所有权限', 1),
       ('DOCTOR', '医生角色，负责患者诊疗', 1),
       ('NURSE', '护士角色，协助医生工作', 1),
       ('PATIENT', '患者角色，查看个人信息', 1);

-- 创建权限表
CREATE TABLE sys_permission (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '权限ID',
    name VARCHAR(50) NOT NULL COMMENT '权限名称',
    description VARCHAR(255) COMMENT '权限描述',
    permission VARCHAR(100) COMMENT '权限标识',
    resource_type VARCHAR(20) COMMENT '资源类型(menu:菜单, button:按钮)',
    resource_path VARCHAR(255) COMMENT '资源路径',
    parent_id BIGINT DEFAULT 0 COMMENT '父权限ID',
    sort INT DEFAULT 0 COMMENT '排序',
    status TINYINT DEFAULT 1 COMMENT '状态(0:禁用,1:启用)',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    UNIQUE KEY uk_permission (permission)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='权限表';

-- 创建角色权限关联表
CREATE TABLE sys_role_permission (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键ID',
    role_id BIGINT NOT NULL COMMENT '角色ID',
    permission_id BIGINT NOT NULL COMMENT '权限ID',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    UNIQUE KEY uk_role_permission (role_id, permission_id),
    FOREIGN KEY (role_id) REFERENCES sys_role(id) ON DELETE CASCADE,
    FOREIGN KEY (permission_id) REFERENCES sys_permission(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色权限关联表';

-- 初始化权限数据
INSERT INTO sys_permission (name, description, permission, resource_type, resource_path, parent_id, sort, status)
VALUES ('用户管理', '用户管理菜单', 'menu:user', 'menu', '/api/users', 0, 1, 1),
       ('用户列表', '查看用户列表', 'user:list', 'button', '/api/users', 1, 1, 1),
       ('添加用户', '添加新用户', 'user:add', 'button', '/api/users', 1, 2, 1),
       ('编辑用户', '编辑用户信息', 'user:edit', 'button', '/api/users/{id}', 1, 3, 1),
       ('删除用户', '删除用户', 'user:delete', 'button', '/api/users/{id}', 1, 4, 1),
       ('角色管理', '角色管理菜单', 'menu:role', 'menu', '/api/roles', 0, 2, 1),
       ('角色列表', '查看角色列表', 'role:list', 'button', '/api/roles', 6, 1, 1),
       ('添加角色', '添加新角色', 'role:add', 'button', '/api/roles', 6, 2, 1),
       ('编辑角色', '编辑角色信息', 'role:edit', 'button', '/api/roles/{id}', 6, 3, 1),
       ('删除角色', '删除角色', 'role:delete', 'button', '/api/roles/{id}', 6, 4, 1),
       ('权限管理', '权限管理菜单', 'menu:permission', 'menu', '/api/permissions', 0, 3, 1);

-- 给管理员角色分配所有权限
INSERT INTO sys_role_permission (role_id, permission_id)
SELECT r.id, p.id FROM sys_role r, sys_permission p
WHERE r.name = 'ADMIN';

-- 给医生角色分配部分权限
INSERT INTO sys_role_permission (role_id, permission_id)
SELECT r.id, p.id FROM sys_role r, sys_permission p
WHERE r.name = 'DOCTOR' AND p.permission IN ('user:list');

-- 给护士角色分配部分权限
INSERT INTO sys_role_permission (role_id, permission_id)
SELECT r.id, p.id FROM sys_role r, sys_permission p
WHERE r.name = 'NURSE' AND p.permission IN ('user:list');

-- 给患者角色分配部分权限
INSERT INTO sys_role_permission (role_id, permission_id)
SELECT r.id, p.id FROM sys_role r, sys_permission p
WHERE r.name = 'PATIENT' AND p.permission IN ('user:list');