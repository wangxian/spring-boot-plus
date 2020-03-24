package io.webapp;

import io.webapp.framework.util.PrintApplicationInfo;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.transaction.annotation.EnableTransactionManagement;

/**
 * spring-boot-plus 项目启动入口
 *
 * @author geekidea
 * @since 2018-11-08
 */
@EnableAsync
// @EnableScheduling
// @EnableAdminServer
@EnableTransactionManagement
@EnableConfigurationProperties
@MapperScan({"io.webapp.**.mapper", "com.example.**.mapper"})
@ServletComponentScan
@SpringBootApplication(scanBasePackages = {"io.webapp", "com.example"})
public class WebappApplication {

    public static void main(String[] args) {
        // 启动spring-boot-plus
        ConfigurableApplicationContext context = SpringApplication.run(WebappApplication.class, args);

        // 打印项目信息
        PrintApplicationInfo.print(context);
    }
}
