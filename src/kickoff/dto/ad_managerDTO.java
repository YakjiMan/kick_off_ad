//광고 관리 클래스
package kickoff.dto;

import kickoff.dao.*;
import kickoff.vo.*;

public class ad_managerDTO extends DBManager
{
	//광고게시물을 등록한다.
	public boolean Insert(ad_managerVO vo)
	{
		this.DBOpen();
		
		String sql = "";

		sql  = "insert into ad_info (ad_name,ad_keyword,w_image_phyname,w_image_fname,h_image_phyname,h_image_fname) ";
		sql += "values ('" + vo.getAd_name() + "','" + vo.getAd_keyword() + "','" + vo.getW_image_phyname() + "','" + vo.getW_image_fname() + "','" + vo.getH_image_phyname() + "','" + vo.getH_image_fname() + "') ";
		
		this.RunCommand(sql);

		//등록된 게시물 번호를 얻는다.
		sql = "select last_insert_id() as ad_no ";
		this.RunQuery(sql);
		this.GetNext();
		vo.setAd_no(this.GetValue("ad_no"));
		
		this.DBClose();
		return true;
	}
	
	//광고게시물 정보를 변경한다.
	public boolean Update(ad_managerVO vo)
	{
		this.DBOpen();
		
		String sql = "";
		sql  = "update ad_info set ";
		sql += "ad_name='" + vo.getAd_name() + "',";
		sql += "ad_keyword='" + vo.getAd_keyword() + "',";
		sql += "w_image_phyname='" + vo.getW_image_phyname() + "',";
		sql += "w_image_fname='" + vo.getW_image_fname() + "',";
		sql += "h_image_phyname='" + vo.getH_image_phyname() + "',";
		sql += "h_image_fname='" + vo.getH_image_fname() + "' ";
		sql += "where ad_no = " + vo.getAd_no();
		this.RunCommand(sql);
		
		this.DBClose();
		return true;
	}
	
	//게시물 정보를 삭제한다.
	public boolean Delete(String ad_no)
	{
		this.DBOpen();
		
		String sql = "";

		sql = "delete from ad_info where ad_no = " + ad_no;
		this.RunCommand(sql);
		
		this.DBClose();
		
		return true;
	}
	
	//게시물 1개의 정보를 조회한다.
	//no : 게시물 번호
	//ishit : true - 조회수 증가, false - 게시물 정보만 조회
	public ad_managerVO Read(String ad_no, boolean isview)
	{
		String sql = "";
		
		this.DBOpen();

		sql  = "select ad_name,ad_keyword,ad_exposure,ad_click,w_image_phyname,w_image_fname,h_image_phyname,h_image_fname ";
		sql += "from ad_info where ad_no = " + ad_no;
		this.RunQuery(sql);
		if( this.GetNext() == false)
		{
			//해당 게시물 없음.
			this.DBClose();
			return null;
		}
		ad_managerVO vo = new ad_managerVO();
		vo.setAd_no(ad_no);
		vo.setAd_name(this.GetValue("ad_name"));
		vo.setAd_keyword(this.GetValue("ad_keyword"));
		vo.setAd_exposure(this.GetValue("ad_exposure"));
		vo.setAd_click(this.GetValue("ad_click"));
		vo.setW_image_phyname(this.GetValue("w_image_phyname"));
		vo.setW_image_fname(this.GetValue("w_image_fname"));
		vo.setH_image_phyname(this.GetValue("h_image_phyname"));
		vo.setH_image_fname(this.GetValue("h_image_fname"));
		
		//광고 클릭수 조회 메소드
		if(isview == true)
		{
			sql = "update ad_info set ad_click = ad_click + 1 where ad_no = " + ad_no;
			this.RunCommand(sql);
		}
		
		this.DBClose();
		return vo;
	}
	
	
}
