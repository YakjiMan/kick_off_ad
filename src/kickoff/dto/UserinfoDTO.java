//회원정보 관리 클래스

package kickoff.dto;

import kickoff.dao.*;
import kickoff.vo.*;

public class UserinfoDTO extends DBManager
{
	//아이디 중복검사 메소드
	//True : 중복된 아이디 , False : 중복이 아닌 아이디
	public boolean CheckID(String id)
	{
		this.DBOpen();
		
		String sql = "";
		sql = "select user_id from userinfo where user_id = '" + this._R(id) + "' ";
		this.RunQuery(sql);
		if(this.GetNext() == true)
		{
			this.DBClose();
			return true;
		}
		
		this.DBClose();
		return false;
	}
	
	//회원가입 메소드
	//true : 회원가입 성공 , False : 회원가입 실패
	public boolean Join(UserinfoVO vo)
	{
		UserinfoDTO dto = new UserinfoDTO();
		
		if(dto.CheckID(vo.getUser_id()) == true)
		{
			return false;
		}
		//insert 구문 입력
		String sql = "";
		this.DBOpen();
		sql  = "insert into userinfo ";
		sql += "(user_id,user_pw,user_name,user_nick,user_gender,user_mail) ";
		sql += "values (";
		sql += "'" + _R(vo.getUser_id()) + "',";
		sql += "md5('" + _R(vo.getUser_pw()) + "'),";
		sql += "'" + _R(vo.getUser_name()) + "',";
		sql += "'" + _R(vo.getUser_nick()) + "',";
		sql += "'" + vo.getUser_gender() + "',";
		sql += "'" + _R(vo.getUser_mail()) + "') ";
		this.RunCommand(sql);
		this.DBClose();
		
		return true;
	}
	
	//로그인처리 메소드
	public UserinfoVO Login(String id, String pw)
	{
		this.DBOpen();
		
		String sql = "";
		sql  = "select user_no,user_id,user_pw,user_name,user_nick,user_gender,user_mail,user_grade ";
		sql += "from userinfo ";
		sql += "where user_id='" + _R(id) + "' and ";
		sql += "user_pw=md5('" + _R(pw) + "') and ";
		sql += "user_exit='n'";
		this.RunQuery(sql);
		if(this.GetNext() == false)
		{
			this.DBClose();
			return null;
		}
		
		UserinfoVO vo = new UserinfoVO();
		vo.setUser_no(this.GetValue("user_no"));
		vo.setUser_id(id);
		vo.setUser_nick(this.GetValue("user_nick"));
		vo.setUser_name(this.GetValue("user_name"));
		vo.setUser_mail(this.GetValue("user_mail"));
		vo.setUser_gender(this.GetValue("user_gender"));
		vo.setUser_grade(this.GetValue("user_grade"));
		vo.setUser_pw(this.GetValue("user_pw"));
		
		this.DBClose();
		return vo;
	}
	
	//ID불러오기 메소드
	public String FindID(String name, String mail)
	{
		this.DBOpen();
		
		String sql = "";
		sql  = "select user_id,user_exit from userinfo ";
		sql += "where user_name='" + name + "' and ";
		sql += "user_mail='" + mail + "' ";
		this.RunQuery(sql);
		if(this.GetNext() == false)
		{
			this.DBClose();
			return null;
		}
		if(this.GetValue("user_exit").equals("y"))
		{
			this.DBClose();
			return "exit";
		}
		String user_id   = this.GetValue("user_id");
		this.DBClose();
		
		return user_id;
	}
	
	//회원정보 확인
	public String CheckInfo(String name, String id)
	{
		this.DBOpen();
		
		String sql = "";
		sql  = "select * from userinfo ";
		sql += "where user_name='" + name + "' and ";
		sql += "user_id='" + id + "' ";
		this.RunQuery(sql);
		if(this.GetNext() == false)
		{
			this.DBClose();
			return null;
		}
		if(this.GetValue("user_exit").equals("y"))
		{
			this.DBClose();
			return "exit";
		}
		this.DBClose();
		
		return "ok";
	}
	
	//비밀번호 변경 메소드
	//true : 변경성공 , false : 변경실패
	public boolean UpdatePW(String id, String name,String pw)
	{
		//insert 구문 입력
		String sql = "";
		this.DBOpen();
		sql  = "update userinfo set ";
		sql += "user_pw=md5('" + _R(pw) + "') ";
		sql += "where user_id='" + _R(id) + "' and ";
		sql += "user_name='" + _R(name) + "' ";
		this.RunCommand(sql);
		this.DBClose();
		
		return true;
	}
	
	//유저정보 불러오기
	public UserinfoVO Read(String no)
	{
		String sql = "";
		this.DBOpen();
		
		sql += "select ";
		sql += "user_no,user_name,user_grade,user_gender,user_id,user_nick,user_mail,user_date,user_exit ";
		sql += "from userinfo where user_no = " + no;
		this.RunQuery(sql);
		if(this.GetNext() == false)
		{
			this.DBClose();
			return null;
		}
		UserinfoVO vo = new UserinfoVO();
		vo.setUser_no(this.GetValue("user_no"));
		vo.setUser_id(this.GetValue("user_id"));
		vo.setUser_name(this.GetValue("user_name"));
		vo.setUser_nick(this.GetValue("user_nick"));
		vo.setUser_mail(this.GetValue("user_mail"));
		vo.setUser_gender(this.GetValue("user_gender"));
		vo.setUser_date(this.GetValue("user_date"));
		vo.setUser_grade(this.GetValue("user_grade"));
		vo.setUser_exit(this.GetValue("user_exit"));
		
		
		this.DBClose();
		return vo;
	}
	
	//관리자페이지 유저정보수정
	public boolean AdminUpdate(UserinfoVO vo)
	{
		this.DBOpen();
		
		String sql = "";
		sql  = "update userinfo set ";
		sql += "user_id='" + _R(vo.getUser_id()) + "',";
		sql += "user_name='" + _R(vo.getUser_name()) + "',";
		sql += "user_nick='" + _R(vo.getUser_nick()) + "',";
		sql += "user_gender='" + vo.getUser_gender() + "',";
		sql += "user_mail='" + _R(vo.getUser_mail()) + "',";
		sql += "user_grade='" + vo.getUser_grade() + "',";
		sql += "user_exit='" + vo.getUser_exit() + "' ";
		sql += "where user_no=" + vo.getUser_no();
		
		this.RunCommand(sql);
		this.DBClose();
		return true;
	}
	
	//마이페이지 유저정보수정
	public boolean UserUpdate(UserinfoVO vo)
	{
		this.DBOpen();
		
		String sql = "";
		sql  = "update userinfo set ";
		sql += "user_name='" + _R(vo.getUser_name()) + "',";
		sql += "user_nick='" + _R(vo.getUser_nick()) + "',";
		sql += "user_gender='" + vo.getUser_gender() + "',";
		sql += "user_mail='" + _R(vo.getUser_mail()) + "' ";
		sql += "where user_no=" + vo.getUser_no();
		
		this.RunCommand(sql);
		this.DBClose();
		return true;
	}
	
	//회원탈퇴 메소드
	public boolean UserExit(String no)
	{
		this.DBOpen();
		
		String sql = "";
		sql  = "update userinfo set ";
		sql += "user_exit='y' ";
		sql += "where user_no=" + no;
		
		this.RunCommand(sql);
		this.DBClose();
		return true;
	}
}
