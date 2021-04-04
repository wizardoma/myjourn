package com.wizardom.myjournserver.service;

import com.wizardom.myjournserver.controller.request.LoginRequest;
import com.wizardom.myjournserver.controller.request.SignUpRequest;
import com.wizardom.myjournserver.dto.UserDto;
import com.wizardom.myjournserver.dto.UserMapper;
import com.wizardom.myjournserver.model.User;
import com.wizardom.myjournserver.security.TokenProvider;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletResponse;

import static com.wizardom.myjournserver.security.SecurityConstants.HEADER_STRING;
import static com.wizardom.myjournserver.security.SecurityConstants.TOKEN_PREFIX;

@Service
@RequiredArgsConstructor
@Slf4j
public class AuthService {
    private final UserService userService;
    private final AuthenticationManager authenticationManager;

    public void login(LoginRequest request, HttpServletResponse response) {
        String email = setAuthentication(request.getEmail(), request.getPassword());
        addTokenToResponse(email, response);
    }

    public UserDto signUp(SignUpRequest request, HttpServletResponse response) {
        User user = userService.save(request);
        addTokenToResponse(user.getEmail(), response);
        return UserMapper.toDto(user);
    }

    public String setAuthentication(String email, String password) {
        try {
            Authentication authentication = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(email, password));
            SecurityContextHolder.getContext().setAuthentication(authentication);
            return authentication.getName();
        } catch (Exception e) {
            throw new BadCredentialsException("Email or password is incorrect");
        }
    }

    public void addTokenToResponse(String email, HttpServletResponse response) {
        String token = TokenProvider.create(email);
        response.addHeader(HEADER_STRING, TOKEN_PREFIX + token);
    }
}
