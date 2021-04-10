package com.wizardom.myjournserver.exceptions;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ResourceNotFoundException extends RuntimeException {
    private String message;

    ResourceNotFoundException(String message) {
        super(message);
        this.message = message;
    }
}
