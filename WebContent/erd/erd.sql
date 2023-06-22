


create database kickoff;

--------- 이거 먼저하고 use kickoff; 이후 작업할것 ----------------



create table userinfo 
(
	user_no int not null auto_increment primary key comment '회원번호',
	user_id varchar(50) not null comment '아이디',
	user_pw varchar(100) not null comment '비밀번호',
	user_name varchar(50) not null comment '이름',
	user_nick varchar(50) not null comment '닉네임',
	user_gender char not null comment '성별',
	user_mail varchar(100) not null comment '이메일',
	user_grade int default '1' comment '회원등급',
	user_exit char default 'n' comment '탈퇴여부',
	user_date datetime default now() comment '가입일자'
) comment '회원정보';

create table post
(
	post_no int not null auto_increment primary key comment '게시글번호',
	post_title varchar(100) not null comment '제목',
	post_note text not null comment '내용',
	post_oname varchar(100) comment '원본파일명',
	post_pname varchar(100) comment '암호화파일명',
	post_mcate varchar(30) not null comment '메인카테고리',
	post_scate varchar(30) comment '서브카테고리',
	post_view int default 0 comment '조회수',
	post_date datetime default now() comment '등록일자',
	post_type char not null comment '게시판유형',
	post_blind char default 'n' comment '블라인드여부',
	user_no int comment '회원번호',
	foreign key (user_no) references userinfo(user_no)
) comment '게시판';

create table reply
(
	reply_no int not null auto_increment primary key comment '댓글번호',
	reply_date datetime default now() comment '작성일',
	reply_note text not null comment '댓글내용',
	reply_blind char default 'n' comment '블라인드여부',
	user_no int comment '회원번호',
	post_no int comment '게시글번호',
	foreign key (user_no) references userinfo(user_no),
	foreign key (post_no) references post(post_no)
) comment '댓글';

create table like_hate
(
	like_hate char comment '좋아요싫어요',
	user_no int comment '회원번호',
	post_no int comment '게시글번호',
	reply_no int comment '댓글번호',
	foreign key (user_no) references userinfo(user_no),
	foreign key (post_no) references post(post_no),
	foreign key (reply_no) references reply(reply_no)
) comment '좋아요싫어요';

create table analyze_data1
(
	anal_no int auto_increment primary key comment '분석번호',
	morph_origin_key longtext comment '형태소 원본단어',
	post_no int comment '게시물번호',
	anal_count int default 0 comment '빈도수',
	foreign key (post_no) references post(post_no)
) comment '분석데이터';

create table analyze_data2
(
	analdata_no int auto_increment primary key comment '연관번호',
	morph_relation_key longtext comment '형태소 분석단어',
	anal_no int comment '분석번호',
	foreign key (anal_no) references analyze_data1(anal_no)
) comment '분석데이터';


create table ad_info
(
	ad_no int auto_increment primary key comment '광고번호',
	ad_name varchar(50) comment '광고이름',
	ad_keyword varchar(200) comment '광고키워드',
	ad_exposure int default 0 comment '광고노출횟수',
	ad_click int default 0 comment '광고클릭횟수',
	w_image_phyname varchar(100) comment '가로이미지 물리명',
	w_image_fname varchar (100) comment '가로이미지 논리명',
	h_image_phyname varchar (100) comment '세로이미지 물리명',
	h_image_fname varchar (100) comment '세로이미지 논리명',
	user_no int comment '회원번호',
	post_no int comment '게시물번호',
	foreign key (user_no) references userinfo(userv_no),
	foreign key (post_no) references post(post_no)
) comment '광고정보';