package com.boot.Serivce;

import org.springframework.stereotype.Service;

import com.boot.DTO.EmotionResult;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class EmotionService {
	   private final OpenAiClient openAi;   // 래퍼 클래스

	    public EmotionResult analyse(String text) {
	        // 예: "HAPPY|0.92" 형식으로 받아온다고 가정
	        String resp = openAi.classifySentiment(text);
	        String[] parts = resp.split("\\|");
	        return new EmotionResult(parts[0], Float.parseFloat(parts[1]));
	    }
}
