package com.spring.springGroupS.vo;

import lombok.Data;

@Data
public class PhotoGalleryVO {
	private int idx;
	private String mid;
	private String part;
	private String title;
	private String content;
	private String thumbnail;
	private int photoCount;
	private String hostIp;
	private String pDate;
	private int goodCount;
	private int readNum;
	
	// photoReply.sql(댓글 처리시에 필요한 필드들)
	private int replyIdx;
	private int photoIdx;
	private String prDate;
	
	private int replyCnt;	// 댓글 개수
}
