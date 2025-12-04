package org.example.mapper;

import org.example.model.Match;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface MatchMapper {
    // 查询所有赛事列表
    List<Match> selectAllMatches();
}