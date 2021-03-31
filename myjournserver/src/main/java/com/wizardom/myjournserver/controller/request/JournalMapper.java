package com.wizardom.myjournserver.controller.request;


import com.wizardom.myjournserver.model.Journal;

import java.text.ParseException;
import java.time.Instant;

public class JournalMapper {

    public static Journal toJournal(JournalDto dto) throws ParseException {
        return new Journal()
                .setImages(dto.getImages())
                .setDate(Instant.ofEpochMilli(Long.parseLong(dto.getDate())))
                .setBody(dto.getBody());
    }

    public static JournalDto toDto(Journal journal) {
        return new JournalDto()
                .setBody(journal.getBody())
                .setDate(journal.getDate().toString())
                .setImages(journal.getImages());
    }
}
