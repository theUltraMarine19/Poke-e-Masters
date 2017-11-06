import java.sql.*;
import java.util.Properties;
import java.util.concurrent.ThreadLocalRandom;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.json.JSONObject;

public class Constants {
	public static String Name = "jeyasoorya",Password = "",DB = "jdbc:postgresql://localhost:6010/postgres";
	private static String from = "150050101@iitb.ac.in",pass_word = "soorya#0412";
	// public static String Name = "arijit",Password = "",DB = "jdbc:postgresql://localhost:5940/postgres";

	private Constants(){
		
	}
	
	public static String generateRandomToken(){
		String available_char = "abcdefghizklmnopqrstuvwxyz0123456789";
		String s = "";
		for(int i=0;i<6;i++){
			int rand = ThreadLocalRandom.current().nextInt(0, 36);
			s = s + available_char.substring(rand, rand+1);
		}
		return s;
	}
	
	public static Boolean sendEmail(String to,String subject,String body){
		Boolean res = false;
		Properties properties = new Properties();
		properties.put("mail.smtp.auth","true");
		properties.put("mail.smtp.starttls.enable", "true"); 
		properties.put("mail.smtp.host","smtp-auth.iitb.ac.in");
		properties.put("mail.smtp.port", "25");
        Session session = Session.getInstance(properties,new javax.mail.Authenticator(){
        	protected PasswordAuthentication getPasswordAuthentication(){
        		return new PasswordAuthentication(from,pass_word);
        	}
        });
        
		try{
			MimeMessage m = new MimeMessage(session);
			m.setFrom(new InternetAddress("noreplay@pokEMasters.com"));
			m.addRecipient(Message.RecipientType.TO,new InternetAddress(to));
			m.setSubject(subject);
			m.setText(body);
			Transport.send(m);
			res = true;
		}
		catch(Exception e){
			System.out.println("Error : "+e);
		}
		return res;
	}
	
	public static int verifyEmail(String email,String player_token){
		try(Connection conn = DriverManager.getConnection(Constants.DB,Constants.Name,Constants.Password);
			PreparedStatement pstmt = conn.prepareStatement("select email_verified from player where email=?");){
			pstmt.setString(1, email);
			ResultSet r = pstmt.executeQuery();
			Boolean flag_email=false,flag_token=false;
			while(r.next()){
				flag_email=true;
				if(r.getString(1).equals(player_token)){
					flag_token=true;
					PreparedStatement pstmt1 = conn.prepareStatement("update player set email_verified='VERIFIED' where email=?");
					pstmt1.setString(1, email);
					pstmt1.executeUpdate();
				}
			}
			if(flag_email&&flag_token){
				return 1;
			}
			else if(flag_email){
				return 2;
			}else{
				return 3; 
			}
		}
		catch(Exception e){
			System.out.println("Error : "+e);
		}
		return 0;
	}
	
	public static String addPlayer(String name,String nick_name,String password,String email){
		try(Connection conn = DriverManager.getConnection(Constants.DB,Constants.Name,Constants.Password);
				PreparedStatement pstmt = conn.prepareStatement("INSERT INTO PLAYER(NAME,NICKNAME,ID,PASSWORD,EMAIL,CURRCITYID,email_verified) VALUES(?,?,nextval('UserID'),?,?,'1',?)");){
				pstmt.setString(1,name);
				pstmt.setString(2, nick_name);
				pstmt.setString(3, password);
				pstmt.setString(4, email);
				String player_token = Constants.generateRandomToken();
				pstmt.setString(5, player_token);
				String verify_url = "http://localhost:8080/PokeEMasters/EmailVerify?email="+email+"&token="+player_token;
				pstmt.executeUpdate();
				JSONObject json = new JSONObject();
				json.put("success", true);
				json.put("verify_url", verify_url);
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
			PreparedStatement pstmt = conn.prepareStatement("select password,id,email_verified from player where email=?");){
			pstmt.setString(1, email);
			ResultSet r = pstmt.executeQuery();
			Boolean flag_password=false,flag_email=false,flag_token=false;
			String id = null;
			while(r.next()){
				flag_email = true;
				if(r.getString(1).equals(password)){
					flag_password = true;
					id = r.getString(2);
					if(r.getString(3).equals("VERIFIED")){
						flag_token = true;
					}
				}
			}
			JSONObject json = new JSONObject();
			if(flag_email){
				if(flag_password){
					if(flag_token){
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
							json.put("status", "Your email has not been verified yet");
						}
						catch(Exception e){
							System.out.println("Error : "+e);
						}
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
	
	public static String getPlayerName(String player_id){
		try(Connection conn = DriverManager.getConnection(DB,Name,Password);
			PreparedStatement pstmt = conn.prepareStatement("select name from player where id=?");){
			pstmt.setString(1, player_id);
			ResultSet r = pstmt.executeQuery();
			String name=null;
			while(r.next()){
				name = r.getString(1);
			}
			return name;
		}
		catch(Exception sqle){
			System.out.println("Error : "+sqle);
		}
		return null;
	}
	
	public static String getPassword(String email){
		try(Connection conn = DriverManager.getConnection(DB,Name,Password);
				PreparedStatement pstmt = conn.prepareStatement("select password from player where email=?");){
				pstmt.setString(1, email);
				ResultSet r = pstmt.executeQuery();
				String password=null;
				Boolean flag_email = false;
				while(r.next()){
					flag_email = true;
					password = r.getString(1);
				}
				if(flag_email){
					return password;
				}
				return "NO";
			}
			catch(Exception sqle){
				System.out.println("Error : "+sqle);
			}
			return null;
	}
	
	public static Boolean get_setAvatarChosen(String id,Boolean flag_get,int src){
		if(flag_get){
			try(Connection conn = DriverManager.getConnection(DB,Name,Password);
				PreparedStatement pstmt = conn.prepareStatement("select avatar_chosen from player where id=?");){
					pstmt.setString(1,id);
					ResultSet r = pstmt.executeQuery();
					while(r.next()){
						if(r.getInt(1)==0){
							return false;
						}
					}
					return true;
			}
			catch(Exception e){
				System.out.println("Error : "+e);
			}
		}
		else{
			try(Connection conn = DriverManager.getConnection(DB,Name,Password);
					PreparedStatement pstmt = conn.prepareStatement("update player set avatar_chosen=? where id=?");){
						pstmt.setInt(1,src);
						pstmt.setString(2,id);
						pstmt.executeUpdate();
						return true;
				}
				catch(Exception e){
					System.out.println("Error : "+e);
				}			
		}
		return false;
	}
}
