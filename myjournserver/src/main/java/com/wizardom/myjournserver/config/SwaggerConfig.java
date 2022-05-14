package com.wizardom.myjournserver.config;

import com.google.common.collect.Lists;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.bind.annotation.RequestMethod;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.builders.ResponseMessageBuilder;
import springfox.documentation.service.*;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spi.service.contexts.SecurityContext;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger.web.SecurityConfiguration;
import springfox.documentation.swagger.web.SecurityConfigurationBuilder;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

import java.util.*;

import static springfox.documentation.builders.PathSelectors.regex;

@Configuration
@EnableSwagger2
public class SwaggerConfig {

    @Bean
    public Docket api(){
        return new Docket(DocumentationType.SWAGGER_2)
                .select()
                .apis(RequestHandlerSelectors.any())
                .paths(PathSelectors.any())
                .build()
                .apiInfo(apiInfo())
                .useDefaultResponseMessages(false)
                .globalResponseMessage(RequestMethod.GET, responseMessages());
    }


    private ApiInfo apiInfo() {
        return  new ApiInfo("REST API for the MyJourn Application",
                "This Api describes the various endpoints of interacting with the MyJourn Application",
                "1.0",
                "",
                new Contact("UzuCorp", "http://uzucorp.com","alibekason@gmail.com"),
                "",
                "",
                Collections.emptyList());
    }

    private List<ResponseMessage> responseMessages() {
        List<ResponseMessage> responseMessages = new ArrayList<>();
        responseMessages.add(new ResponseMessageBuilder().code(500).message("A problem with server/backend").build());
        responseMessages.add(new ResponseMessageBuilder().code(400).message("Bad Request. Server rejected Request format").build());
        responseMessages.add(new ResponseMessageBuilder().code(401).message("Server rejected the credentials provided and couldn't Authenticate Request").build());
        responseMessages.add(new ResponseMessageBuilder().code(403).message("Server could not authorize the request").build());
        responseMessages.add(new ResponseMessageBuilder().code(200).message("Request was successful").build());
        responseMessages.add(new ResponseMessageBuilder().code(201).message("Resource created successfully").build());
        responseMessages.add(new ResponseMessageBuilder().code(404).message("No Page/Response for request found").build());
        responseMessages.add(new ResponseMessageBuilder().code(406).message("Server couldn't accept request").build());
        return responseMessages;






    }



}
