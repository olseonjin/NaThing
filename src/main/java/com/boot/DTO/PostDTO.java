package com.boot.DTO;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PostDTO { // 게시물 
    private Long id;
    private String content;
    private String emotion;
    private String createdAt;
    private int likeCount;
    private int repostCount;
    private boolean isBlurred;
    private Long   userId;
    private Float  emotionScore;
    private LocalDateTime expiresAt;
    private String imageUrl;

}
