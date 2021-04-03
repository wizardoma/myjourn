package com.wizardom.myjournserver.dto;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class UserDto {
    private String email;
    private String password;
}
