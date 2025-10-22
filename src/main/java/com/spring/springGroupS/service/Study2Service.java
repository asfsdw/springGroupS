package com.spring.springGroupS.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.springGroupS.vo.CrimeVO;
import com.spring.springGroupS.vo.KakaoAddressVO;
import com.spring.springGroupS.vo.KakaoPlaceVO;
import com.spring.springGroupS.vo.QrCodeVO;
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

	KakaoAddressVO getKakaoAddressSearch(String address);

	int setKakaoAddressInput(KakaoAddressVO vo);

	List<KakaoAddressVO> getKakaoAddressList();

	int setKakaoAddressDelete(String address);

	String setQrCodeCreate(String realPath, QrCodeVO vo);

	QrCodeVO getQrCodeSearch(String qrCode);

	String setThumbnailCreate(MultipartFile file, String mid, String realPath);

	int setKakaoPlaceInput(KakaoPlaceVO vo);

	KakaoAddressVO getKakaoAddressSearchIdx(int idx);

	List<KakaoPlaceVO> getKakaoAddressPlaceSearch(int idx);
}
