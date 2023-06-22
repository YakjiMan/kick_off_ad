//회원정보 클래스

package kickoff.vo;

public class UserinfoVO 
{
	private String user_no;     //회원번호
	private String user_id;     //아이디
	private String user_pw;     //비밀번호
	private String user_name;   //이름
	private String user_nick;   //닉네임
	private String user_gender; //성별
	private String user_mail;   //이메일주소
	private String user_grade;  //회원등급
	private String user_exit;   //탈퇴여부
	private String user_date;   //가입일자
	
	public UserinfoVO()  //생성자
	{
		user_no     = "";
		user_id     = "";
		user_pw     = "";
		user_name   = "";
		user_nick   = "";
		user_gender = "";
		user_mail   = "";
		user_grade  = "1";
		user_exit   = "n";
		user_date   = "";
	}

	public String getUser_no()     { return user_no;     }
	public String getUser_id()     { return user_id;     }
	public String getUser_pw()     { return user_pw;     }
	public String getUser_name()   { return user_name;   }
	public String getUser_nick()   { return user_nick;   }
	public String getUser_gender() { return user_gender; }
	public String getUser_mail()   { return user_mail;   }
	public String getUser_grade()  { return user_grade;  }
	public String getUser_exit()   { return user_exit;   }
	public String getUser_date()   { return user_date;   }
	
	public void setUser_no(String user_no)         { this.user_no     = user_no;     }
	public void setUser_id(String user_id)         { this.user_id     = user_id;     }
	public void setUser_pw(String user_pw)         { this.user_pw     = user_pw;     }
	public void setUser_name(String user_name)     { this.user_name   = user_name;   }
	public void setUser_nick(String user_nick)     { this.user_nick   = user_nick;   }
	public void setUser_gender(String user_gender) { this.user_gender = user_gender; }
	public void setUser_mail(String user_mail)     { this.user_mail   = user_mail;   }
	public void setUser_grade(String user_grade)   { this.user_grade  = user_grade;  }
	public void setUser_exit(String user_exit)     { this.user_exit   = user_exit;   }
	public void setUser_date(String user_date)     { this.user_date   = user_date;   }
}
