package com.boot.DTO;

public class UserRegisterDTO {
    private String username;
    private String nickname;
    private String password;

    // 기본 생성자
    public UserRegisterDTO() {}

    // 전체 생성자
    public UserRegisterDTO(String username, String nickname, String password) {
        this.username = username;
        this.nickname = nickname;
        this.password = password;
    }

    // Getters & Setters
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
