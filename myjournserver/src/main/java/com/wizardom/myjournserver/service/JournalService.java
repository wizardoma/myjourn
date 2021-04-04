package com.wizardom.myjournserver.service;

import com.wizardom.myjournserver.controller.request.CreateJournalRequest;
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

    public Journal save(CreateJournalRequest request){
        Journal journal = new Journal().setUser(userService.getCurrentUser()).setBody(request.getBody())
                .setImages(request.getImages())
                .setDate(Instant.ofEpochMilli(Long.parseLong(request.getDate())));
        return journalRepository.save(journal);
    }

    public Journal edit(long id, String body, String time, List<MultipartFile> images){

        Journal journal = journalRepository.findById(id).get()
                .setBody(body)
                .setDate(Instant.ofEpochMilli(Long.parseLong(time)))
                .setImages(Collections.emptyList());
        return journalRepository.save(journal);
    }

    public void delete(long id){
        journalRepository.delete(journalRepository.findById(id).get());
    }


    public Journal getById(long id){
        return journalRepository.findById(id).get();
    }

    public List<Journal> getAll() {
        return journalRepository.findAll();
    }
}
