package com.wizardom.myjournserver.service;

import com.wizardom.myjournserver.dto.UserDto;
import com.wizardom.myjournserver.dto.UserMapper;
import com.wizardom.myjournserver.exceptions.UserNotFoundException;
import com.wizardom.myjournserver.model.User;
import com.wizardom.myjournserver.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;

    public User getByEmail(String email){
        return userRepository.findByEmail(email.toLowerCase())
                .orElseThrow(() -> new UserNotFoundException("User with email "+email + " not found"));
    }

    public User getById(long id){
        return userRepository.findById(id)
                .orElseThrow(() -> new UserNotFoundException("User with id: "+id + " not found"));
    }

    public User save(UserDto userDto){
        User user = UserMapper.fromDto(userDto);
        return userRepository.save(user);
    }

    public List<User> getAllUsers(){
        return userRepository.findAll();
    }



}
