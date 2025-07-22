package com.boot.Service;

import com.boot.DTO.PostDTO;
import java.util.List;
import java.util.HashMap;

public interface PostService {
    List<PostDTO> list();
    void write(HashMap<String, String> param);
    PostDTO contentView(HashMap<String, String> param);
    void modify(HashMap<String, String> param);
    void delete(HashMap<String, String> param);
}
