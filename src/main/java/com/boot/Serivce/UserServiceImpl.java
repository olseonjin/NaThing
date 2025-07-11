package com.boot.Serivce;

import java.time.LocalDateTime;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;

import com.boot.DTO.EmailVerificationDTO;
import com.boot.DTO.LoginDTO;
import com.boot.Entity.EmailVerificationToken;
import com.boot.Entity.User;
import com.boot.Repository.EmailVerificationRepository;
import com.boot.Repository.UserRepository;


@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private EmailVerificationRepository emailVerificationRepository;

    @Autowired
    private JavaMailSender mailSender;

    @Override
    public User login(LoginDTO loginDTO) {
        if (loginDTO.isGuest()) {
            User guest = new User();
            guest.setGuest(true);
            guest.setPremium(false);
            guest.setEmailVerified(true);
            return userRepository.save(guest);
        } else {
            return userRepository.findByEmail(loginDTO.getEmail())
                    .filter(user -> user.getPassword().equals(loginDTO.getPassword()))
                    .orElseThrow(() -> new RuntimeException("회원 정보가 올바르지 않습니다."));
        }
    }

    @Override
    public void sendVerificationEmail(String email) {
        String token = UUID.randomUUID().toString();
        EmailVerificationToken verification = new EmailVerificationToken();
        verification.setEmail(email);
        verification.setToken(token);
        verification.setExpiryDate(LocalDateTime.now().plusMinutes(10));
        emailVerificationRepository.save(verification);

        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(email);
        message.setSubject("이메일 인증 코드");
        message.setText("인증 코드: " + token);
        mailSender.send(message);
    }

    @Override
    public boolean verifyEmail(EmailVerificationDTO dto) {
        return emailVerificationRepository.findByEmailAndToken(dto.getEmail(), dto.getToken())
                .filter(token -> token.getExpiryDate().isAfter(LocalDateTime.now()))
                .map(token -> {
                    User user = userRepository.findByEmail(dto.getEmail()).orElseThrow();
                    user.setEmailVerified(true);
                    userRepository.save(user);
                    emailVerificationRepository.deleteByEmail(dto.getEmail());
                    return true;
                })
                .orElse(false);
    }


}
