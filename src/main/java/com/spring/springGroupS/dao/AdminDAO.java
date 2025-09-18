package com.spring.springGroupS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springGroupS.vo.ComplaintVO;

public interface AdminDAO {
	int setMemberLevelSelectChange(@Param("idx") int idx, @Param("level") int levelSelect);

	int memberDeleteGet(@Param("idx") int idx);

	int setBoardComplaintInput(@Param("vo") ComplaintVO vo);

	void setBoardTableComplaintOk(@Param("partIdx") int partIdx);

	List<ComplaintVO> getComplaintList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	ComplaintVO getComplaintContent(@Param("partIdx") int partIdx);

	List<ComplaintVO> getNewBoardList(@Param("flag") String flag);

	int setComplaintDelete(@Param("part") String part, @Param("partIdx") int partIdx);

	int setComplaintPrgress(@Param("part") String part, @Param("partIdx") int partIdx, @Param("flag") String flag);

	void setComplaintProgressOk(@Param("idx") int idx, @Param("flag") String flag);
}
