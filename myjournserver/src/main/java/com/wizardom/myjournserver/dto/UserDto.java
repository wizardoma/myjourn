package com.wizardom.myjournserver.dto;

import lombok.Data;
import lombok.experimental.Accessors;
/**
 * @author Ibekason Alexander Onyebuchi
 */
@Data
@Accessors(chain = true)
public class UserDto {
    private long id;
    private String email;
    private String username;
}
