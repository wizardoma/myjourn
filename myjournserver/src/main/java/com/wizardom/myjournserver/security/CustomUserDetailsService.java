package com.wizardom.myjournserver.security;

import com.wizardom.myjournserver.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import java.util.Collections;
/**
 * @author Ibekason Alexander Onyebuchi
 */
@Component
@RequiredArgsConstructor

public class CustomUserDetailsService implements UserDetailsService {
    private final UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        com.wizardom.myjournserver.model.User user = userRepository.findByEmailIgnoreCase(email).orElseThrow(()-> new UsernameNotFoundException("No user found with email: "+email));
        return new User(user.getEmail(), user.getPassword(), Collections.emptyList());
    }
}
