package com.wizardom.myjournserver.security;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;

import java.util.Date;

import static com.auth0.jwt.algorithms.Algorithm.HMAC512;
import static com.wizardom.myjournserver.security.SecurityConstants.*;
/**
 * @author Ibekason Alexander Onyebuchi
 */

public class TokenProvider {
    private TokenProvider() throws IllegalAccessException {
        throw new IllegalAccessException();
    }
    public static String create(String email){
        return JWT.create()
                .withSubject(email)
                .withExpiresAt(new Date(System.currentTimeMillis() + EXPIRATION_TIME))
                .sign(HMAC512(SECRET.getBytes()));

    }

    public static String verify(String token) {
        return  JWT.require(Algorithm.HMAC512(SECRET.getBytes()))
                .build()
                .verify(token.replace(TOKEN_PREFIX, ""))
                .getSubject();
    }
}
