package com.boot.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserDTO { //유저
    private Long id;
    private boolean isGuest;
    private boolean isPremium;
    private String email;
    private String password;
    private boolean isEmailVerified;
}