package com.wizardom.myjournserver.controller.request;

import com.wizardom.myjournserver.validation.UniqueEmail;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class VerifyEmailRequest {
    @UniqueEmail
    private String email;
}
