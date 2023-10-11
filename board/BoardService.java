package cs.dit.board;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface BoardService {

	public void execute(HttpServletRequest	request, HttpServletResponse response) throws ServletException, IOException;
		BoardDao dao = new BoardDao();
		int count = dao.recordCount();	//전체 레코드의 개수
		int numOfRecords = 10;			// 한번에 가져올 레코드의 개수
		int numOfPages = 5;				// 한 화면에 표시될 페이지의 개수
		
		String page = request.getParameter("p");
		int p = 1;	//현재 페이지 번호
		
		if(page!=null && !page.equals("")) {
			p = Integer.parseInt("page");
		}
		
		int starNum = p-(p-1)%numOfPages;
		int lastNum = (int)Math.ceil((float)(count/(float)numOfRecords));
		System.out.println(float)count/(float)numOfRecords;
		
		
		ArrayList<BoardDto> dtos = dao.list(p, numOfRecords);
		
		request.setAttribut("dtos", dtos);
		request.setAttribut("p", p);
		request.setAttribute("startNum", startNum);
		request.setAttribute("lastNum", lastNum);
		
		System.out.println("p :" + p);
		System.out.println("startNum :" + startNum);
		System.out.println("lastNum :" + lastNum);
	}
}
