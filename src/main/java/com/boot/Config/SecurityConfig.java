package com.boot.Config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .csrf().disable()
            .authorizeRequests()
                .anyRequest().permitAll() // 모든 경로 허용
            .and()
            .formLogin().disable()       // 폼 로그인도 비활성화
            .httpBasic().disable();      // 기본 인증 팝업 막기
        return http.build();
    }
}
