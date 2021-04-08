package com.wizardom.myjournserver.exceptions;

public class JournalNotFoundException extends RuntimeException {
    public JournalNotFoundException(String message) {
        super(message);
    }
}
