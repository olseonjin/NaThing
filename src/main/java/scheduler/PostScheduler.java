package scheduler;

import java.time.LocalDateTime;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.boot.Serivce.PostService;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class PostScheduler{

    private final PostService postService;

    @Scheduled(cron = "0 */10 * * * *")  // 10분마다
    public void deleteExpiredPosts() {
        postService.deleteExpiredPosts();
        System.out.println("🕒 만료된 게시글 삭제 실행됨: " + LocalDateTime.now());
    }
}

