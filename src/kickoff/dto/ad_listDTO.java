//게시물의 목록을 조회하는 클래스
package kickoff.dto;

import kickoff.dao.*;
import kickoff.vo.*;
import java.util.*;

public class ad_listDTO extends DBManager
{
	//전체 게시물의 갯수를 얻는다.
	public int GetTotal()
	{
		this.DBOpen();
		
		String sql = "";
		
		sql  = "select count(*) as total  ";
		sql += "from ad_info ";

		this.RunQuery(sql);
		this.GetNext();				
		int total = Integer.parseInt(this.GetValue("total")); //전체 데이터 갯수
		
		this.DBClose();
		return total;
	}
	
	//게시물의 목록을 얻는다.
	public ArrayList<ad_managerVO> GetList()
	{
		ArrayList<ad_managerVO> list = new ArrayList<ad_managerVO>();
		
		this.DBOpen();
		
		String sql = "";
		
		sql  = "select ad_no,ad_name,ad_keyword,ad_exposure,ad_click,w_image_phyname,w_image_fname,h_image_phyname,h_image_fname ";
		sql += "from ad_info ";
		sql += "order by ad_no desc ";	
		this.RunQuery(sql);
		while( this.GetNext() == true)
		{
			ad_managerVO vo = new ad_managerVO();
			vo.setAd_no(this.GetValue("ad_no"));
			vo.setAd_name(this.GetValue("ad_name"));
			vo.setAd_keyword(this.GetValue("ad_keyword"));
			vo.setAd_exposure(this.GetValue("ad_exposure"));
			vo.setAd_click(this.GetValue("ad_click"));
			vo.setW_image_phyname(this.GetValue("w_image_phyname"));
			vo.setW_image_fname(this.GetValue("w_image_fname"));
			vo.setH_image_phyname(this.GetValue("h_image_phyname"));
			vo.setH_image_fname(this.GetValue("h_image_fname"));
			
			list.add(vo);
		}		
		this.DBClose();
		
		return list;
	}
}
