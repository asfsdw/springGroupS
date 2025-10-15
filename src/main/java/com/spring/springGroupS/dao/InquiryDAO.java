package com.spring.springGroupS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springGroupS.vo.InquiryReplyVO;
import com.spring.springGroupS.vo.InquiryVO;

public interface InquiryDAO {

	int getTotRecCnt(@Param("part") String part, @Param("mid") String mid);

	int getTotRecCntAdmin(@Param("part") String part);

	List<InquiryVO> getInquiryList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("part") String part, @Param("mid") String mid);

	void setInquiryInput(@Param("vo") InquiryVO vo);

	InquiryVO getInquiryView(@Param("idx") int idx);

	InquiryReplyVO getInquiryReply(@Param("idx") int idx);

	int setInquiryUpdate(@Param("vo") InquiryVO vo);

	int setInquiryDelete(@Param("idx") int idx);

}
