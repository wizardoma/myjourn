package com.wizardom.myjournserver.controller;

import com.wizardom.myjournserver.model.Journal;
import com.wizardom.myjournserver.service.JournalService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.net.URI;

@RequiredArgsConstructor
@RestController
@RequestMapping("/journals")
public class JournalController {

    private final JournalService journalService;

    @GetMapping
    public ResponseEntity<?> getJournals() {
        return ResponseEntity.ok(journalService.getAll());
    }

    @PostMapping
    public ResponseEntity<Journal> saveJournal(@Valid @ModelAttribute Journal journal) {
        return ResponseEntity.created(URI.create("")).body(journalService.save(journal));
    }

    @DeleteMapping("{id}")
    public ResponseEntity<?> deleteJournal(@PathVariable("id") long id) {
        journalService.delete(id);
        return ResponseEntity.ok(null);
    }

    @GetMapping("{id}")
    public ResponseEntity<Journal> getJournalByID(@PathVariable("id") long id) {
        return ResponseEntity.ok(journalService.getById(id));
    }


}
