package org.example.service;

import org.example.mapper.MatchMapper;
import org.example.model.Match;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class MatchService {
    @Autowired
    private MatchMapper matchMapper;

    // 获取所有赛事列表
    public List<Match> getAllMatches() {
        return matchMapper.selectAllMatches();
    }
}