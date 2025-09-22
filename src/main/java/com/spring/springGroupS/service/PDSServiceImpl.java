package com.spring.springGroupS.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.springGroupS.common.ProjectProvide;
import com.spring.springGroupS.dao.PDSDAO;
import com.spring.springGroupS.vo.PDSVO;

@Service
public class PDSServiceImpl implements PDSService {
	@Autowired
	PDSDAO pdsDAO;
	@Autowired
	ProjectProvide projectProvide;

	@Override
	public int getTotRecCnt(String flag, String part, String search, String searchStr) {
		return pdsDAO.getTotRecCnt(flag, part, search, searchStr);
	}

	@Override
	public List<PDSVO> getPDSList(int startIndexNo, int pageSize, String part, String search, String searchStr) {
		return pdsDAO.getPDSList(startIndexNo, pageSize, part, search, searchStr);
	}

	// 파일 업로드.
	@Override
	public int setPDSInput(MultipartHttpServletRequest mFile, PDSVO vo) {
		try {
			String oFileNames = "";
			String sFileNames = "";
			String fileSize = "";
			
			List<MultipartFile> fileList = mFile.getFiles("file");
			for(MultipartFile file : fileList) {
				String oFileName = file.getOriginalFilename();
				String sFileName = projectProvide.saveFileName(oFileName);
				
				projectProvide.writeFile(file, sFileName, "pds");
				
				oFileNames += oFileName + "/";
				sFileNames += sFileName + "/";
				fileSize += file.getSize() + "/";
			}
			oFileNames = oFileNames.substring(0, oFileNames.length()-1);
			sFileNames = sFileNames.substring(0, sFileNames.length()-1);
			fileSize = fileSize.substring(0, fileSize.length()-1);
			
			vo.setFName(oFileNames);
			vo.setFsName(sFileNames);
			vo.setFSize(fileSize);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return pdsDAO.setPDSInput(vo);
	}

	@Override
	public PDSVO getPDSContent(int idx) {
		return pdsDAO.getPDSContent(idx);
	}

	@Override
	public int setDownNumCheck(int idx) {
		return pdsDAO.setDownNumCheck(idx);
	}

	// 파일 삭제.
	@Override
	public int setDeleteCheck(HttpServletRequest request, int idx, String fsName) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/pds/");
		String[] sFileName = fsName.split("/");
		for(String sName : sFileName) {
			File file = new File(realPath+sName);
			if(!file.isDirectory()) file.delete();
		}
		return pdsDAO.setDeleteCheck(idx);
	}
}
