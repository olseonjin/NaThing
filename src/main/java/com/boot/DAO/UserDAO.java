package com.boot.DAO;

import com.boot.DTO.UserRegisterDTO;

public interface UserDAO {

    // 아이디 중복 체크
    int checkUsername(String username);

    // 닉네임 중복 체크
    int checkNickname(String nickname);

    // 회원 등록
    void insertUser(UserRegisterDTO dto);
}

