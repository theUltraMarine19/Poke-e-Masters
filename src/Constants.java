import java.sql.*;

import org.json.JSONObject;

public class Constants {
	public static String Name = "jeyasoorya",Password = "",DB = "jdbc:postgresql://localhost:6010/postgres";
	private Constants(){
		
	}
	
	public static String addPlayer(String nick_name,String password,String email){
		try(Connection conn = DriverManager.getConnection(Constants.DB,Constants.Name,Constants.Password);
				PreparedStatement pstmt = conn.prepareStatement("INSERT INTO PLAYER(NAME,ID,PASSWORD,EMAIL,CURRCITYID) VALUES(?,nextval('UserID'),?,?,'1')");){
				pstmt.setString(1, nick_name);
				pstmt.setString(2, password);
				pstmt.setString(3, email);
				pstmt.executeUpdate();
				JSONObject json = new JSONObject();
				json.put("success", true);
				return json.toString();
			}
			catch(Exception sqle){
				System.out.println("Error : "+sqle);
				JSONObject json = new JSONObject();
				try{
					json.put("success", false);
					return json.toString();
				}
				catch(Exception e){
					System.out.println("Error : "+e);
				}
			}
		return null;  
	}
	
	public static String authenticate(String email,String password){
		try(Connection conn = DriverManager.getConnection(DB,Name,Password);
			PreparedStatement pstmt = conn.prepareStatement("select password,id from player where email=?")){
			pstmt.setString(1, email);
			ResultSet r = pstmt.executeQuery();
			Boolean flag_password=false,flag_email=false;
			String id = null;
			while(r.next()){
				flag_email = true;
				if(r.getString(1).equals(password)){
					flag_password = true;
					id = r.getString(2);
				}
			}
			JSONObject json = new JSONObject();
			if(flag_email){
				if(flag_password){
					try{
						json.put("success", true);
						json.put("status", "succesful");
						json.put("userid",id);
					}
					catch(Exception e){
						System.out.println("Error : "+e);
					}
					
				}
				else{
					try{
						json.put("success", false);
						json.put("status", "incorrect password");
					}
					catch(Exception e){
						System.out.println("Error : "+e);
					}
				}
			}
			else{
				try{
					json.put("success", false);
					json.put("status", "Email does not exist");
				}
				catch(Exception e){
					System.out.println("Error : "+e);
				}
			}
			return json.toString();
		}
		catch(Exception e){
			System.out.println("Error : "+e);
		}
		return null;
	}
}
