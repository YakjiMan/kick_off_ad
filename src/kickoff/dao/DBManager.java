package kickoff.dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBManager
{
	private String host;   //DB연결정보
	private String userid; //DB사용자
	private String userpw; //DB비밀번호
	
	private Connection conn = null;
	private ResultSet  rs   = null;
	
	//생성자 선언
	public DBManager()
	{
		this.userid = "kickoff";
		this.userpw = "kickoff";
		this.host   = "jdbc:mysql://192.168.0.21:3306/kickoff";
		     host  += "?useUnicode=true&characterEncoding=utf-8";
		     host  += "&serverTimezone=UTC"; 
	}
	
	//id,pw setter 선언
	public void setUserid(String userid) { this.userid = userid; }
	public void setUserpw(String userpw) { this.userpw = userpw; }

	//DB Open하기
	//리턴값 : true - 성공 , false - 실패
	public boolean DBOpen()
	{
		try
		{
			//1. jdbc라이브러리 로딩
			Class.forName("com.mysql.cj.jdbc.Driver");
		
	    	//2. 데이터베이스에 연결한다.
		    conn = DriverManager.getConnection(this.host, this.userid, this.userpw);
	    }
	    catch(Exception e)
	    {
	 	    e.printStackTrace();
		    return false;
	    }
		return true;
	}
	
	//DB Close하기
	public void DBClose()
	{
		 //4. 연결을 닫는다
	    try 
	    {
			conn.close();
		} 
	    catch (SQLException e) 
	    {
			e.printStackTrace();
		}
	}
	
	//Insert, Update, Delete 실행 
	public boolean RunCommand(String sql)
	{
		try 
		{
			Statement stmt = conn.createStatement();
			stmt.executeUpdate(sql);
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	//Select 실행
	public boolean RunQuery(String sql)
	{
		try 
		{
			Statement stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	//ResultSet의 next() 실행
	public boolean GetNext()
	{
		try
		{
			return rs.next();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
			return false;
		}
	}
	
	//ResultSet의 getString() 실행
	public String GetValue(String colName)
	{
		try
		{
			return rs.getString(colName);
		}
		catch(SQLException e)
		{
			e.printStackTrace();
			return null;
		}
	}
	
	//ResultSet의 getInt() 실행
	public int GetInt(String colName)
	{
		try
		{
			return rs.getInt(colName);
		}
		catch(SQLException e)
		{
			e.printStackTrace();
			return 0;
		}
	}
	
	public String _R(String value)
	{
		return value.replace("'","''");
	}
}
