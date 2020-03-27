package io.webapp.framework.filter;

import io.webapp.framework.core.properties.SpringBootPlusFilterProperties;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.ArrayUtils;
import org.springframework.util.AntPathMatcher;
import org.springframework.util.PathMatcher;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Arrays;

@Slf4j
public class RequestPathFilter implements Filter {

    private static String[] excludePaths;

    private boolean isEnable;

    public RequestPathFilter(SpringBootPlusFilterProperties.FilterConfig filterConfig) {
        isEnable    = filterConfig.isEnable();
        excludePaths = filterConfig.getExcludePaths();
        log.debug("isEnabled:" + isEnable);
        log.debug("excludePaths:" + Arrays.toString(excludePaths));
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        if (!isEnable) {
            chain.doFilter(request, response);
            return;
        }

        HttpServletRequest req = (HttpServletRequest) request;
        String path = req.getServletPath();
        String url = req.getRequestURL().toString();

        PathMatcher pathMatcher = new AntPathMatcher();
        boolean isOut = true;

        if (ArrayUtils.isNotEmpty(excludePaths)) {
            for (String pattern : excludePaths) {
                if (pathMatcher.match(pattern, path)) {
                    isOut = false;
                    break;
                }
            }
        }

        if (isOut) {
            log.debug(url);
        }

        chain.doFilter(req, response);
    }

    @Override
    public void destroy() {

    }
}