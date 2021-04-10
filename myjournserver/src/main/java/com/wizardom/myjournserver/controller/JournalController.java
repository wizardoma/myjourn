package com.wizardom.myjournserver.controller;

import com.wizardom.myjournserver.controller.request.CreateJournalRequest;
import com.wizardom.myjournserver.controller.response.JsonResponse;
import com.wizardom.myjournserver.dto.JournalDto;
import com.wizardom.myjournserver.dto.JournalMapper;
import com.wizardom.myjournserver.model.Journal;
import com.wizardom.myjournserver.service.JournalService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.text.ParseException;
import java.util.List;
import java.util.stream.Collectors;

import static org.springframework.http.HttpStatus.CREATED;
import static org.springframework.http.HttpStatus.OK;
/**
 * @author Ibekason Alexander Onyebuchi
 */
@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/journals")
public class JournalController {

    private final JournalService journalService;

    @GetMapping
    public ResponseEntity<JsonResponse<?>> getJournals() {
        List<JournalDto> journalDtos = journalService.getUserJournals().stream()
                .map(JournalMapper::toDto).collect(Collectors.toList());
        return ResponseEntity.ok(new JsonResponse<>(OK, journalDtos));
    }

    @PostMapping
    public ResponseEntity<JsonResponse<?>> saveJournal(@Valid @ModelAttribute CreateJournalRequest request) throws ParseException {
        log.info("Journal from app "+request.toString());
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
    public ResponseEntity<JsonResponse<?>> getJournalByID(@PathVariable("id") long id) {
        JournalDto journalDto = JournalMapper.toDto(journalService.getById(id));
        return ResponseEntity.ok(new JsonResponse<>(OK, journalDto));
    }
    
    @PatchMapping("{id}")
    public ResponseEntity<JsonResponse<?>> editJournal(@PathVariable("id") long id, @ModelAttribute @Valid CreateJournalRequest request){
        JournalDto journalDto = JournalMapper.toDto(journalService.edit(request));
        return ResponseEntity.ok(new JsonResponse<>(OK,journalDto));
    }

}
