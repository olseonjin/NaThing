package com.boot.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class LoginDTO { //로그인 회원 비회원
	   private boolean isGuest;
	    private boolean isPremium;
	    private String email;
	    private String password;
	}
