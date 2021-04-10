package com.wizardom.myjournserver.dto;

import com.wizardom.myjournserver.model.User;
/**
 * @author Ibekason Alexander Onyebuchi
 */
public class UserMapper {
    public static User fromDto(UserDto userDto) {
        return new User().setEmail(userDto.getEmail()).setUsername(userDto.getUsername());
    }

    public static UserDto toDto(User user) {
        return new UserDto().setEmail(user.getEmail()).setId(user.getId()).setUsername(user.getUsername());
    }
}
