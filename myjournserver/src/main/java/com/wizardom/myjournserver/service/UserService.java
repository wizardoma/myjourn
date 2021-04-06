package com.wizardom.myjournserver.service;

import com.wizardom.myjournserver.controller.request.SignUpRequest;
import com.wizardom.myjournserver.exceptions.UserNotFoundException;
import com.wizardom.myjournserver.model.SignUpType;
import com.wizardom.myjournserver.model.User;
import com.wizardom.myjournserver.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public User getByEmail(String email) {
        return userRepository.findByEmailIgnoreCase(email.toLowerCase())
                .orElseThrow(() -> new UserNotFoundException("User with email " + email + " not found"));
    }

    public User getById(long id) {
        return userRepository.findById(id)
                .orElseThrow(() -> new UserNotFoundException("User with id: " + id + " not found"));
    }

    public User save(SignUpRequest request) {
        User user = new User()
                .setEmail(request.getEmail().trim())
                .setSignUpType(SignUpType.valueOf(request.getSignUpType().toLowerCase()))
                .setPassword(passwordEncoder.encode(request.getPassword()));
        return userRepository.save(user);
    }

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public User getCurrentUser() {
        String email = SecurityContextHolder.getContext().getAuthentication().getName();
        return userRepository.findByEmailIgnoreCase(email).orElseThrow(() -> new UserNotFoundException("No User found with email: " + email));
    }


    public void deleteById(long id) {
        User user = userRepository.findById(id).orElseThrow(() -> new UserNotFoundException("No user found"));
        userRepository.delete(user);
    }
}
