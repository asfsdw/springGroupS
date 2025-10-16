package com.spring.springGroupS.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springGroupS.vo.PhotoGalleryVO;

public interface PhotoGalleryDAO {

	public int setPhotoGalleryInput(@Param("vo") PhotoGalleryVO vo);

	public List<PhotoGalleryVO> getPhotoGalleryList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("part") String part, @Param("choice") String choice);

	public void setPhotoGalleryReadNumPlus(@Param("idx") int idx);

	public PhotoGalleryVO getPhotoGalleryIdxSearch(@Param("idx") int idx);

	public ArrayList<PhotoGalleryVO> getPhotoGalleryReply(@Param("idx") int idx);

	public int setPhotoGalleryReplyInput(@Param("vo") PhotoGalleryVO vo);

	public int setPhotoGalleryReplyDelete(@Param("idx") int idx);

	public void setPhotoGalleryGoodPlus(@Param("idx") int idx);

	public int setPhotoGalleryDelete(@Param("idx") int idx);

	public int[] getPhotoGalleryIdxList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public PhotoGalleryVO setPhotoGallerySingle(@Param("idx") int idx);

	public int setPhotoGallery(@Param("vo") PhotoGalleryVO vo);

	public int setPhotoGalleryUpdate(@Param("vo") PhotoGalleryVO vo);

}
