package com.wizardom.myjournserver.controller;

import com.wizardom.myjournserver.controller.request.CreateJournalRequest;
import com.wizardom.myjournserver.controller.response.JsonResponse;
import com.wizardom.myjournserver.dto.JournalMapper;
import com.wizardom.myjournserver.model.Journal;
import com.wizardom.myjournserver.service.JournalService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.text.ParseException;

import static org.springframework.http.HttpStatus.CREATED;

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
    public ResponseEntity<JsonResponse<?>> saveJournal(@Valid @ModelAttribute CreateJournalRequest request) throws ParseException {
        Journal journal = journalService.save(request);
        return new ResponseEntity<>(new JsonResponse<>(CREATED, JournalMapper.toDto(journal)),
                CREATED);
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
