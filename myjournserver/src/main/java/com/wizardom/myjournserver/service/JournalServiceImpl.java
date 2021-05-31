package com.wizardom.myjournserver.service;

import com.wizardom.myjournserver.controller.request.CreateJournalRequest;
import com.wizardom.myjournserver.controller.request.EditJournalRequest;
import com.wizardom.myjournserver.exceptions.JournalNotFoundException;
import com.wizardom.myjournserver.model.Journal;
import com.wizardom.myjournserver.model.User;
import com.wizardom.myjournserver.repository.JournalRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.List;
import java.util.Optional;

/**
 * @author Ibekason Alexander Onyebuchi
 */

@RequiredArgsConstructor
@Service
public class JournalServiceImpl implements JournalService {
    private final JournalRepository journalRepository;
    private final UserService userService;

    public Journal save(CreateJournalRequest request) {
        User user = userService.getCurrentUser();
        Optional<Journal> findJournal = journalRepository.findByDbId(request.getDbId());
        if (findJournal.isPresent()) {
            return edit(findJournal.get().getId(), new EditJournalRequest()
                    .setBody(request.getBody())
                    .setDate(request.getDate())
                    .setImages(request.getImages()));
        }

        Journal journal = new Journal().setUser(user).setBody(request.getBody())
                .setImages(request.getImages())
                .setDbId(request.getDbId())
                .setDate(Instant.ofEpochMilli(Long.parseLong(request.getDate())));
        return journalRepository.save(journal);
    }

    public Journal edit(long id, EditJournalRequest request) {
        Journal journal = journalRepository.findById(id).orElseThrow(() -> new JournalNotFoundException("No Journal Found"));
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

    public List<Journal> getJournalsByUser() {
        return journalRepository.findByUser(userService.getCurrentUser());
    }


}
