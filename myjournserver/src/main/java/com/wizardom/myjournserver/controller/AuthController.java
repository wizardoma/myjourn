package com.wizardom.myjournserver.controller;

import com.wizardom.myjournserver.controller.request.LoginRequest;
import com.wizardom.myjournserver.controller.request.SignUpRequest;
import com.wizardom.myjournserver.controller.request.VerifyEmailRequest;
import com.wizardom.myjournserver.controller.response.JsonResponse;
import com.wizardom.myjournserver.dto.UserDto;
import com.wizardom.myjournserver.service.AuthService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("auth")
public class AuthController {
    private final AuthService authService;
    
    @PostMapping("")
    public ResponseEntity<JsonResponse<?>> checkIfUniqueEmail(@Valid VerifyEmailRequest request){
        return ResponseEntity.ok(new JsonResponse<>(HttpStatus.OK));
    }

    @PostMapping("login")
    public ResponseEntity<JsonResponse<?>> login(@ModelAttribute @Valid LoginRequest request, HttpServletResponse response) {
        authService.login(request, response);
        return ResponseEntity.ok(new JsonResponse<>(HttpStatus.OK));
    }

    @PostMapping("signup")
    public ResponseEntity<JsonResponse<UserDto>> signUp(@Valid  @ModelAttribute SignUpRequest request, HttpServletResponse response) {
        UserDto user = authService.signUp(request, response);
        return new ResponseEntity<>(new JsonResponse<>(HttpStatus.CREATED, user), HttpStatus.CREATED);
    }


}
