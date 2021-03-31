package com.wizardom.myjournserver.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;
import lombok.experimental.Accessors;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Accessors(chain = true)
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
