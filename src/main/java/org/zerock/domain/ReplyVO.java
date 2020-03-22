package org.zerock.domain;



import java.util.Date;

import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
public class ReplyVO {

	private int bno;
	private int rno;
	
	private String reply;
	private String replyer;
	private Date replydate;
	private Date updateDate;
}
