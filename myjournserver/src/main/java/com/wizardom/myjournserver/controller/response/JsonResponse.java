package com.wizardom.myjournserver.controller.response;

import lombok.Data;
import lombok.experimental.Accessors;
import org.springframework.http.HttpStatus;

import java.util.Map;

@Data
@Accessors(chain = true)
public class JsonResponse<T> {
    private T body;
    private int status;
    private Map<String, String> errors;

    public JsonResponse(HttpStatus status){
        this.status = status.value();
    }

    public JsonResponse(HttpStatus status, T body){
        this.status = status.value();
        this.body = body;
    }

    public JsonResponse(HttpStatus status, Map<String, String> errors){
        this.status = status.value();
        this.errors = errors;
    }
}
