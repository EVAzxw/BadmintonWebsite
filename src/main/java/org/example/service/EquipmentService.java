package org.example.service;

import org.example.mapper.EquipmentMapper;
import org.example.model.Equipment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class EquipmentService {
    @Autowired
    private EquipmentMapper equipmentMapper;

    // 获取所有装备列表
    public List<Equipment> getAllEquipments() {
        return equipmentMapper.selectAllEquipments();
    }
}