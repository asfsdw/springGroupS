package com.spring.springGroupS.dao;

import org.apache.ibatis.annotations.Param;

public interface AdminDAO {
	int setMemberLevelSelectChange(@Param("idx") int idx, @Param("level") int levelSelect);

	int memberDeleteGet(@Param("idx") int idx);
}
