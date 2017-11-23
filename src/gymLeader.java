

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

/**
 * Servlet implementation class gymLeader
 */
@WebServlet("/gymLeader")
public class gymLeader extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public gymLeader() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		JSONArray poke_dex_info = Constants.getPokedexInfo();
		request.setAttribute("pokemons",poke_dex_info);
		RequestDispatcher view = request.getRequestDispatcher("gymLeader.jsp");
		System.out.println("Forwarding to gymLeader.jsp page");
		view.forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		if(request.getMethod().equals("POST")){
//			String function = request.getParameter("function");
//			if(function == null){
//				System.out.println("Shit");
//				return;
//			}
			String name = request.getParameter("first_name");
			String city = request.getParameter("city_name");
			int avatar = Integer.parseInt(request.getParameter("avatar"));
			int badge = Integer.parseInt(request.getParameter("badge"));
			System.out.println(name);
			System.out.println(city);
			System.out.println(avatar);
			System.out.println(badge);
			
			String result = Constants.addAPPlayer(name, city, avatar, badge);
			System.out.println(result);
			if (result!=null)
			{
				JSONObject json;
				int[] poke = new int[6];
				int[] levels = new int[6];
				try
				{
					json = new JSONObject(result);
					if(json.getBoolean("success"))
					{
						int j;
						for (j = 0; j < 6;j++)
						{
							String temp = request.getParameter("poke"+Integer.toString(j+1));
							if (!temp.equals("NotSet"))
							{
								poke[j] = Integer.parseInt(temp);
								String tmp = request.getParameter("levelp"+Integer.toString(j+1));
								levels[j] = Integer.parseInt(tmp);
							}
							else
								poke[j] = 0;
						}
						String ret = Constants.addAPPlayerPokemon(json.getInt("apid"), poke, levels);
						System.out.println(json.getInt("apid"));
						System.out.println(ret);
						try
						{
							json = new JSONObject(result);
							if(json.getBoolean("success"))
							{
								PrintWriter out = response.getWriter();
								out.println(json.toString());
							}
						}
						catch (Exception ex)
						{
							
						}
						
						
						
					}
				} catch (Exception ex)
				{
					System.out.println("Error" + ex);
				}
				
					
			}
			
			
		}
	}

}
