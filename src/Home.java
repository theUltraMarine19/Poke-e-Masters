

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.net.*;
import java.nio.charset.Charset;

/**
 * Servlet implementation class Home
 */
@WebServlet("/Home")
public class Home extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Home() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    public static String getResults(String url)
    {
    	BufferedReader br = null;
    	StringBuilder sb;	
    	
    	try {
    		URL newurl = new URL(url);
    		HttpURLConnection conn = (HttpURLConnection) newurl.openConnection();
    		conn.setRequestProperty("User-Agent","Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/538.15 (KHTML, like Gecko) Version/8.0 Safari/538.15");
    		conn.setRequestMethod("POST");
    		conn.setDoOutput(true);
    	    conn.setDoInput(true);
//    		conn.setReadTimeout(15*100); //15 secs timeout
    		conn.connect();
    	    System.out.println(conn.getResponseCode());
    		System.out.println(conn.getInputStream());
    		br = new BufferedReader(new InputStreamReader(conn.getInputStream(),Charset.defaultCharset()));
    	    sb = new StringBuilder();
    	    String line = null;
//    	    System.out.println("Inside");
    	    while ((line = br.readLine()) != null)
    	      {
    	        sb.append(line + "\n");
    	        System.out.println("In loop");
    	        break;
    	      }
    	    br.close();
    	    System.out.println(sb.toString());
    	    return sb.toString();
    	}
    	catch (Exception e){
    		System.out.println("Error in conn to PokeAPI : " + e);
    		return null;
    	}
    	finally
        {
          if (br != null)
          {
            try
            {
              br.close();
            }
            catch (IOException ioe)
            {
              ioe.printStackTrace();
            }
          }
        }
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
		request.setAttribute("name", player_name);
//		RequestDispatcher view = request.getRequestDispatcher("home.jsp");
//		view.forward(request, response);
		
		System.out.println("Fetching........");
		
		String poke_id = "1";
		String url = "http://pokeapi.co/api/v2/" + "pokemon/" + poke_id;
		System.out.println(url);
//		String encoded_url = URLEncoder.encode(url,"UTF-8");
		String res = getResults(url);
		System.out.println(res);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
