package com.wizardom.myjournserver.dto;

import com.wizardom.myjournserver.model.User;
import lombok.Data;
import lombok.experimental.Accessors;

import java.time.Instant;
import java.util.List;

@Accessors(chain = true)
@Data
public class JournalDto {
    private long id;
    private long dbId;
    private String body;
    private Instant date;
    private UserDto user;
    private List<String> images;
}
