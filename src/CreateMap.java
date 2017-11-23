

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.imageio.ImageIO;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import sun.misc.BASE64Decoder;

/**
 * Servlet implementation class CreateMap
 */
@WebServlet("/CreateMap")
public class CreateMap extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateMap() {
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
			else {
				String id = (String) s.getAttribute("player_id");
				if (id.equals("admin")) {
					RequestDispatcher view = request.getRequestDispatcher("createMap.jsp");
					view.forward(request, response);
				}
				else {
					s.invalidate();		
					response.sendRedirect("Login");
					return;
				}
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String img = request.getParameter("imgBase64");
		String point = request.getParameter("points");
		String[] points = point.split(",");
		
		PrintWriter out = new PrintWriter(getServletContext().getRealPath("/Maps/map.txt"));
		for (int i=0;i<points.length-1;i+=2) {
			if (i!=points.length-2)
			{
				out.println("\'"+points[i]+","+points[i+1]+"\',");
			}
			else
			{
				out.println("\'"+points[i]+","+points[i+1]+"\'");
			}
		}
		out.close();
		System.out.println(point);
		System.out.println(getServletContext().getRealPath("/Maps/map.txt"));
		
		String[] imgs = img.split(",");
		BufferedImage image = null;
		byte[] imageByte;

		BASE64Decoder decoder = new BASE64Decoder();
		imageByte = decoder.decodeBuffer(imgs[1]);
		ByteArrayInputStream bis = new ByteArrayInputStream(imageByte);
		image = ImageIO.read(bis);
		bis.close();

		// write the image to a file
		File outputfile = new File(getServletContext().getRealPath("/Maps/map.png"));
		ImageIO.write(image, "png", outputfile);
		System.out.println("done");

	}

}
