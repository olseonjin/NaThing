package com.boot.Serivce;

import org.springframework.stereotype.Component;

@Component
public class OpenAiClient {
    public String classifySentiment(String text) {
        // TODO: OpenAI API 연동 구현 예정
        return "NEUTRAL|0.88";  // 예시 반환
    }
}

