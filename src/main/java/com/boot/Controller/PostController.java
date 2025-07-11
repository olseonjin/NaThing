package com.boot.Controller;

import com.boot.DTO.PostDTO;
import com.boot.Serivce.PostService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;

@RestController
@RequiredArgsConstructor
public class PostController {

    private final PostService postService;

    // 게시글 생성 API만 담당
    @PostMapping("/post/create")
    public ResponseEntity<?> createPost(@RequestBody PostDTO postDTO) {
        // 감정 분석 제거됨 → emotion, emotionScore 직접 세팅 안 함
        postDTO.setExpiresAt(LocalDateTime.now().plusHours(24));

        postService.createPost(postDTO);
        return ResponseEntity.ok("등록 완료");
    }
}
