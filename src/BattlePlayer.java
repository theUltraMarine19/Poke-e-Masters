

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
import org.json.JSONObject;

/**
 * Servlet implementation class BattlePlayer
 */
@WebServlet("/BattlePlayer")
public class BattlePlayer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BattlePlayer() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
		if(!Constants.get_setAvatarChosen(player_id,true,0)){
			RequestDispatcher view = request.getRequestDispatcher("selectAvatar.jsp");
			view.forward(request, response);
		}		
		else if(!Constants.get_setStarterPokemon(player_id, true,0)){
			request.setAttribute("pids", Constants.s_id);
			RequestDispatcher view = request.getRequestDispatcher("starterPokemon.jsp");
			view.forward(request, response);
		}
		else {
			String player_name = Constants.getPlayerName(player_id);
			request.setAttribute("name", player_name);
			request.setAttribute("players",Constants.getAllPlayersInfo(player_id));
			RequestDispatcher view = request.getRequestDispatcher("battlePlayers.jsp");
			view.forward(request, response);	
		}
		
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
			String requestType = request.getParameter("type");				
			if(requestType.equals("challenge")){
				String res = Constants.SendMessage(player_id,request.getParameter("challegee_id"),"Battle Challenge","I challenge you to batlle!");
				PrintWriter out = response.getWriter();
				out.println(res);
			}
			else if(requestType.equals("viewSmall")) {
				String res = Constants.ViewChallenge(player_id,false);
				PrintWriter out = response.getWriter();
				out.println(res);
			}
			else if(requestType.equals("viewLarge")) {
				String res = Constants.ViewChallenge(player_id,true);
				PrintWriter out = response.getWriter();
				out.println(res);
			}
		}
	}

}
