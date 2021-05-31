package com.wizardom.myjournserver.model;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;
import java.io.Serializable;

@MappedSuperclass
@Getter
@Setter
@ToString
@EqualsAndHashCode
public abstract class Entity<I extends Serializable> {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    I id;

}
