package com.boot.Controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.boot.DTO.PostDTO;
import com.boot.Serivce.PostService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MainController {

    private final PostService postService;

    @GetMapping("/main")
    public String mainPage(Model model) {
        List<PostDTO> postList = postService.getRecentPosts();
        model.addAttribute("postList", postList);
        return "main"; // /WEB-INF/views/main.jsp
    }
}
