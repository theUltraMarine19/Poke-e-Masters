

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import org.json.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AddUser
 */
@WebServlet("/AddUser")
public class AddUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddUser() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher view = request.getRequestDispatcher("signup.jsp");
		view.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		doGet(request, response);
		if(request.getMethod().equals("POST")){
			String first_name = request.getParameter("first_name");
			String last_name = request.getParameter("last_name");
			String password = request.getParameter("password");
			String email = request.getParameter("user_mail");
			String nick_name = request.getParameter("nick_name");
			String res = Constants.addPlayer(first_name+" "+last_name,nick_name, password, email);
			if(res == null){
				JSONObject json = new JSONObject();
				try{
					json.put("success", false);
				}
				catch(Exception e){
					System.out.println("Error : "+e);
				}
				PrintWriter out = response.getWriter();
				out.println(json.toString());
			}
			else{
				PrintWriter out=response.getWriter();
				out.println(res);
			}
		}
	}

}
