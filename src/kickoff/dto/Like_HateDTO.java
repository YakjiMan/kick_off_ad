//좋아요 싫어요 관리 클래스

package kickoff.dto;

import kickoff.dao.*;
import kickoff.vo.*;

public class Like_HateDTO extends DBManager
{
	//게시물 좋아요,싫어요 insert 하기
	public boolean InsertPostLH(Like_HateVO vo)
	{
		this.DBOpen();
		
		String sql = "";
		sql  = "insert into like_hate ";
		sql += "(user_no,post_no,like_hate) values ";
		sql += "('" + vo.getUser_no() + "','" + vo.getPost_no() + "','"  + vo.getLike_hate() + "') ";
		this.RunCommand(sql);
		
		this.DBClose();
		return true;
	}
	//게시물 좋아요,싫어요 delete 하기
	public boolean DeletePostLH(Like_HateVO vo)
	{
		this.DBOpen();
		
		String sql = "";
		sql  = "delete from like_hate ";
		sql += "where user_no='" + vo.getUser_no() + "' and ";
		sql += "post_no='" + vo.getPost_no() + "' ";
		this.RunCommand(sql);
		
		this.DBClose();
		return true;
	}
	//댓글 좋아요,싫어요 insert 하기
	public boolean InsertReplyLH(Like_HateVO vo)
	{
		this.DBOpen();
		
		String sql = "";
		sql  = "insert into like_hate ";
		sql += "(user_no,reply_no,like_hate) values ";
		sql += "('" + vo.getUser_no() + "','" + vo.getReply_no() + "','"  + vo.getLike_hate() + "') ";
		this.RunCommand(sql);
		
		this.DBClose();
		return true;
	}
	//댓글 좋아요,싫어요 delete 하기
	public boolean DeleteReplyLH(Like_HateVO vo)
	{
		this.DBOpen();
		
		String sql = "";
		sql  = "delete from like_hate ";
		sql += "where reply_no='" + vo.getUser_no() + "' and ";
		sql += "post_no='" + vo.getReply_no() + "' ";
		this.RunCommand(sql);
		
		this.DBClose();
		return true;
	}
	//게시글 좋아요,싫어요 사전유무 체크하기
	public String PostCheckLH(Like_HateVO vo)
	{
		this.DBOpen();
		
		String sql = "";
		sql  = "select user_no,post_no,like_hate from like_hate ";
		sql += "where user_no='" + vo.getUser_no() + "' and ";
		sql += "post_no='" + vo.getPost_no() + "' ";
		this.RunQuery(sql);
		if(this.GetNext() == false)
		{
			this.DBClose();
			return "n";
		}
		String like_hate = this.GetValue("like_hate");
		this.DBClose();
		return like_hate;
	}
	//댓글 좋아요,싫어요 사전유무 체크하기
	public String ReplyCheckLH(Like_HateVO vo)
	{
		this.DBOpen();
		
		String sql = "";
		sql  = "select user_no,reply_no,like_hate from like_hate ";
		sql += "where user_no='" + vo.getUser_no() + "' and ";
		sql += "reply_no='" + vo.getReply_no() + "' ";
		
		this.RunQuery(sql);
		if(this.GetNext() == false)
		{
			this.DBClose();
			return "n";
		}
		
		String like_hate = this.GetValue("like_hate");
		this.DBClose();
		return like_hate;
	}
	//게시물 좋아요 갯수 불러오기
	public String PostLike(String post_no)
	{
		this.DBOpen();
		
		String sql = "";
		sql  = "select count(*) as like_count from like_hate ";
		sql += "where post_no = " + post_no + " and like_hate = 'l' ";
		this.RunQuery(sql);
		this.GetNext();
		String like_count = this.GetValue("like_count");
		this.DBClose();
		return like_count;
	}
	
	//게시물 싫어요 갯수 불러오기
	public String PostHate(String post_no)
	{
		this.DBOpen();
		
		String sql = "";
		sql  = "select count(*) as hate_count from like_hate ";
		sql += "where post_no = " + post_no + " and like_hate = 'h' ";
		this.RunQuery(sql);
		this.GetNext();
		String hate_count = this.GetValue("hate_count");
		this.DBClose();
		return hate_count;
	}
	
	//댓글 좋아요 갯수 불러오기
	public String ReplyLike(String reply_no)
	{
		this.DBOpen();
		
		String sql = "";
		sql  = "select count(*) as like_count from like_hate ";
		sql += "where reply_no = " + reply_no + " and like_hate = 'l' ";
		this.RunQuery(sql);
		this.GetNext();
		String like_count = this.GetValue("like_count");
		this.DBClose();
		return like_count;
	}
	
	//댓글 싫어요 갯수 불러오기
	public String ReplyHate(String reply_no)
	{
		this.DBOpen();
		
		String sql = "";
		sql  = "select count(*) as hate_count from like_hate ";
		sql += "where reply_no = " + reply_no + " and like_hate = 'h' ";
		this.RunQuery(sql);
		this.GetNext();
		String hate_count = this.GetValue("hate_count");
		this.DBClose();
		return hate_count;
	}
}
