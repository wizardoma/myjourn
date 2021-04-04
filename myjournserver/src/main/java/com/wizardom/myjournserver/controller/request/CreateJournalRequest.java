package com.wizardom.myjournserver.controller.request;

import lombok.Data;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotEmpty;
import java.util.List;

@Data
@Accessors(chain = true)
public class CreateJournalRequest {
    @NotEmpty(message = "Journal body cannot be empty")
    private String body;
    private List<String> images;
    private String date;
}
