

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

/**
 * Servlet implementation class Admin
 */
@WebServlet("/Admin")
public class Admin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Admin() {
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
		System.out.println(player_id);
		RequestDispatcher view = request.getRequestDispatcher("admin.jsp");
		System.out.println("Forwarding to admin.jsp page");
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
		if(request.getMethod().equals("POST")){
			String function = request.getParameter("function");
			if(function != null){
				Boolean result=false;
				String choice = request.getParameter("choice");
				if (choice.equals("gymLeader"))
				{
					
					return;
				}
//				if(function.equals("avatar")){
//					result = Constants.get_setAvatarChosen(player_id, false, src);
//				}
//				else if(function.equals("starter_pokemon")){
//					result = Constants.get_setStarterPokemon(player_id, false, src);
//				}
//				JSONObject json = new JSONObject();
//				try{
//					if(result){
//						json.put("success", true);
//					}
//					else{
//						json.put("success", false);
//					}
//				}
//				catch(Exception e){
//					System.out.println("Error : "+e);
//				}
//				PrintWriter out = response.getWriter();
//				out.println(json.toString());
			}
		}
	}

}
