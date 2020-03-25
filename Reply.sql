create table tbl_reply (
    
    rno number,
    bno number not null,
    reply varchar2(1000) not null,
    replyer VARCHAR2(50) not null,
    replyDate date default SYSDATE,
    updateDate date default SYSDATE,
    
    CONSTRAINT pk_reply PRIMARY KEY(rno),
    CONSTRAINT fk_reply_bno FOREIGN KEY(bno) REFERENCES tbl_board(bno)
);

create SEQUENCE seq_reply;
drop table tbl_reply;
drop SEQUENCE seq_reply;
commit;