package com.wizardom.myjournserver.model;

import lombok.Data;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Data
@Entity
public class Journal {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    private  String body;
    private LocalDateTime date;
    @ElementCollection
    private List<String> images;

}
