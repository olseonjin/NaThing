package com.boot.Controller;

import java.time.LocalDateTime;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.boot.DTO.EmotionResult;
import com.boot.DTO.PostDTO;
import com.boot.Serivce.EmotionService;
import com.boot.Serivce.PostService;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class PostController {

    private final PostService postService;
    private final EmotionService emotionService;

    // 게시글 생성 API만 담당
    @PostMapping("/post/create")
    public ResponseEntity<?> createPost(@RequestBody PostDTO postDTO) {
        EmotionResult result = emotionService.analyse(postDTO.getContent());
        postDTO.setEmotion(result.getLabel());
        postDTO.setEmotionScore(result.getScore());
        postDTO.setExpiresAt(LocalDateTime.now().plusHours(24));

        postService.createPost(postDTO);
        return ResponseEntity.ok("등록 완료");
    }
}

