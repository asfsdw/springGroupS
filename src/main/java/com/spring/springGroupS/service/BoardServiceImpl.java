package com.spring.springGroupS.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.springGroupS.dao.BoardDAO;
import com.spring.springGroupS.vo.BoardReplyVO;
import com.spring.springGroupS.vo.BoardVO;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	BoardDAO boardDAO;

	@Override
	public List<BoardVO> getBoardList(int startIndexNo, int pageSize, String search, String searchStr) {
		return boardDAO.getBoardList(startIndexNo, pageSize, search, searchStr);
	}

	@Override
	public int getTotRecCnt(String flag, String search, String searchStr) {
		return boardDAO.getTotRecCnt(flag, search, searchStr);
	}

	@Override
	public int setBoardInput(BoardVO vo) {
		return boardDAO.setBoardInput(vo);
	}

	@Override
	public BoardVO getBoardContent(int idx) {
		return boardDAO.getBoardContent(idx);
	}

	@Override
	public List<BoardVO> getNewBoardList(String flag) {
		return boardDAO.getNewBoardList(flag);
	}

	// 파일 복사 준비.
	@Override
	public void imgCheck(String content) {
//										1					2					3					4
//					012345678901234567890123456789012345678901234567890
		// <img src="/springGroupS/data/ckeditor/250915174330_01.jpg" style="height:225px; width:300px" />
		// <img src="/springGroupS/data/board/250915174330_01.jpg" style="height:225px; width:300px" />
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 33;
		String nextImage = content.substring(content.indexOf("src=\"/")+position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImage.substring(0, nextImage.indexOf("\""));
			String oFilePath = realPath+"ckeditor/"+imgFile;
			String copyFilePath = realPath+"board/"+imgFile;
			
			fileCopyCheck(oFilePath, copyFilePath);
			
			if(nextImage.indexOf("src=\"/") == -1) sw = false;
			else nextImage = nextImage.substring(nextImage.indexOf("src=\"/")+position);
		}
	}
	// 파일 복사.
	private void fileCopyCheck(String oFilePath, String copyFilePath) {
		try {
			FileInputStream fis = new FileInputStream(new File(oFilePath));
			FileOutputStream fos = new FileOutputStream(new File(copyFilePath));
			
			byte[] bytes = new byte[2048];
			int cnt = 0;
			while((cnt=fis.read(bytes)) != -1) {
				fos.write(bytes, 0, cnt);
			}
			fos.flush();
			fos.close();
			fis.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void setBoardReadNum(int idx) {
		boardDAO.setBoardReadNum(idx);
	}

	@Override
	public void setBoardGood(int idx, int goodCnt) {
		boardDAO.setBoardGood(idx, goodCnt);
	}

	@Override
	public BoardVO getPreNextSearch(int idx, String str) {
		return boardDAO.getPreNextSearch(idx, str);
	}

	@Override
	public void imgBackup(String content) {
//								1					2					3					4
//			012345678901234567890123456789012345678901234567890
// <img src="/springGroupS/data/ckeditor/250915174330_01.jpg" style="height:225px; width:300px" />
// <img src="/springGroupS/data/board/250915174330_01.jpg" style="height:225px; width:300px" />
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 30;
		String nextImage = content.substring(content.indexOf("src=\"/")+position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImage.substring(0, nextImage.indexOf("\""));
			String oFilePath = realPath+"board/"+imgFile;
			String copyFilePath = realPath+"ckeditor/"+imgFile;
			
			fileCopyCheck(oFilePath, copyFilePath);
			
			if(nextImage.indexOf("src=\"/") == -1) sw = false;
			else nextImage = nextImage.substring(nextImage.indexOf("src=\"/")+position);
		}
	}

	@Override
	public int setBoardUpdate(BoardVO vo) {
		return boardDAO.setBoardUpdate(vo);
	}

	// 이미지 파일 삭제 준비.
	@Override
	public void imgDelete(String content) {
//							 1				 2				 3				 4
//		 012345678901234567890123456789012345678901234567890
//<img src="/springGroupS/data/board/250915174330_01.jpg" style="height:225px; width:300px" />
//<img src="/springGroupS/data/ckeditor/250915174330_01.jpg" style="height:225px; width:300px" />
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 30;
		String nextImage = content.substring(content.indexOf("src=\"/")+position);
		boolean sw = true;
		
		while(sw) {
		String imgFile = nextImage.substring(0, nextImage.indexOf("\""));
		String oFilePath = realPath+"board/"+imgFile;
		
		fileDelete(oFilePath);
		
		if(nextImage.indexOf("src=\"/") == -1) sw = false;
		else nextImage = nextImage.substring(nextImage.indexOf("src=\"/")+position);
		}
	}
	// 파일 삭제.
	private void fileDelete(String oFilePath) {
		File delFile = new File(oFilePath);
		if(delFile.exists()) delFile.delete();
	}

	@Override
	public int setBoardDelete(int idx) {
		return boardDAO.setBoardDelete(idx);
	}

	@Override
	public List<BoardReplyVO> getBoardReplyList(int boardIdx) {
		return boardDAO.getBoardReplyList(boardIdx);
	}

	@Override
	public BoardReplyVO getBoardParentReplyCheck(int boardIdx) {
		return boardDAO.getBoardParentReplyCheck(boardIdx);
	}

	@Override
	public int setBoardReplyInput(BoardReplyVO replyVO) {
		return boardDAO.setBoardReplyInput(replyVO);
	}

	@Override
	public void setBoardReplyOrderUp(int boardIdx, int re_order) {
		boardDAO.setBoardReplyOrderUp(boardIdx, re_order);
	}

	@Override
	public BoardReplyVO getBoardParentReplyIdxCheck(int idx) {
		return boardDAO.getBoardParentReplyIdxCheck(idx);
	}

	@Override
	public int setBoardReplyDelete(int idx) {
		return boardDAO.setBoardReplyDelete(idx);
	}

	@Override
	public int setBoardReplyUpdate(BoardReplyVO replyVO) {
		return boardDAO.setBoardReplyUpdate(replyVO);
	}

	@Override
	public void setBoardReplyOrderBy(int boardIdx, int ref, int re_order) {
		boardDAO.setBoardReplyOrderBy(boardIdx, ref, re_order);
	}
}
