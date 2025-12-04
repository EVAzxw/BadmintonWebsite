package org.example.mapper;

import org.example.model.Equipment;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface EquipmentMapper {
    // 查询所有装备列表
    List<Equipment> selectAllEquipments();
}