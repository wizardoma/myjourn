package com.wizardom.myjournserver.model;

import lombok.Data;
import lombok.experimental.Accessors;

import javax.persistence.*;
import java.util.List;
/**
 * @author Ibekason Alexander Onyebuchi
 */
@Data
@Accessors(chain = true)
@Entity
@Table (name = "users")
public class User {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private  long id;

    @Column(unique = true, nullable = false)
    private String email;

    @Column(unique = true, nullable = false)
    private String username;

    @Column(length = 10000,columnDefinition = "text")
    private String password;

    @Column(nullable = false)
    @Enumerated(value = EnumType.STRING)
    private SignUpType signUpType;

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY,cascade = CascadeType.ALL)
    List<Journal> journals;
}
