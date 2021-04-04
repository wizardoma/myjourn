package com.wizardom.myjournserver.model;

import lombok.Data;
import lombok.experimental.Accessors;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.List;

@Data
@Accessors(chain = true)
@Entity
@Table (name = "users")
public class User {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private  long id;
    @Column(unique = true, nullable = false)
    @NotEmpty(message = "email cannot be empty")
    private String email;
    @Size(min = 4, max= 40, message = "Password must be more than 3 letters")
    private String password;
    @NotNull(message = "You must specify a signup Type")
    @Enumerated(value = EnumType.STRING)
    private SignUpType signUpType;

    @OneToMany(mappedBy = "user")
    List<Journal> journals;
}
