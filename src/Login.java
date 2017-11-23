

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
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
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
			RequestDispatcher view = request.getRequestDispatcher("Login.jsp");
			view.forward(request, response);		
			return;
		}
		else {
			System.out.println(s.getAttribute("player_id"));
			
			if(s.getAttribute("player_id")==null) {
				s.invalidate();
				RequestDispatcher view = request.getRequestDispatcher("Login.jsp");
				view.forward(request, response);		
				return;
			}
			else if (s.getAttribute("player_id").equals("admin"))
			{
				System.out.println("Admin Redirect");
				response.sendRedirect("Admin");
			}
			else
				response.sendRedirect("Profile");
			return;
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getMethod().equals("POST")){
			String email = request.getParameter("user_mail");
			String password = request.getParameter("password");
			String res = Constants.authenticate(email, password);
			if(res == null){
				JSONObject json = new JSONObject();
				try{
					json.put("success", false);
					json.put("status","Exception occured");
				}
				catch(Exception e){
					System.out.println("Error : "+e);
				}
				PrintWriter out = response.getWriter();
				out.println(json.toString());
			}
			else{
				try{
					JSONObject json = new JSONObject(res);
					if(json.getBoolean("success") && json.getBoolean("admin")){
						HttpSession session = request.getSession(true);
						session.setAttribute("player_id", "admin");
						System.out.println("Admin : ");
					}
					if(json.getBoolean("success")){
						HttpSession session = request.getSession(true);
						session.setAttribute("player_id", json.getString("userid"));
					}
					PrintWriter out = response.getWriter();
					out.println(res);
				}
				catch(Exception e){
					System.out.println("Error : "+e);
				}
			}
		}
	}

}
