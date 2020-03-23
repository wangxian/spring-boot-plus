package com.example;

import io.webapp.framework.common.api.ApiResult;
import io.swagger.annotations.Api;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;

/**
 * @author geekidea
 * @date 2020/3/3
 **/
@Slf4j
@Api("Test")
@RestController
@RequestMapping("/test")
public class TestController {

    @Autowired
    private TestService testService;

    @PostMapping(value = "/test")
    public ApiResult test(String name) throws IOException {
        System.out.println("name = " + name);
        return ApiResult.ok("hello:" + name);
    }

}
