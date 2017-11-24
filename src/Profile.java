

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.*;

/**
 * Servlet implementation class Profile
 */
@WebServlet("/Profile")
public class Profile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Profile() {
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
			JSONObject json = Constants.getPlayerProfileInfo(player_id);
			request.setAttribute("player",json);
			RequestDispatcher view = request.getRequestDispatcher("profile.jsp");
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
		if(!Constants.get_setAvatarChosen(player_id,true,0)){
			RequestDispatcher view = request.getRequestDispatcher("selectAvatar.jsp");
			view.forward(request, response);
		}	
		else if(!Constants.get_setStarterPokemon(player_id, true,0)){
			request.setAttribute("pids", Constants.s_id);
			RequestDispatcher view = request.getRequestDispatcher("starterPokemon.jsp");
			view.forward(request, response);
			
			
		}
		else if(request.getMethod().equals("POST")){
			String function = request.getParameter("function");
			if(function == null){
				return;
			}
			if(function.equals("Get team info")){
				String arr = Constants.getPlayerPokemonTeamInfo(player_id);
				PrintWriter out = response.getWriter();
				out.println(arr);
			}
			else if(function.equals("Get pokemon stats")){
				String pokestats = Constants.getPlayerPokemonStats(request.getParameter("uid"), player_id);
				PrintWriter out = response.getWriter();
				out.println(pokestats);
			}
			else if(function.equals("Add to my team")){
				String newTeam = Constants.addRemoveFromTeam(request.getParameter("uid"), player_id,true);
				PrintWriter out = response.getWriter();
				out.println(newTeam);
			}
			else if(function.equals("Remove from my team")){
				String newTeam = Constants.addRemoveFromTeam(request.getParameter("uid"), player_id, false);
				PrintWriter out = response.getWriter();
				out.println(newTeam);
			}
			else if(function.equals("rm known move")){
				String A_ID = (request.getParameter("A_ID")).split(" ")[0].substring(1);
				String ac_moves = Constants.addrmKnownMove(player_id, request.getParameter("uid"), A_ID, false);
				PrintWriter out = response.getWriter();
				out.println(ac_moves);
			}
			else if(function.equals("add known move")){
				String A_ID = (request.getParameter("A_ID")).split(" ")[0].substring(1);
				String ac_moves = Constants.addrmKnownMove(player_id, request.getParameter("uid"), A_ID, true);
				PrintWriter out = response.getWriter();
				out.println(ac_moves);
			}
			else if(function.equals("Get pokemon moves")){
				String uid = (request.getParameter("uid")).split(" ")[2];
				String res = Constants.getPlayerPokemonMoves(player_id,uid);
				PrintWriter out = response.getWriter();
				out.println(res);
			}
			else if(function.equals("Evolve pokemon")){				
				String uid = (request.getParameter("uid")).split(" ")[2];
				System.out.println(uid);
				String res = Constants.EvolvePokemon(player_id, uid);
				PrintWriter out = response.getWriter();
				out.println(res);
			}
			else if(function.equals("Heal team")){
				String res = Constants.healPlayerTeam(player_id);
				PrintWriter out = response.getWriter();
				out.println(res);
			}
		}
	}

}
