package com.wizardom.myjournserver.controller;

import com.wizardom.myjournserver.controller.request.JournalDto;
import com.wizardom.myjournserver.controller.request.JournalMapper;
import com.wizardom.myjournserver.model.Journal;
import com.wizardom.myjournserver.service.JournalService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.net.URI;
import java.text.ParseException;

@Slf4j
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
    public ResponseEntity<?> saveJournal(@Valid @ModelAttribute JournalDto journal) throws ParseException {
        return ResponseEntity.created(URI.create("")).body(JournalMapper.toDto(journalService.save(JournalMapper.toJournal(journal))));
    }

    @DeleteMapping("{id}")
    public ResponseEntity<?> deleteJournal(@PathVariable("id") long id) {
        journalService.delete(id);
        return ResponseEntity.ok(null);
    }

    @GetMapping("{id}")
    public ResponseEntity<?> getJournalByID(@PathVariable("id") long id) {
        return ResponseEntity.ok(JournalMapper.toDto(journalService.getById(id)));
    }

}
