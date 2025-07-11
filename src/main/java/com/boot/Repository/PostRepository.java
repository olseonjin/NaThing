package com.boot.Repository;

import java.util.List;

import com.boot.Entity.Post;

public interface PostRepository {
    List<Post> getRecentPosts();
}
