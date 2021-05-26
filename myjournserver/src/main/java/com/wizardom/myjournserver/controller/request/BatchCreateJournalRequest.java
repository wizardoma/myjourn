package com.wizardom.myjournserver.controller.request;

import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@Accessors(chain = true)
public class BatchCreateJournalRequest {
    List<CreateJournalRequest> journalList;
}
