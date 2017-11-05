

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class EmailVerify
 */
@WebServlet("/EmailVerify")
public class EmailVerify extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EmailVerify() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String email = request.getParameter("email"),player_token = request.getParameter("token");
		if(email == null || player_token == null){
			PrintWriter out = response.getWriter();
			out.println("<script>alert(\"This is not a valid url\")</script>");
			return;
		}
		int i = Constants.verifyEmail(email,player_token);
		String resp = "";
		if(i==1){
			resp = "Your email has been verified, you can now login into PokEMasters";
		}
		else if(i==2){
			resp = "Sorry your verify url is not correct";
		}
		else if(i==3){
			resp = "You have to first sign up";
		}
		else if(i==0){
			resp = "Something went wrong";
		}
		PrintWriter out = response.getWriter();
		out.println("<script>alert(\""+resp+"\")</script>");
		return;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
