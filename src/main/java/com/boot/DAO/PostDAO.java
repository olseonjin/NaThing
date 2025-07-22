package com.boot.DAO;

import com.boot.DTO.PostDTO;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;
import java.util.HashMap;

@Mapper
public interface PostDAO {
    List<PostDTO> list();
    void write(HashMap<String, String> param);
    PostDTO contentView(HashMap<String, String> param);
    void modify(HashMap<String, String> param);
    void delete(HashMap<String, String> param);
}
