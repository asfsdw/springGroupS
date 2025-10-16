package com.spring.springGroupS.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.springGroupS.vo.PhotoGalleryVO;

public interface PhotoGalleryService {

	public int imgCheck(PhotoGalleryVO vo, String realPath);

	public List<PhotoGalleryVO> getPhotoGalleryList(int startIndexNo, int pageSize, String part, String choice);

	public void setPhotoGalleryReadNumPlus(int idx);

	public PhotoGalleryVO getPhotoGalleryIdxSearch(int idx);

	public ArrayList<PhotoGalleryVO> getPhotoGalleryReply(int idx);

	public List<String> getPhotoGalleryPhotoList(String content);

	public int setPhotoGalleryReplyInput(PhotoGalleryVO vo);

	public int setPhotoGalleryReplyDelete(int idx);

	public void setPhotoGalleryGoodPlus(int idx);

	public int setPhotoGalleryDelete(int idx);

	public List<PhotoGalleryVO> setPhotoGallerySingle(int startIndexNo, int pageSize);

	public void imgBackup(String content);

	public void imgDelete(String content);

	public int setPhotoGallery(PhotoGalleryVO vo);

}
