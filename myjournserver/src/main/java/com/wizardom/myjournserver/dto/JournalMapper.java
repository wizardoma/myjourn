package com.wizardom.myjournserver.dto;


import com.wizardom.myjournserver.model.Journal;

import java.time.Instant;
/**
 * @author Ibekason Alexander Onyebuchi
 */
public class JournalMapper {
    public static Journal fromDto(JournalDto dto){
        return new Journal().setBody(dto.getBody())
                .setDbId(dto.getDbId())
                .setImages(dto.getImages())
                .setDate(Instant.ofEpochMilli(Long.parseLong(dto.getDate())));

    }

    public static JournalDto toDto(Journal journal){
        return new JournalDto().setId(journal.getId())
                .setDbId(journal.getDbId())
                .setDate(String.valueOf(journal.getDate().toEpochMilli()))
                .setImages(journal.getImages())
                .setBody(journal.getBody())
                .setUser(UserMapper.toDto(journal.getUser()));
    }
}
