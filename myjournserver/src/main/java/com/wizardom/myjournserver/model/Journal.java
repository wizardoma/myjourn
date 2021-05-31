package com.wizardom.myjournserver.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import javax.persistence.Entity;
import javax.persistence.*;
import java.io.Serializable;
import java.time.Instant;
import java.util.List;

/**
 * @author Ibekason Alexander Onyebuchi
 */
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@Data
@Entity
public class Journal extends com.wizardom.myjournserver.model.Entity<Long> implements Serializable {
    @Column(unique = true, nullable = false)
    private long dbId;

    @Column(nullable = false)
    private String body;

    @ManyToOne(fetch = FetchType.LAZY)
    private User user;

    @Column(nullable = false)
    private Instant date;

    @ElementCollection()
    private List<String> images;


}
