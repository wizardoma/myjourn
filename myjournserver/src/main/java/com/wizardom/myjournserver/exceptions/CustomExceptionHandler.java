package com.wizardom.myjournserver.exceptions;

import com.wizardom.myjournserver.controller.response.JsonResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.validation.BindException;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

@ControllerAdvice
@Slf4j
public class CustomExceptionHandler extends ResponseEntityExceptionHandler {

    @Override
    protected ResponseEntity<Object> handleBindException(BindException ex, HttpHeaders headers, HttpStatus status, WebRequest request) {
        Map<String, String> errorMap = new HashMap<>();

        for (FieldError error : ex.getBindingResult().getFieldErrors()) {
            errorMap.put("field." + error.getField(), error.getDefaultMessage());
        }

        for (ObjectError error : ex.getBindingResult().getGlobalErrors()) {
            errorMap.put("field." + error.getObjectName(), error.getDefaultMessage());

        }
        return handleExceptionInternal(ex, new JsonResponse<>(status).setErrors(errorMap), headers, status, request);

    }

    @ExceptionHandler(ConstraintViolationException.class)
    public ResponseEntity<?> handleConstraintViolation(ConstraintViolationException exception){
        Map<String, String> errorMap = new HashMap<>();

        for (ConstraintViolation violation : exception.getConstraintViolations()){
            errorMap.put("field.error", violation.getMessage());
        }

        return respondToException(HttpStatus.BAD_REQUEST, errorMap);

    }

    @ExceptionHandler(BadCredentialsException.class)
    public ResponseEntity<?> handleBadCredentials(BadCredentialsException exception){
        String error = exception.getMessage();
        Map<String, String> errorMap = Collections.singletonMap("authentication.error", error);
        return respondToException(HttpStatus.FORBIDDEN,errorMap);

    }

    @ExceptionHandler(UserNotFoundException.class)
    public ResponseEntity<?> handleUserNotFound(UserNotFoundException exception){
        String error = exception.getMessage();
        return respondToException(HttpStatus.NOT_FOUND,Collections.singletonMap("user.notfound", error));
    }

    ResponseEntity<?> respondToException(HttpStatus status, Map<String, String> errors){
        return new ResponseEntity<>(new JsonResponse<>(status).setErrors(errors),status);
    }
}
