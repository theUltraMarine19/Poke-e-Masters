

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

/**
 * Servlet implementation class ForgotPassword
 */
@WebServlet("/ForgotPassword")
public class ForgotPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ForgotPassword() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher view = request.getRequestDispatcher("forgotPassword.jsp");
		view.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		if(request.getMethod().equals("POST")){
			String email = request.getParameter("user_mail");
			String password = Constants.getPassword(email);
			JSONObject json = new JSONObject();
			if(password.equals("NO")){
				try{
					json.put("success", false);
				}
				catch(Exception e){
					System.out.println("Error : "+e);
				}
			}
			else{
				try{
					json.put("success",true);
					Boolean result = Constants.sendEmail(email,"Password for PokEMasters login","Your password is "+password);
					if(result){
						json.put("status","A mail has been sent to your email containing your password");
					}
					else{
						json.put("status","Some problem occured, try again after some time");
					}
				}
				catch(Exception e){
					System.out.println("Error : "+e);
				}
			}
			PrintWriter out = response.getWriter();
			out.println(json.toString());
		}
	}

}
