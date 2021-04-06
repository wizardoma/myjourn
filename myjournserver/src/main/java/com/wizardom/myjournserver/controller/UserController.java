package com.wizardom.myjournserver.controller;

import com.wizardom.myjournserver.controller.response.JsonResponse;
import com.wizardom.myjournserver.dto.UserDto;
import com.wizardom.myjournserver.dto.UserMapper;
import com.wizardom.myjournserver.model.User;
import com.wizardom.myjournserver.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import static  org.springframework.http.HttpStatus.*;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("users")
public class UserController {
    private final UserService userService;

    @GetMapping("")
    public ResponseEntity<JsonResponse<?>> getCurrentUser(){
        UserDto userDto = UserMapper.toDto(userService.getCurrentUser());
        return ResponseEntity.ok(new JsonResponse<>(OK,userDto));
    }

    @GetMapping("all")
    public ResponseEntity<JsonResponse<?>> getUsers(){
        List<UserDto> users = userService.getAllUsers().stream()
                .map(UserMapper::toDto)
                .collect(Collectors.toList());
        
        return ResponseEntity.ok(new JsonResponse<>(OK, users));
        
    } 
    
    @GetMapping("{id}")
    public ResponseEntity<JsonResponse<?>> getUser(@PathVariable("id") long id){
        UserDto user = UserMapper.toDto(userService.getById(id));
        return ResponseEntity.ok(new JsonResponse<>(OK,user));
    }
    
    @DeleteMapping("{id}")
    public ResponseEntity<JsonResponse> deleteUser(@PathVariable("id") long id){
        userService.deleteById(id);
        return ResponseEntity.ok(new JsonResponse(OK));
    }

}
