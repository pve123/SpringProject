package org.zerock.domain;

import java.util.Date;


import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class BoardVO {

	private int bno;
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	private Date updateDate;
	
	private int replyCnt;
}
