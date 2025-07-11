package com.boot.DAO;

import java.time.LocalDateTime;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.boot.DTO.PostDTO;

@Mapper
public interface PostMapper {
    void createPost(PostDTO post);
    List<PostDTO> getRecentPosts(); // 메인 페이지용
    void deleteExpired(@Param("now") LocalDateTime now); // 스케줄러용
}

