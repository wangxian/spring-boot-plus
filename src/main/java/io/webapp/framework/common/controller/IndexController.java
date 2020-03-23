package io.webapp.framework.common.controller;

import io.webapp.framework.common.api.ApiResult;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import springfox.documentation.annotations.ApiIgnore;

@RestController
@ApiIgnore
@Slf4j
public class IndexController {

    @RequestMapping("/")
    public ApiResult<String> index() {
        // log.debug("index...");
        return ApiResult.ok("200 OK");
    }
}
