//좋아요 싫어요 클래스

package kickoff.vo;

public class Like_HateVO 
{
	private String post_no;     //게시물번호
	private String user_no;     //회원번호
	private String reply_no;    //댓글번호
	private String like_hate;   //좋아요,싫어요 구분
	private String like_count;  //좋아요 갯수
	private String hate_count;  //좋아요 갯수
	//좋아요,싫어요 생성자
	public Like_HateVO()
	{
		post_no    = "";
		user_no    = "";
		reply_no   = "";
		like_hate  = "";
		like_count = "";
		hate_count = "";
	}

	public String getPost_no()    { return post_no;   }
	public String getUser_no()    { return user_no;   }
	public String getReply_no()   { return reply_no;  }
	public String getLike_hate()  { return like_hate; }
	public String getLike_count() { return like_count; }
	public String getHate_count() { return hate_count; }

	public void setPost_no(String post_no)       { this.post_no    = post_no;    }
	public void setUser_no(String user_no)       { this.user_no    = user_no;    }
	public void setReply_no(String reply_no)     { this.reply_no   = reply_no;   }
	public void setLike_hate(String like_hate)   { this.like_hate  = like_hate;  }
	public void setLike_count(String like_count) { this.like_count = like_count; }
	public void setHate_count(String hate_count) { this.hate_count = hate_count; }
		
}
