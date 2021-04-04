package com.wizardom.myjournserver.validation;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.FIELD, ElementType.METHOD})
@Constraint(validatedBy = SignUpTypeValidator.class)
public @interface ValidSignUpType {
    String message() default "SignUpType must be 'email, facebook or gmail' ";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}
