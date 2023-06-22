//게시물 클래스

package kickoff.vo;

public class PostVO
{
	private String post_no;      //게시물번호
	private String post_title;   //제목
	private String post_note;    //내용
	private String post_oname;   //첨부파일 기존이롬   (논리명)
	private String post_pname;   //첨부파일 암호화이름(물리명) 
	private String post_mcate;   //메인 카테고리
	private String post_scate;   //서브 카테고리
	private String post_source;  //출처
	private String post_view;    //조회수
	private String post_date;    //작성일자
	private String post_type;    //게시판유형
	private String post_blind;   //블라인드여부
	private String post_video;   //영상주소
	private String user_no;      //작성회원 번호
	private String user_name;    //작성회원 이름
	private String user_nick;    //작성회원 닉네임
	private String reply_count;  //댓글갯수
	private String like_count;   //좋아요갯수
	private String post_posneg;  //게시글 긍부정
	private String post_percent; //긍부정 퍼센트
	private String post_figname; //문장별 긍부정 그래프 파일명
	
	
	public PostVO()
	{
		post_no      = "";
		post_title   = "";
		post_note    = "";
		post_oname   = "";
		post_pname   = "";
		post_mcate   = "";
		post_scate   = "";
		post_source  = "";
		post_view    = "0";
		post_date    = "";
		post_type    = "";
		post_video   = "";
		post_blind   = "n";
		user_no      = "";
		user_name    = "";
		user_nick    = "";
		reply_count  = "0";
		like_count   = "0";
		post_posneg  = "";
		post_percent = "0";
		post_figname = "";
	}


	public String getPost_no()       { return post_no;      }
	public String getPost_title()    { return post_title;   }
	public String getPost_note()     { return post_note;    }
	public String getPost_oname()    { return post_oname;   }
	public String getPost_pname()    { return post_pname;   }
	public String getPost_mcate()    { return post_mcate;   }
	public String getPost_scate()    { return post_scate;   }
	public String getPost_source()   { return post_source;  }
	public String getPost_view()     { return post_view;    }
	public String getPost_date()     { return post_date;    }
	public String getPost_type()     { return post_type;    }
	public String getPost_video()    { return post_video;   }
	public String getPost_blind()    { return post_blind;   }
	public String getUser_no()       { return user_no;      }
	public String getUser_name()     { return user_name;    }
	public String getUser_nick()     { return user_nick;    }
	public String getReply_count()   { return reply_count;  }
	public String getLike_count()    { return like_count;   }
	public String getPost_posneg()   { return post_posneg;  }
	public String getPost_percent()  { return post_percent; }
	public String getPost_figname()  { return post_figname; }

	public void setPost_no(String post_no)             { this.post_no     = post_no;        }
	public void setPost_title(String post_title)       { this.post_title  = post_title;     }
	public void setPost_note(String post_note)         { this.post_note   = post_note;      }
	public void setPost_oname(String post_oname)       { this.post_oname  = post_oname;     }
	public void setPost_pname(String post_pname)       { this.post_pname  = post_pname;     }
	public void setPost_mcate(String post_mcate)       { this.post_mcate  = post_mcate;     }
	public void setPost_scate(String post_scate)       { this.post_scate  = post_scate;     }
	public void setPost_source(String post_source)     { this.post_source = post_source;    }
	public void setPost_view(String post_view)         { this.post_view   = post_view;      }
	public void setPost_date(String post_date)         { this.post_date   = post_date;      }
	public void setPost_type(String post_type)         { this.post_type   = post_type;      }
	public void setPost_video(String post_video)       { this.post_video  = post_video;     }
	public void setPost_blind(String post_blind)       { this.post_blind  = post_blind;     }
	public void setUser_no(String user_no)             { this.user_no     = user_no;        }
	public void setUser_name(String user_name)         { this.user_name   = user_name;      }
	public void setUser_nick(String user_nick)         { this.user_nick   = user_nick;      }
	public void setReply_count(String reply_count)     { this.reply_count = reply_count;    }
	public void setLike_count(String like_count)       { this.like_count  = like_count;     }
	public void setPost_posneg(String post_posneg)     { this.post_posneg  = post_posneg;   }
	public void setPost_percent(String post_percent)   { this.post_percent  = post_percent; }
	public void setPost_figname(String post_figname)   { this.post_figname  = post_figname; }
	
	
}
