package com.wizardom.myjournserver.dto;


import com.wizardom.myjournserver.model.Journal;

public class JournalMapper {
    public static Journal fromDto(JournalDto dto){
        return new Journal().setBody(dto.getBody())
                .setImages(dto.getImages())
                .setDate(dto.getDate());

    }

    public static JournalDto toDto(Journal journal){
        return new JournalDto().setId(journal.getId())
                .setDate(journal.getDate())
                .setImages(journal.getImages())
                .setBody(journal.getBody())
                .setUser(journal.getUser());
    }
}
