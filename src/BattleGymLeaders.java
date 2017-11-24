

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;

/**
 * Servlet implementation class BattleGymLeaders
 */
@WebServlet("/BattleGymLeaders")
public class BattleGymLeaders extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BattleGymLeaders() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
		String player_name = Constants.getPlayerName(player_id);
		request.setAttribute("name",player_name);
		int num = Constants.NumGymLeaders();
		request.setAttribute("num",Integer.toString(num));
		RequestDispatcher view = request.getRequestDispatcher("battleGymLeaders.jsp");
		view.forward(request, response);
		
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
		
		String func = request.getParameter("function");
		if (func.equals("Get gym info"))
		{
			String ret = Constants.getGymInfo();
			PrintWriter out = response.getWriter();
			out.println(ret);
		}
	}

}
