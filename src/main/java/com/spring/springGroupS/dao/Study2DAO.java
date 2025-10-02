package com.spring.springGroupS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springGroupS.vo.CrimeVO;
import com.spring.springGroupS.vo.KakaoAddressVO;
import com.spring.springGroupS.vo.QrCodeVO;
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

	void setSaveCrimeCheck(@Param("vo") CrimeVO vo);

	int setDeleteCrimeCheck(@Param("year") int year);

	List<CrimeVO> getLoadCrimeCheck(@Param("year") int year);

	CrimeVO getPoliceCheck(@Param("year") int year, @Param("police") String police);

	KakaoAddressVO getKakaoAddressSearch(@Param("address") String address);

	int setKakaoAddressInput(@Param("vo") KakaoAddressVO vo);

	List<KakaoAddressVO> getKakaoAddressList();

	int setKakaoAddressDelete(@Param("address") String address);

	void setQrCodeCreate(@Param("vo") QrCodeVO vo);

	QrCodeVO getQrCodeSearch(@Param("qrCode") String qrCode);
}
