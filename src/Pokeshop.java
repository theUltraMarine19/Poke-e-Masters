

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Pokeshop
 */
@WebServlet("/Pokeshop")
public class Pokeshop extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Pokeshop() {
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
			String json = Constants.getPlayerName(player_id);
			request.setAttribute("name",json);
			RequestDispatcher view = request.getRequestDispatcher("pokeshop.jsp");
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
			int pb = Integer.parseInt(request.getParameter("1")),mb=Integer.parseInt(request.getParameter("2"));
			int sp = Integer.parseInt(request.getParameter("3")),mp = Integer.parseInt(request.getParameter("4"));
			int lp = Integer.parseInt(request.getParameter("5"));
			String res = Constants.AddItems(player_id, pb, mb, sp, mp, lp);
			PrintWriter out = response.getWriter();
			out.println(res);
		}
	}

}
