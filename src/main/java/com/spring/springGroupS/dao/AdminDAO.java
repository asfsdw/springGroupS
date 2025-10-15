package com.spring.springGroupS.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springGroupS.vo.ComplaintVO;
import com.spring.springGroupS.vo.InquiryReplyVO;
import com.spring.springGroupS.vo.InquiryVO;

public interface AdminDAO {
	int setMemberLevelSelectChange(@Param("idx") int idx, @Param("level") int levelSelect);

	int memberDeleteGet(@Param("idx") int idx);

	int setBoardComplaintInput(@Param("vo") ComplaintVO vo);

	void setBoardTableComplaintOk(@Param("partIdx") int partIdx);

	List<ComplaintVO> getComplaintList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("flag") String flag);

	ComplaintVO getComplaintContent(@Param("partIdx") int partIdx);

	List<ComplaintVO> getNewBoardList(@Param("flag") String flag);

	int setComplaintDelete(@Param("part") String part, @Param("partIdx") int partIdx);

	int setComplaintPrgress(@Param("part") String part, @Param("partIdx") int partIdx, @Param("flag") String flag);

	void setComplaintProgressOk(@Param("idx") int idx, @Param("flag") String flag);

	int getTotRecCnt(@Param("flag") String flag, @Param("search") String search, @Param("searchStr") String searchStr);
	
	ArrayList<InquiryVO> getInquiryListAdmin(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("part") String part);

	InquiryVO getInquiryContent(@Param("idx") int idx);

	InquiryReplyVO getInquiryReplyContent(@Param("idx") int idx);

	int setInquiryInputAdmin(@Param("vo") InquiryReplyVO vo);

	void setInquiryUpdateAdmin(@Param("inquiryIdx") int inquiryIdx);

	int setInquiryReplyUpdate(@Param("reVO") InquiryReplyVO reVO);
	
	int setAdInquiryReplyDelete(@Param("reIdx") int reIdx);

	void setAdInquiryDelete(@Param("idx") int idx, @Param("fSName") String fSName, @Param("reIdx") int reIdx);

	int setInquiryReplyStatusUpdate(@Param("inquiryIdx") int inquiryIdx);
}
