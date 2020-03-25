create sequence seq_board;
create table tbl_board(

    bno number PRIMARY KEY,
    title varchar2(200) not null,
    content varchar2(2000) not null,
    writer varchar2(50) not null,
    regdate date default sysdate,
    updatedate date default sysdate
    


);
drop sequence seq_board;
DROP table tbl_board;


insert into tbl_board(bno,title,content,writer)
values(seq_board.nextval,'테스트 중입니다.','테스트 중입니다.','이호성');

alter table tbl_board add (replycnt number default 0);
update tbl_board set replycnt = 0;

commit;


