package com.wizardom.myjournserver.service;

import com.wizardom.myjournserver.controller.request.CreateJournalRequest;
import com.wizardom.myjournserver.exceptions.JournalNotFoundException;
import com.wizardom.myjournserver.model.Journal;
import com.wizardom.myjournserver.repository.JournalRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.time.Instant;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.Date;
import java.util.List;

@RequiredArgsConstructor
@Service
public class JournalService {
    private final JournalRepository journalRepository;
    private final UserService userService;

    public Journal save(CreateJournalRequest request) {
        Journal journal = new Journal().setUser(userService.getCurrentUser()).setBody(request.getBody())
                .setImages(request.getImages())
                .setDbId(request.getDbId())
                .setDate(Instant.ofEpochMilli(Long.parseLong(request.getDate())));
        return journalRepository.save(journal);
    }

    public Journal edit(CreateJournalRequest request) {

        Journal journal = journalRepository.findById(request.getDbId()).orElseThrow(() -> new JournalNotFoundException("No Journal Found with dbId " + request.getDbId()));
        journal
                .setBody(request.getBody())
                .setDate(Instant.ofEpochMilli(Long.parseLong(request.getDate())))
                .setImages(request.getImages());
        return journalRepository.save(journal);
    }

    public void delete(long id) {
        journalRepository.delete(journalRepository.findByDbId(id).orElseThrow(() -> new JournalNotFoundException("Journal not found")));
    }


    public Journal getById(long id) {
        return journalRepository.findById(id).get();
    }

    public List<Journal> getAll() {
        return journalRepository.findAll();
    }

    public List<Journal> getUserJournals() {
        return journalRepository.findByUser(userService.getCurrentUser());
    }


}
