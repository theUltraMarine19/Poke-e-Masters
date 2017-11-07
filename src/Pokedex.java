

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;

/**
 * Servlet implementation class Pokedex
 */
@WebServlet("/Pokedex")
public class Pokedex extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Pokedex() {
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
			JSONArray poke_dex_info = Constants.getPokedexInfo();
			request.setAttribute("name",player_name);
			request.setAttribute("pokemons",poke_dex_info);
			RequestDispatcher view = request.getRequestDispatcher("pokedex.jsp");
			view.forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
