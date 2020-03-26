package io.webapp.resource.controller;

import io.webapp.framework.common.api.ApiResult;
import io.webapp.framework.core.properties.SpringBootPlusProperties;
import io.webapp.framework.util.UploadUtil;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * 上传控制器
 * @author geekidea
 * @date 2019/8/20
 * @since 1.2.1-RELEASE
 */
@Slf4j
@RestController
@RequestMapping("/upload")
public class UploadController {

    @Autowired
    private SpringBootPlusProperties springBootPlusProperties;

    /**
     * 上传单个文件
     */
    @PostMapping
    @ApiOperation(value = "上传单个文件",notes = "上传单个文件",response = ApiResult.class)
    public ApiResult<Boolean> upload(@RequestParam("file") MultipartFile multipartFile,
                                     @RequestParam("type") String type) throws Exception{
        log.info("multipartFile = " + multipartFile);
        log.info("ContentType = " + multipartFile.getContentType());
        log.info("OriginalFilename = " + multipartFile.getOriginalFilename());
        log.info("Name = " + multipartFile.getName());
        log.info("Size = " + multipartFile.getSize());
        log.info("type = " + type);

        // 上传文件，返回保存的文件名称
        String saveFileName = UploadUtil.upload(springBootPlusProperties.getUploadPath(), multipartFile, originalFilename -> {
            // 文件后缀
            String fileExtension= FilenameUtils.getExtension(originalFilename);
            // 这里可自定义文件名称，比如按照业务类型/文件格式/日期
            String dateString = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmssS"));
            String fileName = dateString + "." +fileExtension;
            return fileName;
        });

        // 上传成功之后，返回访问路径，请根据实际情况设置

        String fileAccessPath = springBootPlusProperties.getResourceAccessUrl() + saveFileName;
        log.info("fileAccessPath:{}",fileAccessPath);

        return ApiResult.ok(fileAccessPath);
    }

}
