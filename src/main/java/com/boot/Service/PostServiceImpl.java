package com.boot.Service;

import com.boot.DAO.PostDAO;
import com.boot.DTO.PostDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.HashMap;

@Service
@RequiredArgsConstructor
public class PostServiceImpl implements PostService {

    private final PostDAO postDAO;

    @Override
    public List<PostDTO> list() {
        return postDAO.list();
    }

    @Override
    public void write(HashMap<String, String> param) {
    	postDAO.write(param);
    }

    @Override
    public PostDTO contentView(HashMap<String, String> param) {
        return postDAO.contentView(param);
    }

    @Override
    public void modify(HashMap<String, String> param) {
    	postDAO.modify(param);
    }

    @Override
    public void delete(HashMap<String, String> param) {
    	postDAO.delete(param);
    }
}
