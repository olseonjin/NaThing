package com.boot.Controller;

import com.boot.DTO.PostDTO;
import com.boot.Service.PostService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/posts") //localhost:8080/api/posts로 접속
public class PostController {

    private final PostService postService;

    // 전체 게시글 목록 조회
    @GetMapping
    public List<PostDTO> list() {
        return postService.list();
    }

    // 게시글 작성
    @PostMapping
    public String write(@RequestBody HashMap<String, String> param) {
        postService.write(param);
        return "success";
    }

    // 게시글 상세 조회
    @GetMapping("/{id}")
    public PostDTO contentView(@PathVariable("id") String id) {
        HashMap<String, String> param = new HashMap<>();
        param.put("id", id);
        return postService.contentView(param);
    }

    // 게시글 수정
    @PutMapping("/{id}")
    public String edit(@PathVariable("id") String id, @RequestBody HashMap<String, String> param) {
        param.put("id", id);
        postService.modify(param);
        return "updated";
    }

    // 게시글 삭제
    @DeleteMapping("/{id}")
    public String delete(@PathVariable("id") String id) {
        HashMap<String, String> param = new HashMap<>();
        param.put("id", id);
        postService.delete(param);
        return "deleted";
    }
}
