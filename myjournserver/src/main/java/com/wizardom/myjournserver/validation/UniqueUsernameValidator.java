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
public class UniqueUsernameValidator implements ConstraintValidator<UniqueUsername, String> {
   @Autowired
   UserRepository userRepository;

   public void initialize(UniqueUsername constraint) {
   }

   public boolean isValid(String username, ConstraintValidatorContext context) {
      if (StringUtils.isEmpty(username)){
         return false;
      }
      return userRepository.findByUsernameIgnoreCase(username).isEmpty();
   }
}
