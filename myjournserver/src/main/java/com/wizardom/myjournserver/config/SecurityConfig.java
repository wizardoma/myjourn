package com.wizardom.myjournserver.config;

import com.wizardom.myjournserver.security.CustomUserDetailsService;
import com.wizardom.myjournserver.security.JWTAuthorizationFilter;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.BeanIds;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

/**
 * @author Ibekason Alexander Onyebuchi
 */

@RequiredArgsConstructor
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    private final PasswordEncoder passwordEncoder;
    private final CustomUserDetailsService userDetailsService;
    private static final String[] PUBLIC_URLS =
            {"/resources/**", "/swagger-resources/**", "/static/**", "/assets/**"
                    , "/fonts/**", "/css/**", "/js/**", "/img/**", "/webjars/**", "/images/**", "/actuator/**", "/integration" +
                    "/**", "/swagger-ui.html", "/v2/api-docs", "/api/v1/customers/login", "/api/v1" +
                    "/customers/signup","/api/v1/vendors/signup",  "/api/v1/products/**", "/api/v1/vendors/**"
                    , "/api/v1/vendors", "/api/v1/admin/auth/login","/api/v1/users/login", "/api/v1/users/signup","/api/v1/admin/settings", "/api/v1/admin/settings/code/*", "/api/v1/admin/settings/cities",
                    "/api/v1/transactions/verify/**", "/api/v1/customers/googlelogin", "/api/v1/users/password/reset", "/api/v1/users/password/resetChange", "/api/v1/users/password/resetConfirm",
                    "/api/v1/users/password/resetResend", "/api/v1/newletters","/api/v1/adverts", "/auth", "/auth/login", "/auth/signup"};
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .csrf().disable().formLogin().disable()
                .authorizeRequests()
                .antMatchers(PUBLIC_URLS).permitAll()
                .anyRequest().authenticated()

                .and()
                .cors().configurationSource(request -> new CorsConfiguration().applyPermitDefaultValues()).and()
                .addFilter(new JWTAuthorizationFilter(authenticationManager()))
                // this disables session creation on Spring Security
                .sessionManagement()
                .sessionCreationPolicy(SessionCreationPolicy.STATELESS);
    }
    @Override
    public void configure(WebSecurity webSecurity) throws Exception {
        webSecurity.ignoring().antMatchers(PUBLIC_URLS);
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth
                .userDetailsService(userDetailsService)
                .passwordEncoder(passwordEncoder);
    }

    @Lazy
    @Bean(BeanIds.AUTHENTICATION_MANAGER)
    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }

    @Bean
    CorsConfigurationSource corsConfigurationSource() {
        final UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", new CorsConfiguration().applyPermitDefaultValues());
        return source;
    }

}
