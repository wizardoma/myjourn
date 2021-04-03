package com.wizardom.myjournserver.exceptions;

import lombok.Data;
import lombok.Getter;

@Getter

public class UserNotFoundException extends RuntimeException{
    private final String message;

    public UserNotFoundException(String message) {
        super(message);
        this.message = message;
    }
}
