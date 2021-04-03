package com.wizardom.myjournserver.model;

import lombok.Data;
import lombok.experimental.Accessors;

import javax.persistence.*;
import java.util.List;

@Data
@Accessors(chain = true)
@Entity
@Table (name = "users")
public class User {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private  long id;
    @Column(unique = true, nullable = false)
    private String email;

    private String password;
    @Enumerated(value = EnumType.STRING)
    private SignUpType signUpType;

    @OneToMany(mappedBy = "user")
    List<Journal> journals;
}
