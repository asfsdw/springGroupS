package com.spring.springGroupS.service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.Calendar;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageConfig;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.spring.springGroupS.common.ProjectProvide;
import com.spring.springGroupS.dao.Study2DAO;
import com.spring.springGroupS.vo.CrimeVO;
import com.spring.springGroupS.vo.KakaoAddressVO;
import com.spring.springGroupS.vo.KakaoPlaceVO;
import com.spring.springGroupS.vo.QrCodeVO;
import com.spring.springGroupS.vo.TransactionVO;

import net.coobird.thumbnailator.Thumbnailator;

@Service
public class Study2ServiceImpl implements Study2Service {
	@Autowired
	Study2DAO study2DAO;
	@Autowired
	ProjectProvide projectProvide;

	@Override
	public void getCalendar() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		
		// 오늘 날짜 변수 설정.
		Calendar calToday = Calendar.getInstance();
		int toYear = calToday.get(Calendar.YEAR);
		int toMonth = calToday.get(Calendar.MONTH);
		int toDay = calToday.get(Calendar.DATE);
		
		Calendar calView = Calendar.getInstance();
		int yy = request.getParameter("yy") == null ? toYear : Integer.parseInt(request.getParameter("yy"));
		int mm = request.getParameter("mm") == null ? toMonth : Integer.parseInt(request.getParameter("mm"));
		
		if(mm < 0) {
			mm = 11;
			yy--;
		}
		if(mm > 11) {
			mm = 0;
			yy++;
		}
		
		calView.set(yy, mm, 1);
		
		// 시작 요일, 마지막 날짜.
		int startWeek = calView.get(Calendar.DAY_OF_WEEK);
		int lastDay = calView.getActualMaximum(Calendar.DAY_OF_MONTH);
		
		// 변수 보내기.
		int prevYear = yy;
		int prevMonth = mm-1;
		int nextYear = yy;
		int nextMonth = mm+1;
		
		Calendar calPre = Calendar.getInstance();
		calPre.set(prevYear, prevMonth, 1);
		int prevLastDay = calPre.getActualMaximum(Calendar.DAY_OF_MONTH);
		
		Calendar calNext = Calendar.getInstance();
		calNext.set(nextYear, nextMonth, 1);
		int nextStartWeek = calNext.get(Calendar.DAY_OF_WEEK);
		
		request.setAttribute("toYear", toYear);
		request.setAttribute("toMonth", toMonth);
		request.setAttribute("toDay", toDay);
		request.setAttribute("startWeek", startWeek);
		request.setAttribute("lastDay", lastDay);
		request.setAttribute("prevYear", prevYear);
		request.setAttribute("prevMonth", prevMonth);
		request.setAttribute("nextYear", nextYear);
		request.setAttribute("nextMonth", nextMonth);
		request.setAttribute("prevLastDay", prevLastDay);
		request.setAttribute("nextStartWeek", nextStartWeek);
		request.setAttribute("mm", mm);
		request.setAttribute("yy", yy);
	}

	@Override
	public List<TransactionVO> getUserList() {
		return study2DAO.getUserList();
	}

	@Override
	public int setValidatorOk(TransactionVO vo) {
		return study2DAO.setValidatorOk(vo);
	}

	@Override
	public int setValidatorDeleteOk(int idx) {
		return study2DAO.setValidatorDeleteOk(idx);
	}

	@Override
	public List<TransactionVO> getTransactionList() {
		return study2DAO.getTransactionList();
	}

	@Override
	public List<TransactionVO> getTransactionList2() {
		return study2DAO.getTransactionList2();
	}

	@Override
	public void setTransactionUser1Input(TransactionVO vo) {
		study2DAO.setTransactionUser1Input(vo);
	}

	@Override
	public void setTransactionUser2Input(TransactionVO vo) {
		study2DAO.setTransactionUser2Input(vo);
	}

	@Override
	public int setTransactionUserTotalInput(TransactionVO vo) {
		return study2DAO.setTransactionUserTotalInput(vo);
	}

	@Override
	public void setSaveCrimeCheck(CrimeVO vo) {
		study2DAO.setSaveCrimeCheck(vo);
	}

	@Override
	public int setDeleteCrimeCheck(int year) {
		return study2DAO.setDeleteCrimeCheck(year);
	}

	@Override
	public List<CrimeVO> getLoadCrimeCheck(int year) {
		return study2DAO.getLoadCrimeCheck(year);
	}

	@Override
	public CrimeVO getPoliceCheck(int year, String police) {
		return study2DAO.getPoliceCheck(year, police);
	}

	@Override
	public KakaoAddressVO getKakaoAddressSearch(String address) {
		return study2DAO.getKakaoAddressSearch(address);
	}

	@Override
	public int setKakaoAddressInput(KakaoAddressVO vo) {
		return study2DAO.setKakaoAddressInput(vo);
	}

	@Override
	public List<KakaoAddressVO> getKakaoAddressList() {
		return study2DAO.getKakaoAddressList();
	}

	@Override
	public int setKakaoAddressDelete(String address) {
		return study2DAO.setKakaoAddressDelete(address);
	}

	@Override
	public String setQrCodeCreate(String realPath, QrCodeVO vo) {
		String qrCodeName = projectProvide.saveFileName(vo.getMid());
		String qrCodeImage = "";
		String publishDate = "";	// 티켓 발행일자
		
		if(vo.getFlag() == 0) qrCodeImage = "생성된 QR코드명: " + qrCodeName;
		else if(vo.getFlag() == 1) {
			qrCodeImage = "생성날짜 : " + "20"+qrCodeName.substring(0,2) + "년, " + qrCodeName.substring(2,4) + "월, " + qrCodeName.substring(4,6) + "일\n";
			qrCodeImage += "아이디 : " + vo.getMid() + "\n";
			qrCodeImage += "성명 : " + vo.getName() + "\n";
			qrCodeImage += "이메일 : " + vo.getEmail();
		}
		else if(vo.getFlag() == 2) qrCodeImage = vo.getMoveUrl();
		else if(vo.getFlag() == 3 || vo.getFlag() == 4) {
			qrCodeImage = "구매자 ID : " + vo.getMid() + "\n";
			qrCodeImage += "영화제목 : " + vo.getMovieName() + "\n";
			qrCodeImage += "상영일자 : " + vo.getMovieDate() + "\n";
			qrCodeImage += "상영시간 : " + vo.getMovieTime() + "\n";
			qrCodeImage += "성인구매인원수 : " + vo.getMovieAdult() + "\n";
			qrCodeImage += "소인구매인원수 : " + vo.getMovieChild() + "\n";
			publishDate = "구매일자 : " + "20"+qrCodeName.substring(0,2) + "년 " + qrCodeName.substring(2,4) + "월 " + qrCodeName.substring(4,6) + "일 " + qrCodeName.substring(6,8) + "시 " + qrCodeName.substring(8,10) + "분";
			qrCodeImage += publishDate;
		}
		else if(vo.getFlag() == 4 || vo.getFlag() == 4) {
			qrCodeImage = "구매자 ID : " + vo.getMid() + "\n";
			qrCodeImage += "영화제목 : " + vo.getMovieName() + "\n";
			qrCodeImage += "상영일자 : " + vo.getMovieDate() + "\n";
			qrCodeImage += "상영시간 : " + vo.getMovieTime() + "\n";
			qrCodeImage += "성인구매인원수 : " + vo.getMovieAdult() + "\n";
			qrCodeImage += "소인구매인원수 : " + vo.getMovieChild() + "\n";
			publishDate = "구매일자 : " + "20"+qrCodeName.substring(0,2) + "년 " + qrCodeName.substring(2,4) + "월 " + qrCodeName.substring(4,6) + "일 " + qrCodeName.substring(6,8) + "시 " + qrCodeName.substring(8,10) + "분";
			qrCodeImage += publishDate;
		}
		
		try {
			// QR코드안의 한글 인코딩
			qrCodeImage = new String(qrCodeImage.getBytes("UTF-8"), "ISO-8859-1");
			
			// qr 코드 만들기
			QRCodeWriter qrCodeWriter = new QRCodeWriter();
			BitMatrix bitMatrix = qrCodeWriter.encode(qrCodeImage, BarcodeFormat.QR_CODE, 200, 200);
			
			int qrCodeColor = 0xFF000000;
			int qrCodeBackColor = 0xFFFFFFFF;
			
			MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig(qrCodeColor, qrCodeBackColor);
			BufferedImage bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix, matrixToImageConfig);
			
			ImageIO.write(bufferedImage, "png", new File(realPath + qrCodeName + ".png"));
			
			// 생성정보를 DB에 저장처리하는 Flag값이 4이면, QR코드 생성후, 생성된 정보를 DB에 저장시켜준다.
			if(vo.getFlag() == 4) {
				vo.setPublishDate(publishDate);
				vo.setQrCodeName(qrCodeName);
				study2DAO.setQrCodeCreate(vo);
			}
					
		} catch (IOException e) {
			e.printStackTrace();
		} catch (WriterException e) {
			e.printStackTrace();
		}
		return qrCodeName;
	}

	@Override
	public QrCodeVO getQrCodeSearch(String qrCode) {
		return study2DAO.getQrCodeSearch(qrCode);
	}

	@Override
	public String setThumbnailCreate(MultipartFile file, String mid, String realPath) {
		String res = "";
		try {
			String sFileName = projectProvide.saveFileName(mid) + "_" + file.getOriginalFilename();
			
			File realFileName = new File(realPath + sFileName);
			file.transferTo(realFileName);  // 원본 이미지 파일 저장
			
			String thumbnailSaveName = realPath + "s_" + sFileName;
			File thumbnailFile = new File(thumbnailSaveName);
			
			int width = 160;
			int height = 160 * 3 / 4;	// 가로:세로 = 4:3
			Thumbnailator.createThumbnail(realFileName, thumbnailFile, width, height);  // 썸네일 이미지 파일 저장
			
			res = sFileName;
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int setKakaoPlaceInput(KakaoPlaceVO vo) {
		return study2DAO.setKakaoPlaceInput(vo);
	}

	@Override
	public KakaoAddressVO getKakaoAddressSearchIdx(int idx) {
		return study2DAO.getKakaoAddressSearchIdx(idx);
	}

	@Override
	public List<KakaoPlaceVO> getKakaoAddressPlaceSearch(int idx) {
		return study2DAO.getKakaoAddressPlaceSearch(idx);
	}
}
