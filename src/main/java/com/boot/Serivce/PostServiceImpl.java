package com.boot.Serivce;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.boot.DAO.PostMapper;
import com.boot.DTO.PostDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PostServiceImpl implements PostService {

    private final PostMapper postMapper;

    @Override
    public List<PostDTO> getRecentPosts() {
        List<PostDTO> posts = postMapper.getRecentPosts();
        return posts.stream()
                .map(post -> {
                    if (post.isBlurred()) post.setContent("🔒 블러 처리된 게시글입니다.");
                    return post;
                })
                .collect(Collectors.toList());
    }

    @Override
    public void createPost(PostDTO postDTO) {
        postMapper.createPost(postDTO);
    }

	@Override
	public void deleteExpiredPosts() {
		// TODO Auto-generated method stub
		
	}
}

