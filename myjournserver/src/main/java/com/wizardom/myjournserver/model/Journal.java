package com.wizardom.myjournserver.model;

import lombok.Data;
import lombok.experimental.Accessors;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.time.Instant;
import java.util.List;

@Accessors(chain = true)
@Data
@Entity
public class Journal {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    private long dbId;
    @NotEmpty
    @NotNull
    private  String body;
    @ManyToOne(fetch = FetchType.LAZY )
    private User user;
    @NotNull
    private Instant date;
    @ElementCollection
    private List<String> images;


}
