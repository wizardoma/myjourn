package com.wizardom.myjournserver.controller.request;

import com.wizardom.myjournserver.validation.UniqueEmail;
import com.wizardom.myjournserver.validation.UniqueUsername;
import com.wizardom.myjournserver.validation.ValidSignUpType;
import lombok.Data;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;
/**
 * @author Ibekason Alexander Onyebuchi
 */
@Data
public class SignUpRequest {
    @NotEmpty(message = "email cannot be empty")
    @Email(message = "Please use a valid email address")
    @UniqueEmail
    private String email;
    @Size(min = 4, max = 40, message = "Password must be at least 4 letters")
    private String password;
    @NotEmpty(message = "Username cannot be empty")
    @UniqueUsername
    private String username;
    @ValidSignUpType
    private String signUpType;
}
