package com.wizardom.myjournserver.model;

import javax.persistence.*;
import java.util.List;

@Entity
@Table (name = "users")
public class User {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private  long id;
    private String email;
    private String password;
    @Enumerated(value = EnumType.STRING)
    private SignUpType signUpType;

    @OneToMany(mappedBy = "user")
    List<Journal> journals;
}
