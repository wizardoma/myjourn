package com.wizardom.myjournserver.service;

import com.wizardom.myjournserver.model.Journal;
import com.wizardom.myjournserver.repository.JournalRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;

@RequiredArgsConstructor
@Service
public class JournalService {
    private final JournalRepository journalRepository;

    public Journal save(Journal journal){
        return journalRepository.save(journal);
    }

    public Journal edit(long id, String body, LocalDateTime time, List<MultipartFile> images){
        Journal journal = journalRepository.findById(id).get()
                .setBody(body)
                .setDate(time)
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
