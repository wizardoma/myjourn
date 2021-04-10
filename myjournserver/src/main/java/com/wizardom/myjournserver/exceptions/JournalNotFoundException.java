package com.wizardom.myjournserver.exceptions;

public class JournalNotFoundException extends ResourceNotFoundException {
    public JournalNotFoundException(String message) {
        super(message);
    }
}
