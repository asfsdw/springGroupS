package com.spring.springGroupS.service;

import java.util.List;

import com.spring.springGroupS.vo.CrimeVO;
import com.spring.springGroupS.vo.TransactionVO;

public interface Study2Service {

	void getCalendar();

	List<TransactionVO> getUserList();

	int setValidatorOk(TransactionVO vo);

	int setValidatorDeleteOk(int idx);

	List<TransactionVO> getTransactionList();

	List<TransactionVO> getTransactionList2();

	void setTransactionUser1Input(TransactionVO vo);

	void setTransactionUser2Input(TransactionVO vo);

	int setTransactionUserTotalInput(TransactionVO vo);

	void setSaveCrimeCheck(CrimeVO vo);

	int setDeleteCrimeCheck(int year);

	List<CrimeVO> getLoadCrimeCheck(int year);

	CrimeVO getPoliceCheck(int year, String police);
}
