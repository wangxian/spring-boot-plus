/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : spring_boot_plus

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 07/03/2020 20:47:26
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for foo_bar
-- ----------------------------
DROP TABLE IF EXISTS `foo_bar`;
CREATE TABLE `foo_bar` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(20) NOT NULL COMMENT '名称',
  `foo` varchar(20) DEFAULT NULL COMMENT 'Foo',
  `bar` varchar(20) NOT NULL COMMENT 'Bar',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `state` int(11) NOT NULL DEFAULT '1' COMMENT '状态，0：禁用，1：启用',
  `version` int(11) NOT NULL DEFAULT '0' COMMENT '版本',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='FooBar';

-- ----------------------------
-- Records of foo_bar
-- ----------------------------
BEGIN;
INSERT INTO `foo_bar` VALUES (1, 'FooBar', 'foo', 'bar', 'remark...', 1, 0, '2019-11-01 14:05:14', NULL);
INSERT INTO `foo_bar` VALUES (2, 'HelloWorld', 'hello', 'world', NULL, 1, 0, '2019-11-01 14:05:14', NULL);
COMMIT;

-- ----------------------------
-- Table structure for ip
-- ----------------------------
DROP TABLE IF EXISTS `ip`;
CREATE TABLE `ip` (
  `ip_start` varchar(15) NOT NULL,
  `ip_end` varchar(15) NOT NULL,
  `area` varchar(100) NOT NULL,
  `operator` varchar(200) NOT NULL,
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ip_start_num` bigint(20) NOT NULL,
  `ip_end_num` bigint(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='IP地址';

-- ----------------------------
-- Table structure for sys_department
-- ----------------------------
DROP TABLE IF EXISTS `sys_department`;
CREATE TABLE `sys_department` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(32) NOT NULL COMMENT '部门名称',
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父id',
  `level` int(11) DEFAULT NULL COMMENT '部门层级',
  `state` int(11) NOT NULL DEFAULT '1' COMMENT '状态，0：禁用，1：启用',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `version` int(11) NOT NULL DEFAULT '0' COMMENT '版本',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sys_department_name_uindex` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='部门';

-- ----------------------------
-- Records of sys_department
-- ----------------------------
BEGIN;
INSERT INTO `sys_department` VALUES (1, '管理部', NULL, 1, 1, 0, NULL, 0, '2019-10-25 09:46:49', NULL);
INSERT INTO `sys_department` VALUES (2, '技术部', NULL, 1, 1, 0, NULL, 0, '2019-11-01 20:45:43', NULL);
INSERT INTO `sys_department` VALUES (20, '前端开发部', 2, 2, 1, 0, NULL, 0, '2019-11-01 20:48:38', NULL);
INSERT INTO `sys_department` VALUES (21, '后台开发部', 2, 2, 1, 0, NULL, 0, '2019-11-01 20:48:38', NULL);
INSERT INTO `sys_department` VALUES (22, '测试部', 2, 2, 1, 0, NULL, 0, '2019-11-01 20:48:38', NULL);
INSERT INTO `sys_department` VALUES (201, '前端一组', 20, 3, 1, 0, NULL, 0, '2019-11-01 20:48:38', NULL);
INSERT INTO `sys_department` VALUES (202, '前端二组', 20, 3, 1, 0, NULL, 0, '2019-11-01 20:48:38', NULL);
INSERT INTO `sys_department` VALUES (203, '后台一组', 21, 3, 1, 0, NULL, 0, '2019-11-01 20:48:38', NULL);
INSERT INTO `sys_department` VALUES (204, '后台二组', 21, 3, 1, 0, NULL, 0, '2019-11-01 20:48:38', NULL);
INSERT INTO `sys_department` VALUES (205, '测试一组', 22, 3, 1, 0, NULL, 0, '2019-11-01 20:48:38', NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log` (
  `log_id` bigint(18) NOT NULL COMMENT '主键',
  `type` tinyint(1) DEFAULT NULL COMMENT '类型',
  `content` varchar(255) DEFAULT NULL COMMENT '内容',
  `create_id` bigint(18) DEFAULT NULL COMMENT '创建人ID',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统日志';

-- ----------------------------
-- Records of sys_log
-- ----------------------------
BEGIN;
INSERT INTO `sys_log` VALUES (1060438746056376321, 0, 'A', 100000, '2018-11-08 15:41:58');
INSERT INTO `sys_log` VALUES (1060438788502732802, 0, 'B', 100000, '2018-11-08 15:42:08');
INSERT INTO `sys_log` VALUES (1060438799600861185, 0, 'C', 100000, '2018-11-08 15:42:10');
INSERT INTO `sys_log` VALUES (1060438809495224322, 0, 'D', 100000, '2018-11-08 15:42:13');
COMMIT;

-- ----------------------------
-- Table structure for sys_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_permission`;
CREATE TABLE `sys_permission` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(32) DEFAULT NULL COMMENT '权限名称',
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父id',
  `url` varchar(200) DEFAULT NULL COMMENT '路径',
  `code` varchar(100) NOT NULL COMMENT '唯一编码',
  `icon` varchar(100) DEFAULT NULL COMMENT '图标',
  `type` int(11) NOT NULL COMMENT '类型，1：菜单，2：按钮',
  `level` int(11) NOT NULL COMMENT '层级，1：第一级，2：第二级，N：第N级',
  `state` int(11) NOT NULL DEFAULT '1' COMMENT '状态，0：禁用，1：启用',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `version` int(11) NOT NULL DEFAULT '0' COMMENT '版本',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sys_permission_code_uindex` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统权限';

-- ----------------------------
-- Records of sys_permission
-- ----------------------------
BEGIN;
INSERT INTO `sys_permission` VALUES (1, '系统管理', NULL, NULL, 'system:management', NULL, 1, 1, 1, 0, NULL, 0, '2019-10-26 11:12:40', NULL);
INSERT INTO `sys_permission` VALUES (100, '用户管理', 1, NULL, 'sys:user:management', NULL, 1, 2, 1, 0, NULL, 0, '2019-10-26 11:15:48', NULL);
INSERT INTO `sys_permission` VALUES (200, '角色管理', 1, NULL, 'sys:role:management', NULL, 1, 2, 1, 0, NULL, 0, '2019-10-26 11:15:48', NULL);
INSERT INTO `sys_permission` VALUES (300, '权限管理', 1, NULL, 'sys:permission:management', NULL, 1, 2, 1, 0, NULL, 0, '2019-10-26 11:15:48', NULL);
INSERT INTO `sys_permission` VALUES (400, '部门管理', 1, NULL, 'sys:department:management', NULL, 1, 2, 1, 0, NULL, 0, '2019-10-26 11:15:48', NULL);
INSERT INTO `sys_permission` VALUES (1000, '用户新增', 100, NULL, 'sys:user:add', NULL, 2, 3, 1, 0, NULL, 0, '2019-10-26 11:18:40', NULL);
INSERT INTO `sys_permission` VALUES (1001, '用户修改', 100, NULL, 'sys:user:update', NULL, 2, 3, 1, 0, NULL, 0, '2019-10-26 11:18:40', NULL);
INSERT INTO `sys_permission` VALUES (1002, '用户删除', 100, NULL, 'sys:user:delete', NULL, 2, 3, 1, 0, NULL, 0, '2019-10-26 11:18:40', NULL);
INSERT INTO `sys_permission` VALUES (1003, '用户详情', 100, NULL, 'sys:user:info', NULL, 2, 3, 1, 0, NULL, 0, '2019-10-26 11:18:40', NULL);
INSERT INTO `sys_permission` VALUES (1004, '用户分页列表', 100, NULL, 'sys:user:page', NULL, 2, 3, 1, 0, NULL, 0, '2019-10-26 11:18:40', NULL);
INSERT INTO `sys_permission` VALUES (1005, '用户修改密码', 100, NULL, 'sys:user:update:password', NULL, 2, 3, 1, 0, NULL, 0, '2019-10-26 11:18:40', NULL);
INSERT INTO `sys_permission` VALUES (1006, '用户修改头像', 100, NULL, 'sys:user:update:head', NULL, 2, 3, 1, 0, NULL, 0, '2019-10-26 11:18:40', NULL);
INSERT INTO `sys_permission` VALUES (2000, '角色新增', 200, NULL, 'sys:role:add', NULL, 2, 3, 1, 0, NULL, 0, '2019-10-26 11:18:40', NULL);
INSERT INTO `sys_permission` VALUES (2001, '角色修改', 200, NULL, 'sys:role:update', NULL, 2, 3, 1, 0, NULL, 0, '2019-10-26 11:18:40', NULL);
INSERT INTO `sys_permission` VALUES (2002, '角色删除', 200, NULL, 'sys:role:delete', NULL, 2, 3, 1, 0, NULL, 0, '2019-10-26 11:18:40', NULL);
INSERT INTO `sys_permission` VALUES (2003, '角色详情', 200, NULL, 'sys:role:info', NULL, 2, 3, 1, 0, NULL, 0, '2019-10-26 11:18:40', NULL);
INSERT INTO `sys_permission` VALUES (2004, '角色分页列表', 200, NULL, 'sys:role:page', NULL, 2, 3, 1, 0, NULL, 0, '2019-10-26 11:18:40', NULL);
INSERT INTO `sys_permission` VALUES (3000, '权限新增', 300, NULL, 'sys:permission:add', NULL, 2, 3, 1, 0, NULL, 0, '2019-10-26 11:18:40', NULL);
INSERT INTO `sys_permission` VALUES (3001, '权限修改', 300, NULL, 'sys:permission:update', NULL, 2, 3, 1, 0, NULL, 0, '2019-10-26 11:18:40', NULL);
INSERT INTO `sys_permission` VALUES (3002, '权限删除', 300, NULL, 'sys:permission:delete', NULL, 2, 3, 1, 0, NULL, 0, '2019-10-26 11:18:40', NULL);
INSERT INTO `sys_permission` VALUES (3003, '权限详情', 300, NULL, 'sys:permission:info', NULL, 2, 3, 1, 0, NULL, 0, '2019-10-26 11:18:40', NULL);
INSERT INTO `sys_permission` VALUES (3004, '权限分页列表', 300, NULL, 'sys:permission:page', NULL, 2, 3, 1, 0, NULL, 0, '2019-10-26 11:18:40', NULL);
INSERT INTO `sys_permission` VALUES (3005, '权限所有列表', 300, NULL, 'sys:permission:all:menu:list', NULL, 2, 3, 1, 0, NULL, 0, '2019-10-26 11:18:40', NULL);
INSERT INTO `sys_permission` VALUES (3006, '权限所有树形列表', 300, NULL, 'sys:permission:all:menu:tree', NULL, 2, 3, 1, 0, NULL, 0, '2019-10-26 11:18:40', NULL);
INSERT INTO `sys_permission` VALUES (3007, '权限用户列表', 300, NULL, 'sys:permission:menu:list', NULL, 2, 3, 1, 0, NULL, 0, '2019-10-26 11:18:40', NULL);
INSERT INTO `sys_permission` VALUES (3008, '权限用户树形列表', 300, NULL, 'sys:permission:menu:tree', NULL, 2, 3, 1, 0, NULL, 0, '2019-10-26 11:18:40', NULL);
INSERT INTO `sys_permission` VALUES (3009, '权限用户代码列表', 300, NULL, 'sys:permission:codes', NULL, 2, 3, 1, 0, NULL, 0, '2019-10-26 11:18:40', NULL);
INSERT INTO `sys_permission` VALUES (4000, '部门新增', 400, NULL, 'sys:department:add', NULL, 2, 3, 1, 0, NULL, 0, '2019-10-26 11:18:40', NULL);
INSERT INTO `sys_permission` VALUES (4001, '部门修改', 400, NULL, 'sys:department:update', NULL, 2, 3, 1, 0, NULL, 0, '2019-10-26 11:18:40', NULL);
INSERT INTO `sys_permission` VALUES (4002, '部门删除', 400, NULL, 'sys:department:delete', NULL, 2, 3, 1, 0, NULL, 0, '2019-10-26 11:18:40', NULL);
INSERT INTO `sys_permission` VALUES (4003, '部门详情', 400, NULL, 'sys:department:info', NULL, 2, 3, 1, 0, NULL, 0, '2019-10-26 11:18:40', NULL);
INSERT INTO `sys_permission` VALUES (4004, '部门分页列表', 400, NULL, 'sys:department:page', NULL, 2, 3, 1, 0, NULL, 0, '2019-10-26 11:18:40', NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(32) NOT NULL COMMENT '角色名称',
  `code` varchar(100) DEFAULT NULL COMMENT '角色唯一编码',
  `type` int(11) DEFAULT NULL COMMENT '角色类型',
  `state` int(11) NOT NULL DEFAULT '1' COMMENT '角色状态，0：禁用，1：启用',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `version` int(11) NOT NULL DEFAULT '0' COMMENT '版本',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sys_role_name_uindex` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统角色';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_role` VALUES (1, '管理员', 'admin', NULL, 1, NULL, 0, '2019-10-25 09:47:21', NULL);
INSERT INTO `sys_role` VALUES (2, 'test', 'test', NULL, 1, NULL, 0, '2019-10-25 09:48:02', NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_permission`;
CREATE TABLE `sys_role_permission` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `role_id` bigint(20) NOT NULL COMMENT '角色id',
  `permission_id` bigint(20) NOT NULL COMMENT '权限id',
  `state` int(11) NOT NULL DEFAULT '1' COMMENT '状态，0：禁用，1：启用',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `version` int(11) NOT NULL DEFAULT '0' COMMENT '版本',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色权限关系';

-- ----------------------------
-- Records of sys_role_permission
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_permission` VALUES (1, 1, 1, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
INSERT INTO `sys_role_permission` VALUES (2, 1, 100, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
INSERT INTO `sys_role_permission` VALUES (3, 1, 200, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
INSERT INTO `sys_role_permission` VALUES (4, 1, 300, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
INSERT INTO `sys_role_permission` VALUES (5, 1, 400, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
INSERT INTO `sys_role_permission` VALUES (6, 1, 1000, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
INSERT INTO `sys_role_permission` VALUES (7, 1, 1001, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
INSERT INTO `sys_role_permission` VALUES (8, 1, 1002, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
INSERT INTO `sys_role_permission` VALUES (9, 1, 1003, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
INSERT INTO `sys_role_permission` VALUES (10, 1, 1004, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
INSERT INTO `sys_role_permission` VALUES (11, 1, 1005, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
INSERT INTO `sys_role_permission` VALUES (12, 1, 1006, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
INSERT INTO `sys_role_permission` VALUES (13, 1, 2000, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
INSERT INTO `sys_role_permission` VALUES (14, 1, 2001, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
INSERT INTO `sys_role_permission` VALUES (15, 1, 2002, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
INSERT INTO `sys_role_permission` VALUES (16, 1, 2003, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
INSERT INTO `sys_role_permission` VALUES (17, 1, 2004, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
INSERT INTO `sys_role_permission` VALUES (18, 1, 3000, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
INSERT INTO `sys_role_permission` VALUES (19, 1, 3001, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
INSERT INTO `sys_role_permission` VALUES (20, 1, 3002, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
INSERT INTO `sys_role_permission` VALUES (21, 1, 3003, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
INSERT INTO `sys_role_permission` VALUES (22, 1, 3004, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
INSERT INTO `sys_role_permission` VALUES (23, 1, 3005, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
INSERT INTO `sys_role_permission` VALUES (24, 1, 3006, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
INSERT INTO `sys_role_permission` VALUES (25, 1, 3007, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
INSERT INTO `sys_role_permission` VALUES (26, 1, 3008, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
INSERT INTO `sys_role_permission` VALUES (27, 1, 3009, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
INSERT INTO `sys_role_permission` VALUES (28, 1, 4001, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
INSERT INTO `sys_role_permission` VALUES (29, 1, 4002, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
INSERT INTO `sys_role_permission` VALUES (30, 1, 4003, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
INSERT INTO `sys_role_permission` VALUES (31, 1, 4004, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
INSERT INTO `sys_role_permission` VALUES (100, 1, 1, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
INSERT INTO `sys_role_permission` VALUES (101, 1, 100, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
INSERT INTO `sys_role_permission` VALUES (102, 1, 1000, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
INSERT INTO `sys_role_permission` VALUES (103, 1, 1001, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
INSERT INTO `sys_role_permission` VALUES (104, 1, 1002, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
INSERT INTO `sys_role_permission` VALUES (105, 1, 1003, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
INSERT INTO `sys_role_permission` VALUES (106, 1, 1004, 1, NULL, 0, '2019-10-26 22:16:19', NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `username` varchar(20) NOT NULL COMMENT '用户名',
  `nickname` varchar(20) DEFAULT NULL COMMENT '昵称',
  `password` varchar(64) NOT NULL COMMENT '密码',
  `salt` varchar(32) DEFAULT NULL COMMENT '盐值',
  `phone` varchar(20) NOT NULL COMMENT '手机号码',
  `gender` int(11) NOT NULL DEFAULT '1' COMMENT '性别，0：女，1：男，默认1',
  `head` varchar(200) DEFAULT NULL COMMENT '头像',
  `remark` varchar(200) DEFAULT NULL COMMENT 'remark',
  `state` int(11) NOT NULL DEFAULT '1' COMMENT '状态，0：禁用，1：启用，2：锁定',
  `department_id` bigint(20) NOT NULL COMMENT '部门id',
  `role_id` bigint(20) NOT NULL COMMENT '角色id',
  `deleted` int(11) NOT NULL DEFAULT '0' COMMENT '逻辑删除，0：未删除，1：已删除',
  `version` int(11) NOT NULL DEFAULT '0' COMMENT '版本',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sys_user_username_uindex` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统用户';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
INSERT INTO `sys_user` VALUES (1, 'admin', '管理员', '11a254dab80d52bc4a347e030e54d861a9d2cdb2af2185a9ca4a7318e830d04d', '666', '', 1, 'http://localhost:8888//resource/201910281559227.jpg', 'Administrator Account', 1, 1, 1, 0, 1, '2019-08-26 00:52:01', '2019-10-27 23:32:29');
INSERT INTO `sys_user` VALUES (2, 'test', '测试人员', '34783fb724b259beb71a1279f7cd93bdcfd92a273d566f926419a37825c500df', '087c2e9857f35f1e243367f3b89b81c1', '', 1, NULL, 'Tester Account', 1, 1, 2, 0, 0, '2019-10-05 14:04:27', NULL);
COMMIT;

-- ----------------------------
-- Table structure for t_notebook
-- ----------------------------
DROP TABLE IF EXISTS `t_notebook`;
CREATE TABLE `t_notebook` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `content` varchar(2000) DEFAULT NULL COMMENT '内容',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='记事本';

-- ----------------------------
-- Records of t_notebook
-- ----------------------------
BEGIN;
INSERT INTO `t_notebook` VALUES (1, 'DDI,第一篇日志标题', '这里详细的内容区域，第一次更改', '2020-03-01 15:16:37', '2020-03-01 15:17:09');
INSERT INTO `t_notebook` VALUES (2, 'string', 'string1', '2020-03-01 00:00:00', '2020-03-01 00:00:00');
INSERT INTO `t_notebook` VALUES (3, 'string', 'string2', '2020-03-01 00:00:00', '2020-03-01 00:00:00');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
