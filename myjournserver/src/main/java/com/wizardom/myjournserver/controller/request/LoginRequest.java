package com.wizardom.myjournserver.controller.request;

import lombok.Data;
import lombok.experimental.Accessors;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

@Data
@Accessors(chain = true)
public class LoginRequest {
    @NotEmpty(message = "Email cannot be empty")
    @Email(message = "Please use a valid email address")
    private String email;
    @NotEmpty(message = "Password cannot be empty")
    @Size(min = 4, message = "Password must be over 4 digits")
    private String password;


}
