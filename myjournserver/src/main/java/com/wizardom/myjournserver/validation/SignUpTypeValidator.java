package com.wizardom.myjournserver.validation;

import com.wizardom.myjournserver.model.SignUpType;
import lombok.extern.slf4j.Slf4j;
import org.springframework.util.StringUtils;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import java.util.Arrays;

@Slf4j
public class SignUpTypeValidator implements ConstraintValidator<ValidSignUpType, String> {
   public void initialize(ValidSignUpType constraint) {
   }

   public boolean isValid(String signUpType, ConstraintValidatorContext context) {
      if (StringUtils.isEmpty(signUpType)){
         return false;
      }
      return Arrays.stream(SignUpType.values()).anyMatch(type ->
         type.toString().equals(signUpType.toLowerCase()));
   }
}
