package com.wizardom.myjournserver.controller.request;

import lombok.Data;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

@Data
public class SignUpRequest {
    @NotEmpty(message = "email cannot be empty")

    private String email;
    @Size(min = 4, max= 40, message = "Password must be more than 3 letters")

    private String password;
    @NotEmpty
    private String signUpType;
}
