package kickoff.dao;

import java.util.Map;
import java.io.*;

public class pythonbrowse {
	public String test(String key){
		String outBuffer = "";
		//중요!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		//파이썬 가상 환경 경로 설정
			String RunPath = "C:\\ProgramData\\anaconda3\\";
		//파이썬 실행파일 설정
			String command = RunPath + "pythonw.exe";
		//파이썬 코드 파일 설정
			String pyname  = "D:\\SHS\\second project\\kick_off_view\\WebContent\\python\\graph\\project04.py";
		// ==========================================================================================================
		// 런타임 라이브러리를 이용
//			String RunPath = "C:\\Users\\MYCOM\\.conda\\envs\\myEnv\\";
//			String pyname  = "X:\\TEST\\JSP_PY_JDK8\\WebContent\\py\\plot.py";

		// ==========================================================================================================
		try
		{
	        ProcessBuilder builder = new ProcessBuilder();
	        builder.command(command, pyname,"--key",key);
			Map<String, String> envs = builder.environment();
		    envs.put("Path", RunPath + "Scripts");
		    envs.put("Path", RunPath + "Library\\bin");
		    int exitVal = 0;
//		    try {
		    	Process process = builder.start();
//		    	exitVal = process.waitFor();  // 자식 프로세스가 종료될 때까지 기다림
//		    	BufferedReader br = new BufferedReader(new InputStreamReader(process.getInputStream(), "euc-kr"));
//		    	String line;			
//		    	// 서브 프로세스가 출력하는 내용을 받기 위해
//		    	while ((line = br.readLine()) != null) 
//		    	{
//		    		System.out.println(line); // 표준출력에 쓴다
//		    		outBuffer += line;
//		    	}
//		    }catch(Exception e)
//		    {
//		    	System.out.println(e);
//		    }
//			if(exitVal != 0) 
//			{
//				// 비정상 종료
//				System.out.println("서브 프로세스가 비정상 종료되었다.");
//			}
//			System.out.print(outBuffer);
		    System.out.println("OK");
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return outBuffer;
	}
}
