//댓글관리 클래스

package kickoff.dto;

import kickoff.dao.*;
import kickoff.vo.*;
import java.util.*;

public class ReplyDTO extends DBManager 
{
	//댓글을 등록한다.
	public boolean Insert(ReplyVO vo)
	{
		this.DBOpen();

		//댓글을 Insert 한다.
		String sql = "";
		sql += "insert into reply (post_no,user_no,reply_note) values ";
		sql += "('" + vo.getPost_no() + "','" + vo.getUser_no() + "','" +_R(vo.getReply_note()) + "') ";
		this.RunCommand(sql);		
		
		//등록된 댓글의 번호를 얻는다.
		sql = "select last_insert_id() as no ";
		this.RunQuery(sql);
		this.GetNext();
		vo.setReply_no(this.GetValue("no"));		
		
		this.DBClose();
		return true;
	}
	
	//댓글을 삭제한다.
	public boolean Delete(String reply_no)
	{
		this.DBOpen();
		
		String sql = "";
		
		sql = "delete from like_hate where reply_no " + reply_no;
		this.RunCommand(sql);
		sql = "delete from reply where reply_no = " + reply_no;
		this.RunCommand(sql);
		
		this.DBClose();
		
		return true;
	}
	
	//댓글을 업데이트한다.
	public boolean Update(ReplyVO vo)
	{
		this.DBOpen();
		
		String sql = "";
		sql  = "update reply set ";
		sql += "reply_note='" + _R(vo.getReply_note()) + "' ";
		sql += "where reply_no='" + vo.getReply_no() + "' ";

		this.RunCommand(sql);
		this.DBClose();
		return true;
	}
	
	//댓글의 목록을 조회한다.
	public ArrayList<ReplyVO> GetList(String no)
	{
		ArrayList<ReplyVO> list = new ArrayList<ReplyVO>();
		
		this.DBOpen();
		
		String sql = "";
		sql  = "select reply_no,user_no,reply_note,reply_blind,date(reply_date) as reply_date,";
		sql += "(select user_name from userinfo where user_no = reply.user_no) as reply_name, ";
		sql += "(select user_nick from userinfo where user_no = reply.user_no) as reply_nick ";
		sql += "from reply ";
		sql += "where post_no = " + no + " ";
		sql += "order by reply_no desc ";
		this.RunQuery(sql);
		while(this.GetNext() == true)
		{
			ReplyVO vo = new ReplyVO();
			vo.setPost_no(no);
			vo.setReply_no(this.GetValue("reply_no"));
			vo.setUser_no(this.GetValue("user_no"));
			vo.setReply_note(this.GetValue("reply_note"));
			vo.setReply_blind(this.GetValue("reply_blind"));
			vo.setReply_date(this.GetValue("reply_date"));
			vo.setUser_name(this.GetValue("reply_name"));
			vo.setUser_nick(this.GetValue("reply_nick"));
			
			list.add(vo);
		}
		
		this.DBClose();
		return list;
	}
}
