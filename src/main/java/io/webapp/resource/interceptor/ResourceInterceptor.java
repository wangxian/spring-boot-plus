package io.webapp.resource.interceptor;

import io.webapp.framework.common.api.ApiResult;
import io.webapp.framework.core.properties.SpringBootPlusProperties;
import io.webapp.framework.util.HttpServletResponseUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 资源拦截器
 * @author geekidea
 * @date 2019/8/20
 * @since 1.2.1-RELEASE
 */
@Slf4j
@ConditionalOnProperty(value = {"spring-boot-plus.interceptor.resource.enable"}, matchIfMissing = true)
public class ResourceInterceptor extends HandlerInterceptorAdapter {

    @Autowired
    private SpringBootPlusProperties springBootPlusProperties;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 如果访问的控制器,则跳出,继续执行下一个拦截器
        if (handler instanceof HandlerMethod) {
            return true;
        }
        // 访问路径
        String url = request.getRequestURI();
        // 访问全路径
        String fullUrl = request.getRequestURL().toString();

        // 未启用资源访问时，返回错误消息
        if (!springBootPlusProperties.getInterceptor().getResource().isEnable()){
            log.error("资源访问已关闭，非法访问：{}",fullUrl);
            HttpServletResponseUtil.printJson(response,ApiResult.fail("非法访问"));
            return false;
        }

        // 资源拦截器，业务处理代码
        log.info("ResourceInterceptor...");

        // 访问token，如果需要，可以设置参数，进行鉴权
        String token = request.getParameter("token");

        log.info("url:{}",url);
        log.info("fullUrl:{}",fullUrl);
        log.info("token:{}",token);

        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        // 记录实际访问图片日志...
    }
}
