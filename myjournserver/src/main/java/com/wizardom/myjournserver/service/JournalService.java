package com.wizardom.myjournserver.service;

import com.wizardom.myjournserver.controller.request.CreateJournalRequest;
import com.wizardom.myjournserver.controller.request.EditJournalRequest;
import com.wizardom.myjournserver.model.Journal;

import java.util.List;

public interface JournalService {

    public Journal save(CreateJournalRequest request);

    public Journal edit(long id, EditJournalRequest request);

    public void delete(long id);

    public Journal getById(long id);

    public List<Journal> getJournalsByUser();
}
