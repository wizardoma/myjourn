package com.wizardom.myjournserver.validation;

import com.wizardom.myjournserver.repository.UserRepository;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

@NoArgsConstructor
@AllArgsConstructor
public class UniqueEmailValidator implements ConstraintValidator<UniqueEmail, String> {
   @Autowired
   UserRepository userRepository;

   public void initialize(UniqueEmail constraint) {
   }

   public boolean isValid(String email, ConstraintValidatorContext context) {
      if (StringUtils.isEmpty(email)){
         return false;
      }
      return userRepository.findByEmailIgnoreCase(email.toLowerCase()).isEmpty();
   }
}
