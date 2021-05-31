package com.wizardom.myjournserver.controller.request;

import lombok.Data;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotEmpty;
import java.util.List;

@Accessors(chain = true)
@Data
public class EditJournalRequest {
    @NotEmpty(message = "Journal body cannot be empty")
    private String body;
    private List<String> images;
    @NotEmpty(message = "You must specify a date of journal")
    private String date;
}
