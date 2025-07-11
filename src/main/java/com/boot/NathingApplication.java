package com.boot;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling  // ➕ 스케줄링 기능 켜기 (예: 24시간 지난 게시글 삭제)
public class NathingApplication {

    public static void main(String[] args) {
        SpringApplication.run(NathingApplication.class, args);
    }
}
