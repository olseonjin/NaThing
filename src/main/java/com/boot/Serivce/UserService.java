package com.boot.Serivce;

import com.boot.DTO.EmailVerificationDTO;
import com.boot.DTO.LoginDTO;
import com.boot.Entity.User;

public interface UserService {
    User login(LoginDTO loginDTO);
    void sendVerificationEmail(String email);
    boolean verifyEmail(EmailVerificationDTO dto);
}