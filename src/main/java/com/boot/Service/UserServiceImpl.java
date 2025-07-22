package com.boot.Service;

import com.boot.DAO.UserDAO;
import com.boot.DTO.UserRegisterDTO;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDAO userDAO;

    @Override
    public boolean isUsernameTaken(String username) {
        return userDAO.checkUsername(username) > 0;
    }

    @Override
    public boolean isNicknameTaken(String nickname) {
        return userDAO.checkNickname(nickname) > 0;
    }

    @Override
    public void registerUser(UserRegisterDTO dto) {
        // 비밀번호 암호화 (BCrypt)
        String hashedPw = BCrypt.hashpw(dto.getPassword(), BCrypt.gensalt());
        dto.setPassword(hashedPw);

        // DB 저장
        userDAO.insertUser(dto);
    }
}
