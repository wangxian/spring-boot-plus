package io.webapp.framework.shiro.util;

import io.webapp.framework.constant.CommonRedisKey;
import io.webapp.framework.shiro.vo.LoginSysUserRedisVo;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class LoginUtil {

    @Autowired
    private static RedisTemplate redisTemplate;

    // public LoginUtil(RedisTemplate redisTemplate) {
    //     LoginUtil.redisTemplate = redisTemplate;
    // }


    /**
     * 获取当前登陆用户对象
     *
     * @return
     */
    public static LoginSysUserRedisVo getLoginSysUserRedisVo() {
        // 获取当前登陆用户
        String token = JwtTokenUtil.getToken();
        String username = JwtUtil.getUsername(token);
        if (StringUtils.isBlank(username)) {
            return null;
        }
        return (LoginSysUserRedisVo) redisTemplate.opsForValue().get(String.format(CommonRedisKey.LOGIN_USER, username));
    }

    /**
     * 获取当前登陆用户的ID
     *
     * @return
     */
    public static Long getUserId() {
        LoginSysUserRedisVo loginSysUserRedisVo = getLoginSysUserRedisVo();
        if (loginSysUserRedisVo == null) {
            return null;
        }
        return loginSysUserRedisVo.getId();
    }

    /**
     * 获取当前登陆用户的账号
     *
     * @return
     */
    public static String getUsername() {
        LoginSysUserRedisVo loginSysUserRedisVo = getLoginSysUserRedisVo();
        if (loginSysUserRedisVo == null) {
            return null;
        }
        return loginSysUserRedisVo.getUsername();
    }

}
