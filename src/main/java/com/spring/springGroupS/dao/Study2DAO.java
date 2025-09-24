package com.spring.springGroupS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springGroupS.vo.TransactionVO;

public interface Study2DAO {

	List<TransactionVO> getUserList();

	int setValidatorOk(@Param("vo") TransactionVO vo);

	int setValidatorDeleteOk(@Param("idx") int idx);

	List<TransactionVO> getTransactionList();

	List<TransactionVO> getTransactionList2();

	void setTransactionUser1Input(@Param("vo") TransactionVO vo);

	void setTransactionUser2Input(@Param("vo") TransactionVO vo);

	int setTransactionUserTotalInput(@Param("vo") TransactionVO vo);
}
