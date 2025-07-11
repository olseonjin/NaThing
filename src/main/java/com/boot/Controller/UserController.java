package com.boot.Controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.boot.DTO.EmailVerificationDTO;
import com.boot.DTO.LoginDTO;
import com.boot.Entity.User;
import com.boot.Serivce.UserService;

@RestController
@RequestMapping("/api/users")
public class UserController {
    @Autowired
    private UserService userService;

    @PostMapping("/login")
    public User login(@RequestBody LoginDTO loginDTO) {
        return userService.login(loginDTO);
    }

    @PostMapping("/send-verification")
    public void sendEmail(@RequestBody Map<String, String> body) {
        userService.sendVerificationEmail(body.get("email"));
    }

    @PostMapping("/verify")
    public boolean verifyEmail(@RequestBody EmailVerificationDTO dto) {
        return userService.verifyEmail(dto);
    }
}
