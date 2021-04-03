package com.wizardom.myjournserver.controller;

import com.wizardom.myjournserver.controller.request.LoginRequest;
import com.wizardom.myjournserver.dto.UserDto;
import com.wizardom.myjournserver.model.User;
import com.wizardom.myjournserver.service.AuthService;
import com.wizardom.myjournserver.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("auth")
public class AuthController {
    private final AuthService authService;

    @PostMapping("login")
    public ResponseEntity<?> login(@ModelAttribute LoginRequest request, HttpServletResponse response) {
        authService.login(request, response);
        return ResponseEntity.ok(null);
    }

    @PostMapping("signup")
    public ResponseEntity<UserDto> signUp(@ModelAttribute UserDto userDto, HttpServletResponse response) {
        UserDto user = authService.signUp(userDto, response);
        return new ResponseEntity<>(user, HttpStatus.CREATED);
    }


}
