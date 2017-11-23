

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Battle
 */
@WebServlet("/Battle")
public class Battle extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Battle() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession s = request.getSession(false);
		if(s==null) {			
			response.sendRedirect("Login");
			return;
		}
		else {
			if(s.getAttribute("player_id")==null) {
				s.invalidate();		
				response.sendRedirect("Login");
				return;
			}			
		}
		String player_id = s.getAttribute("player_id").toString();
		if((request.getMethod()).equals("POST")){			
			String battleType = request.getParameter("type");				
			if(battleType.equals("wild")){
				String state = request.getParameter("state");
				if(state.equals("begin")){
					String wildPID = request.getParameter("WildPID");
					int level = Integer.parseInt(request.getParameter("Level"));
					String res = Constants.WildBattleBegin(wildPID, level);
					PrintWriter out = response.getWriter();
					out.println(res);
				}
				else if(state.equals("attack")){
					String res = Constants.wildAttack(player_id,request.getParameter("uid"),request.getParameter("a_id").substring(1),request.getParameter("wildID"));					
					PrintWriter out = response.getWriter();
					out.println(res);
				}
			}
		}
	}

}
