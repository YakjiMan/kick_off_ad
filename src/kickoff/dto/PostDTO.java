//�Խù� ���� Ŭ����

package kickoff.dto;

import kickoff.dao.*;
import kickoff.vo.*;

public class PostDTO extends DBManager
{
	//�����Խ��� insert �޼ҵ�
	public boolean Insert(PostVO vo)
	{
		this.DBOpen();
		
		String sql = "";
		sql += "insert into post ";
		sql += "(user_no,post_title,post_type,post_note,post_mcate,post_oname,post_pname) ";
		if( !vo.getPost_oname().equals("") || !vo.getPost_oname().equals("null"))
		{
			//÷�������� �ִ� ���
			sql += "values ('" + vo.getUser_no() + "','" + _R(vo.getPost_title()) + "','" + vo.getPost_type() + "','" + _R(vo.getPost_note()) + "','";
			sql += vo.getPost_mcate() + "','" + vo.getPost_oname() + "','" + vo.getPost_pname() +"') ";
		}
		else
		{
			//÷�������� ���� ���
			sql += "values ('" + vo.getUser_no() + "','" + _R(vo.getPost_title()) + "','" + vo.getPost_type() + "','" + _R(vo.getPost_note()) + "','"; 
			sql += vo.getPost_mcate() + "',null,null) ";
		}
		this.RunCommand(sql);

		//��ϵ� �Խù� ��ȣ�� ��´�.
		sql = "select last_insert_id() as post_no ";
		this.RunQuery(sql);
		this.GetNext();
		vo.setPost_no(this.GetValue("post_no"));
		
		this.DBClose();
		
		return true;
	}
	//�����Խ��� insert �޼ҵ�
	public boolean NewsInsert(PostVO vo)
	{
		this.DBOpen();
		
		String sql = "";
		sql += "insert into post ";
		sql += "(user_no,post_title,post_type,post_note,post_mcate,post_source,post_oname,post_pname) ";
		if( !vo.getPost_oname().equals("") || !vo.getPost_oname().equals("null"))
		{
			//÷�������� �ִ� ���
			sql += "values ('" + vo.getUser_no() + "','" + _R(vo.getPost_title()) + "','" + vo.getPost_type() + "','" + _R(vo.getPost_note()) + "','";
			sql += vo.getPost_mcate() + "','" + vo.getPost_source() + "','" + vo.getPost_oname() + "','" + vo.getPost_pname() +"') ";
		}
		else
		{
			//÷�������� ���� ���
			sql += "values ('" + vo.getUser_no() + "','" + _R(vo.getPost_title()) + "','" + vo.getPost_type() + "','" + _R(vo.getPost_note()) + "','"; 
			sql += vo.getPost_mcate() + "','" + vo.getPost_source() + "',null,null) ";
		}
		this.RunCommand(sql);

		//��ϵ� �Խù� ��ȣ�� ��´�.
		sql = "select last_insert_id() as post_no ";
		this.RunQuery(sql);
		this.GetNext();
		vo.setPost_no(this.GetValue("post_no"));
		
		this.DBClose();
		return true;
	}
	//����Խ��� insert �޼ҵ�
		public boolean VideoInsert(PostVO vo)
		{
			this.DBOpen();
			
			String sql = "";
			sql += "insert into post ";
			sql += "(user_no,post_title,post_type,post_note,post_mcate,post_scate,post_source,post_video,post_oname,post_pname) ";
			if( !vo.getPost_oname().equals("") || !vo.getPost_oname().equals("null"))
			{
				//÷�������� �ִ� ���
				sql += "values ('" + vo.getUser_no() + "','" + _R(vo.getPost_title()) + "','" + vo.getPost_type() + "','" + _R(vo.getPost_note()) + "','";
				sql += vo.getPost_mcate() + "','" + vo.getPost_scate() + "','" + vo.getPost_source() + "','" + vo.getPost_video() + "','" + vo.getPost_oname() + "','" + vo.getPost_pname() +"') ";
			}
			else
			{
				//÷�������� ���� ���
				sql += "values ('" + vo.getUser_no() + "','" + _R(vo.getPost_title()) + "','" + vo.getPost_type() + "','" + _R(vo.getPost_note()); 
				sql += vo.getPost_mcate() + "','" + vo.getPost_scate() + "','" + vo.getPost_source() + "','" + vo.getPost_video() + "',null,null) ";
			}
			this.RunCommand(sql);

			//��ϵ� �Խù� ��ȣ�� ��´�.
			sql = "select last_insert_id() as post_no ";
			this.RunQuery(sql);
			this.GetNext();
			vo.setPost_no(this.GetValue("post_no"));
			
			this.DBClose();
			return true;
		}
	//�����Խ��� ������Ʈ �޼ҵ�
	public boolean Update(PostVO vo)
	{
		this.DBOpen();
		
		String sql = "";
		sql  = "update post set ";
		sql += "post_title='" + _R(vo.getPost_title()) + "',";
		sql += "post_note='" + _R(vo.getPost_note()) + "',";
		if(!vo.getPost_pname().equals("") || !vo.getPost_oname().equals("null"))
		{
			sql += "post_mcate='" + vo.getPost_mcate() + "',";
			sql += "post_oname='" + _R(vo.getPost_oname()) + "',";
			sql += "post_pname='" + _R(vo.getPost_pname()) + "' ";
		}
		else
		{
			sql += "post_mcate='" + vo.getPost_mcate() + "' ";
		}
		sql += "where post_no=" + vo.getPost_no();

		this.RunCommand(sql);
		this.DBClose();
		return true;
	}
	//�����ε�
	//�����Խ��� ������Ʈ �޼ҵ�
	public boolean Blind(PostVO vo)
	{
		this.DBOpen();
		
		String sql = "";
		sql  = "update post set ";
		if(vo.getPost_blind().equals("n"))
		{
			sql += "post_blind='y' ";
		}
		else
		{
			sql += "post_blind='n' ";
		}
		sql += "where post_no=" + vo.getPost_no();

		this.RunCommand(sql);
		this.DBClose();
		return true;
	}
	//�����Խ��� ������Ʈ �޼ҵ�
		public boolean NewsUpdate(PostVO vo)
		{
			this.DBOpen();
			
			String sql = "";
			sql  = "update post set ";
			sql += "post_title='" + _R(vo.getPost_title()) + "',";
			sql += "post_note='" + _R(vo.getPost_note()) + "',";
			sql += "post_source='" + _R(vo.getPost_source()) + "',";
			if(!vo.getPost_pname().equals("") || !vo.getPost_oname().equals("null"))
			{
				sql += "post_mcate='" + vo.getPost_mcate() + "',";
				sql += "post_oname='" + _R(vo.getPost_oname()) + "',";
				sql += "post_pname='" + _R(vo.getPost_pname()) + "' ";
			}
			else
			{
				sql += "post_mcate='" + vo.getPost_mcate() + "' ";
			}
			sql += "where post_no=" + vo.getPost_no();

			this.RunCommand(sql);
			this.DBClose();
			return true;
		}
	
	//����Խ��� ������Ʈ �޼ҵ�
	public boolean VideoUpdate(PostVO vo)
	{
		this.DBOpen();
		
		String sql = "";
		sql  = "update post set ";
		sql += "post_title='" + _R(vo.getPost_title()) + "',";
		sql += "post_note='" + _R(vo.getPost_note()) + "',";
		sql += "post_scate='" + vo.getPost_scate() + "',";
		sql += "post_source='" + vo.getPost_source() + "',";
		sql += "post_video='" + vo.getPost_video() + "',";
		if(!vo.getPost_pname().equals("") || !vo.getPost_oname().equals("null"))
		{
			sql += "post_mcate='" + vo.getPost_mcate() + "',";
			sql += "post_oname='" + _R(vo.getPost_oname()) + "',";
			sql += "post_pname='" + _R(vo.getPost_pname()) + "' ";
		}
		else
		{
			sql += "post_mcate='" + vo.getPost_mcate() + "' ";
		}
		sql += "where post_no=" + vo.getPost_no();

		this.RunCommand(sql);
		this.DBClose();
		return true;
	}
	
	//���� �޼ҵ�
	public boolean Delete(String no)
	{
		this.DBOpen();
		
		String sql = "";
		sql = "delete from like_hate where post_no = " + no;
		this.RunCommand(sql);
		sql = "delete from reply where post_no = " + no;
		this.RunCommand(sql);
		sql = "delete from post where post_no = " + no;
		this.RunCommand(sql);
		
		this.DBClose();
		
		return true;
	}
	
	//�Խù� ��ȸ �޼ҵ�
	//isview = true : ��ȸ������ , false : ��ȸ����������
	public PostVO Read(String no, boolean isview)
	{
		String sql = "";
		this.DBOpen();
		
		sql += "select ";
		sql += "user_no,post_title,post_type,post_note,post_mcate,post_scate,post_oname,post_pname,post_date,post_view,post_source,post_video,post_blind,";
		sql += "post_posneg,post_percent,post_figname,";
		sql += "(select user_name from userinfo where user_no = post.user_no) as user_name, ";
		sql += "(select user_nick from userinfo where user_no = post.user_no) as user_nick, ";
		sql += "(select count(*) from reply where post_no = post.post_no) as reply_count ";
		sql += "from post where post_no = " + no;
		this.RunQuery(sql);
		if(this.GetNext() == false)
		{
			this.DBClose();
			return null;
		}
		PostVO vo = new PostVO();
		vo.setPost_no(no);
		vo.setUser_no(this.GetValue("user_no"));
		vo.setPost_title(this.GetValue("post_title"));
		vo.setPost_type(this.GetValue("post_type"));
		vo.setPost_note(this.GetValue("post_note"));
		vo.setPost_mcate(this.GetValue("post_mcate"));
		vo.setPost_scate(this.GetValue("post_scate"));
		vo.setPost_source(this.GetValue("post_source"));
		vo.setPost_oname(this.GetValue("post_oname"));
		vo.setPost_pname(this.GetValue("post_pname"));
		vo.setPost_date(this.GetValue("post_date"));
		vo.setPost_view(this.GetValue("post_view"));
		vo.setPost_blind(this.GetValue("post_blind"));
		vo.setPost_video(this.GetValue("post_video"));
		vo.setUser_name(this.GetValue("user_name"));
		vo.setUser_nick(this.GetValue("user_nick"));
		vo.setReply_count(this.GetValue("reply_count"));
		vo.setPost_posneg(this.GetValue("post_posneg"));
		vo.setPost_percent(this.GetValue("post_percent"));
		vo.setPost_figname(this.GetValue("post_figname"));
		
		if(isview == true)//��ȸ�� ���� ó��
		{
			sql = "update post set post_view = post_view + 1 where post_no = " + no;
			this.RunCommand(sql);
		}
		
		this.DBClose();
		return vo;
	}
}