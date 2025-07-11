package com.boot.Serivce;

import java.util.List;

import com.boot.DTO.PostDTO;

public interface PostService {
    List<PostDTO> getRecentPosts();
	void createPost(PostDTO postDTO);
	void deleteExpiredPosts();
}
