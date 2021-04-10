package com.wizardom.myjournserver.dto;

import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;
/**
 * @author Ibekason Alexander Onyebuchi
 */
@Accessors(chain = true)
@Data
public class JournalDto {
    private long id;
    private long dbId;
    private String body;
    private String date;
    private UserDto user;
    private List<String> images;
}
