package com.boot.Controller;

import com.boot.DTO.UserRegisterDTO;
import com.boot.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    // 아이디 중복 체크 (AJAX)
    @PostMapping("/check-username")
    @ResponseBody
    public boolean checkUsername(@RequestParam String username) {
        return userService.isUsernameTaken(username);
    }

    // 닉네임 중복 체크 (AJAX)
    @PostMapping("/check-nickname")
    @ResponseBody
    public boolean checkNickname(@RequestParam String nickname) {
        return userService.isNicknameTaken(nickname);
    }

    // 회원가입 처리
    @PostMapping("/register")
    public String register(UserRegisterDTO dto, Model model) {
        // 서버 측 비밀번호 정규식 검증
        String pw = dto.getPassword();
        if (!pw.matches(".*[!@#$%^&*()].*")) {
            model.addAttribute("error", "비밀번호에 특수문자가 1개 이상 포함되어야 합니다.");
            return "user/register"; // 다시 회원가입 페이지로
        }

        // 회원 저장
        userService.registerUser(dto);
        return "redirect:/login";  // 로그인 페이지로 리디렉션 (원하면 경로 수정 가능)
    }

    // 회원가입 폼 페이지 이동
    @GetMapping("/register")
    public String showRegisterForm() {
        return "user/register"; // JSP 경로: /WEB-INF/views/user/register.jsp
    }
}

///user/register: GET → 회원가입 폼 이동
//
///user/register: POST → 회원가입 처리
//
///user/check-username: POST → 아이디 중복 확인
//
///user/check-nickname: POST → 닉네임 중복 확인