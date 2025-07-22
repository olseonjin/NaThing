package com.boot.Service;

import com.boot.DTO.UserRegisterDTO;

public interface UserService {

    // 아이디 중복 여부 확인
    boolean isUsernameTaken(String username);

    // 닉네임 중복 여부 확인
    boolean isNicknameTaken(String nickname);

    // 회원가입 처리
    void registerUser(UserRegisterDTO dto);
}
