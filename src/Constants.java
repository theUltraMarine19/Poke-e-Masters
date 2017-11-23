import java.sql.*;
import java.util.Properties;
import java.util.concurrent.ThreadLocalRandom;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.json.JSONArray;
import org.json.JSONObject;

public class Constants {
//	public static String Name = "hp",Password = "",DB = "jdbc:postgresql://localhost:6020/postgres";
	public static String Name = "jeyasoorya",Password = "",DB = "jdbc:postgresql://localhost:6010/postgres";
//	 public static String Name = "arijit",Password = "",DB = "jdbc:postgresql://localhost:5940/postgres";
	private static String from = "150050101@iitb.ac.in",pass_word = "soorya#0412";

	public static int[] s_id = {1,4,7,152,155,158,252,255,258,387,390,393,495,498,501,650,653,656};
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
			m.setFrom(new InternetAddress("noreply@pokEMasters.com"));
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
			Boolean flag_password=false,flag_email=false,flag_token=false, flag_admin = false;
			String id = null;
			while(r.next()){
				flag_email = true;
				if(r.getString(1).equals(password)){
					flag_password = true;
					id = r.getString(2);
					if (id.equals("admin"))
						flag_admin = true;
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
							if (flag_admin)
								json.put("admin", true);
							else
								json.put("admin", false);
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
	
	public static Boolean get_setStarterPokemon(String id,Boolean flag_get,int src){
		if(flag_get){
			try(Connection conn = DriverManager.getConnection(DB,Name,Password);
				PreparedStatement pstmt = conn.prepareStatement("select starter_pokemon from player where id=?");){
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
					PreparedStatement pstmt = conn.prepareStatement("update player set starter_pokemon=? where id=?");){
						pstmt.setInt(1,src);
						pstmt.setString(2,id);
						pstmt.executeUpdate();
						PreparedStatement pstmt2 = conn.prepareStatement("select basehp from pokemon where pid=?");
						pstmt2.setString(1,Integer.toString(src));
						ResultSet r = pstmt2.executeQuery();
						int basehp=0;
						while(r.next()){
							basehp = r.getInt(1);
						}
						int x = (int)Math.floor(((basehp+0)*2 + Math.floor(Math.ceil(Math.sqrt(50))/4))*10/100)+20;
						PreparedStatement pstmt1 = conn.prepareStatement("insert into playerpokemon values(10,'1',?,1024,1,?,?)");
						pstmt1.setInt(1, x);
						pstmt1.setString(2,id);
						pstmt1.setString(3,Integer.toString(src));
						pstmt1.executeUpdate();
						PreparedStatement pstmt3 = conn.prepareStatement("select hasattack.attackid,attack.pp from hasattack,attack where hasattack.attackid=attack.attackid and hasattack.pid=? and hasattack.levellearnedat <= 10 limit 4");
						pstmt3.setString(1, Integer.toString(src));
						ResultSet r1 = pstmt3.executeQuery();
						PreparedStatement pstmt4 = conn.prepareStatement("insert into playerpokemonmoves values(?,'1',?,?)");
						pstmt4.setString(1, id);
						while(r1.next()){		
							pstmt4.setString(2, r1.getString(1));
							pstmt4.setInt(3, r1.getInt(2));
							pstmt4.executeUpdate();
						}
						return true;
				}
				catch(Exception e){
					System.out.println("Error : "+e);
				}			
		}
		return false;
	}
	
	public static JSONObject getPlayerProfileInfo(String player_id){
		try(Connection conn = DriverManager.getConnection(DB,Name,Password);
			PreparedStatement pstmt = conn.prepareStatement("select name,nickname,experience,money,avatar_chosen from player where id=?");){
			pstmt.setString(1, player_id);
			ResultSet r = pstmt.executeQuery();
			JSONObject json = new JSONObject();
			while(r.next()){
				json.put("name",r.getString(1));
				json.put("nickname",r.getString(2));
				json.put("exp",r.getInt(3));
				json.put("money",r.getInt(4));
				json.put("avatar","./Avatars/full/"+r.getInt(5)+".png");
			}
			PreparedStatement pstmt1 = conn.prepareStatement("select pp.uid,p.pid,name,level,currenthp,basehp,teamposition,typelist from pokemon p,playerpokemon pp where p.pid=pp.pid and id=?");
			pstmt1.setString(1,player_id);
			ResultSet r1=pstmt1.executeQuery();
			JSONArray arr = new JSONArray();
			while(r1.next()){
				JSONObject temp = new JSONObject();
				temp.put("uid",r1.getString(1));
				temp.put("pid",r1.getString(2));
				temp.put("name",r1.getString(3));
				temp.put("level",r1.getInt(4));
				temp.put("teamposition",r1.getInt(7));
				String[] types = r1.getString(8).split(",");
				temp.put("types",types);
				arr.put(temp);
			}
			json.put("pokemons_caught",arr);
			return json;
		}
		catch(Exception e){
			System.out.println("Error : "+e);
		}
		return null;
	}
	
	public static JSONArray getPokedexInfo(){
		JSONArray arr = new JSONArray();
		try(Connection conn = DriverManager.getConnection(DB,Name,Password);
			PreparedStatement pstmt = conn.prepareStatement("select pid,name,typelist from pokemon order by coalesce(cast(nullif(pid,'') as float),0)");){
			ResultSet r = pstmt.executeQuery();
			while(r.next()){
				JSONObject json = new JSONObject();
				json.put("pid", r.getString(1));
				json.put("name", r.getString(2));
				String[] typelist = r.getString(3).split(",");
				json.put("types",typelist);
				arr.put(json);
			}
			return arr;
		}
		catch(Exception e){
			System.out.println("Error : "+e);
		}
		return null;
	}
	
	public static String getPokemonInfo(String pid){
		JSONObject json = new JSONObject();
		JSONArray pokeMoves = new JSONArray();
		try(Connection conn = DriverManager.getConnection(DB,Name,Password);
			PreparedStatement pstmt = conn.prepareStatement("select * from pokemon where pid=?");){
			pstmt.setString(1, pid);
			ResultSet r = pstmt.executeQuery();
			json.put("success",false);
			while(r.next()){
				json.put("success",true);
				json.put("pid", r.getString(1));
				json.put("name",r.getString(2));
				json.put("BaseHP",r.getInt(3));
				json.put("BaseAttack",r.getInt(4));
				json.put("BaseSpeed",r.getInt(5));
				json.put("BaseDefence",r.getInt(6));
				json.put("Types",r.getString(8));
			}
			PreparedStatement pstmt1 = conn.prepareStatement("select hasattack.attackid,attack.name from attack,hasattack where hasattack.attackid=attack.attackid and hasattack.pid=?");
			pstmt1.setString(1, pid);
			ResultSet r1 = pstmt1.executeQuery();
			while(r1.next()){
				JSONObject temp = new JSONObject();
				temp.put("A_ID", "#"+r1.getString(1));
				temp.put("A_Name",r1.getString(2));
				pokeMoves.put(temp);
			}
			json.put("Attacks",pokeMoves);
			return json.toString();
		}
		catch(Exception e){
			System.out.println("Error : "+e);
		}
		return null;
	}
	
	public static String getPlayerPokemonTeamInfo(String player_id){
		JSONArray arr = new JSONArray();
		try(Connection conn = DriverManager.getConnection(DB,Name,Password);
			PreparedStatement pstmt = conn.prepareStatement("select pp.uid,p.pid,name,level,currenthp,basehp,teamposition,typelist,ev,iv from pokemon p,playerpokemon pp where p.pid=pp.pid and id=? and teamposition=1 order by uid");){
			pstmt.setString(1, player_id);
			ResultSet r = pstmt.executeQuery();
			while(r.next()){
				JSONObject temp = new JSONObject();
				temp.put("uid",r.getString(1));
				temp.put("pid",r.getString(2));
				temp.put("name",r.getString(3));
				temp.put("level",r.getInt(4));
				temp.put("teamposition",r.getInt(7));
				String[] types = r.getString(8).split(",");
				temp.put("types",types);
				temp.put("currenthp", r.getInt(5));
				int ev=r.getInt(9),iv=r.getInt(10),lvl=r.getInt(4);
				int x = (int)Math.floor(((r.getInt(6)+iv)*2 + Math.floor(Math.ceil(Math.sqrt(ev))/4))*lvl/100)+lvl+10;
				temp.put("basehp",x);
				arr.put(temp);
			}
			return arr.toString();
		}
		catch(Exception e){
			System.out.println("Error : "+e);
		}
		return null;
	}
	
	public static String getPlayerPokemonStats(String uid,String player_id){
		try(Connection conn = DriverManager.getConnection(DB,Name,Password);){
			PreparedStatement pstmt = conn.prepareStatement("select level,currenthp,experience,iv,ev,basehp,baseattack,basespeed,basedefence,name,playerpokemon.pid,evolveintoid,minevolvelevel from playerpokemon,pokemon where playerpokemon.pid=pokemon.pid and uid=? and id=?");
			pstmt.setString(1, uid);
			pstmt.setString(2,player_id);
			ResultSet r = pstmt.executeQuery();
			JSONObject json = new JSONObject();
			while(r.next()){
				int lvl = r.getInt(1),currHP = r.getInt(2),exp = r.getInt(3),iv = r.getInt(4),ev = r.getInt(5);
				int bHP = r.getInt(6),battack = r.getInt(7),bspeed = r.getInt(8),bdef = r.getInt(9);
				String name = r.getString(10),pokemonID=r.getString(11);
				@SuppressWarnings("unused")
				String evolveintoid = r.getString(12);
				json.put("EvolveAvailable",false);
				if(!r.wasNull()){
					int minevolvelvl = r.getInt(13);
					if(minevolvelvl<=lvl){
						json.put("EvolveAvailable",true);						
					}					
				}
				JSONArray currMoves = new JSONArray();
				JSONArray availableMoves = new JSONArray();
				PreparedStatement pstmt1 = conn.prepareStatement("select playerpokemonmoves.attackid,attack.name from attack,playerpokemonmoves where playerpokemonmoves.attackid=attack.attackid and playerpokemonmoves.id=? and playerpokemonmoves.uid=?");
				pstmt1.setString(1, player_id);
				pstmt1.setString(2, uid);
				ResultSet r1 = pstmt1.executeQuery();
				while(r1.next()){
					JSONObject temp = new JSONObject();
					temp.put("A_ID","#"+r1.getString(1));
					temp.put("A_Name",r1.getString(2));
					currMoves.put(temp);
				}
				json.put("CurrentMoves",currMoves);
				PreparedStatement pstmt2 = conn.prepareStatement("select hasattack.attackid,attack.name from hasattack,attack where hasattack.attackid=attack.attackid and hasattack.pid=? and levellearnedat <= ?");
				pstmt2.setString(1,pokemonID);
				pstmt2.setInt(2,lvl);
				ResultSet r2 = pstmt2.executeQuery();
				while(r2.next()){
					JSONObject temp = new JSONObject();
					temp.put("A_ID","#"+r2.getString(1));
					temp.put("A_Name",r2.getString(2));
					availableMoves.put(temp);
				}
				json.put("AvailableMoves",availableMoves);
				json.put("Level",lvl);
				json.put("Exp",exp);
				json.put("Name",name);
				json.put("currHP",currHP);				
				int x = calculateStat(lvl,bHP,ev,iv,true);
				json.put("MaxHP",x);
				x = calculateStat(lvl,battack,ev,iv,false);
				json.put("Attack",x);
				x = calculateStat(lvl,bspeed,ev,iv,false);
				json.put("Speed",x);
				x = calculateStat(lvl,bdef,ev,iv,false);
				json.put("Defence",x);				
			}
			return json.toString();
		}
		catch(Exception e){
			System.out.println("Error : "+e);
		}
		return null;
	}
	
	public static String addRemoveFromTeam(String uid,String player_id,boolean addFlag){
		try(Connection conn = DriverManager.getConnection(DB,Name,Password);){
			PreparedStatement pstmt = conn.prepareStatement("select count(teamposition) from playerpokemon where teamposition=1 and id=?");
			pstmt.setString(1, player_id);
			int teamCount=0;
			ResultSet r = pstmt.executeQuery();
			while(r.next()){
				teamCount = r.getInt(1);
			}
			if(addFlag){
				if(teamCount<6){
					String[] UID = uid.split(" ");
					uid = UID[2];
					PreparedStatement pstmt1 = conn.prepareStatement("update playerpokemon set teamposition=1 where id=? and uid=?");
					pstmt1.setString(1, player_id);
					pstmt1.setString(2, uid);
					pstmt1.executeUpdate();					
				}				
			}
			else{
				if(teamCount>1){
					String[] UID = uid.split(" ");
					uid = UID[2];
					PreparedStatement pstmt1 = conn.prepareStatement("update playerpokemon set teamposition=0 where id=? and uid=?");
					pstmt1.setString(1,player_id);
					pstmt1.setString(2, uid);
					pstmt1.executeUpdate();	
				}
			}
		}
		catch(Exception e){
			System.out.println("Error : "+e);
		}
		return Constants.getPlayerPokemonTeamInfo(player_id);
	}
	
	public static String addrmKnownMove(String player_id,String uid,String A_ID,boolean addflag){
		try(Connection conn = DriverManager.getConnection(DB,Name,Password);){
			String pokemonID="";
			int lvl = 0;
			PreparedStatement pstmt = conn.prepareStatement("select level,pid from playerpokemon where id=? and uid=?");
			pstmt.setString(1, player_id);
			pstmt.setString(2, uid);
			ResultSet r = pstmt.executeQuery();
			while(r.next()){
				lvl = r.getInt(1);
				pokemonID = r.getString(2);
			}
			PreparedStatement check1 = conn.prepareStatement("select count(*) from hasattack where attackid=? and pid=? and levellearnedat <= ?");
			check1.setString(1, A_ID);
			check1.setString(2, pokemonID);
			check1.setInt(3, lvl);
			ResultSet c1 = check1.executeQuery();
			JSONObject json = new JSONObject();
			while(c1.next()){
				if(c1.getInt(1)==0){
					json.put("success",false);
					return json.toString();
				}
			}
			
			PreparedStatement check2 = conn.prepareStatement("select count(*) from playerpokemonmoves where id=? and uid=?");
			check2.setString(1, player_id);
			check2.setString(2, uid);
			ResultSet c2 = check2.executeQuery();
			while(c2.next()){
				if((c2.getInt(1)==4&&addflag)||(c2.getInt(1)==1&&(!addflag))){
					json.put("success",false);
					return json.toString();
				}
			}
			
			if(addflag){
				PreparedStatement update = conn.prepareStatement("insert into playerpokemonmoves (select ?,?,?,pp from attack where attackid=?)");
				update.setString(1, player_id);
				update.setString(2, uid);
				update.setString(3, A_ID);
				update.setString(4, A_ID);
				update.executeUpdate();
			}
			else{
				PreparedStatement update = conn.prepareStatement("delete from playerpokemonmoves where id=? and uid=? and attackid=?");
				update.setString(1, player_id);
				update.setString(2,uid);
				update.setString(3,A_ID);
				update.executeUpdate();
			}
			
			JSONArray currMoves = new JSONArray();
			JSONArray availableMoves = new JSONArray();
			PreparedStatement pstmt1 = conn.prepareStatement("select playerpokemonmoves.attackid,attack.name from attack,playerpokemonmoves where playerpokemonmoves.attackid=attack.attackid and playerpokemonmoves.id=? and playerpokemonmoves.uid=?");
			pstmt1.setString(1, player_id);
			pstmt1.setString(2, uid);
			ResultSet r1 = pstmt1.executeQuery();
			while(r1.next()){
				JSONObject temp = new JSONObject();
				temp.put("A_ID","#"+r1.getString(1));
				temp.put("A_Name",r1.getString(2));
				currMoves.put(temp);
			}
			json.put("CurrMoves",currMoves);
			PreparedStatement pstmt2 = conn.prepareStatement("select hasattack.attackid,attack.name from hasattack,attack where hasattack.attackid=attack.attackid and hasattack.pid=? and levellearnedat <= ?");
			pstmt2.setString(1,pokemonID);
			pstmt2.setInt(2,lvl);
			ResultSet r2 = pstmt2.executeQuery();
			while(r2.next()){
				JSONObject temp = new JSONObject();
				temp.put("A_ID","#"+r2.getString(1));
				temp.put("A_Name",r2.getString(2));
				availableMoves.put(temp);
			}
			json.put("AMoves",availableMoves);
			json.put("success",true);
			return json.toString();
		}
		catch(Exception e){
			System.out.println("Error : "+e);
		}
		return null;
	}
	
	public static String WildBattleBegin(String wildPID,int level){
		try(Connection conn = DriverManager.getConnection(DB,Name,Password);){
			PreparedStatement p1 = conn.prepareStatement("select nextval('wildpokemonid')");
			ResultSet r1 = p1.executeQuery();
			String wildID = "";
			while(r1.next()){
				wildID = Integer.toString(r1.getInt(1));
			}
			PreparedStatement pstmt = conn.prepareStatement("insert into wildpokemon values(?,?,?,?)");
			pstmt.setString(1, wildPID);
			pstmt.setString(2, wildID);
			pstmt.setInt(3, level);			
			PreparedStatement pstmt1 = conn.prepareStatement("select name,basehp from pokemon where pid=?");
			pstmt1.setString(1, wildPID);
			ResultSet r = pstmt1.executeQuery();
			JSONObject wildInfo = new JSONObject();
			wildInfo.put("wildID",wildID);
			wildInfo.put("Level",level);
			int currhp=0;
			while(r.next()){
				wildInfo.put("name",r.getString(1));
				currhp = calculateStat(level,r.getInt(2),50,0,true);
				wildInfo.put("currHP",currhp);
			}
			pstmt.setInt(4, currhp);
			pstmt.executeUpdate();
			PreparedStatement pstmt2 = conn.prepareStatement("insert into wildpokemonmoves (select ?,hasattack.attackid,pp from attack,hasattack where hasattack.pid=? and attack.attackid=hasattack.attackid and levellearnedat<=? limit 4)");
			pstmt2.setString(1,wildID);
			pstmt2.setString(2,wildPID);
			pstmt2.setInt(3,level);
			pstmt2.executeUpdate();
			return wildInfo.toString();
		}
		catch(Exception e){
			System.out.println("Error : "+e);
		}
		return null;
	}
	
	private static int calculateStat(int lvl,int basestat,int ev,int iv,boolean hpflag){
		int stat = 0;
		if(hpflag){
			stat = (int)Math.floor(((basestat+iv)*2 + Math.floor(Math.ceil(Math.sqrt(ev))/4))*lvl/100)+lvl+10;
		}
		else{
			stat = (int)Math.floor(((basestat+iv)*2 + Math.floor(Math.ceil(Math.sqrt(ev))/4))*lvl/100)+5;
		}
		return stat;
	}

	public static String getPlayerPokemonMoves(String player_id,String uid){
		try(Connection conn = DriverManager.getConnection(DB,Name,Password);){
			PreparedStatement pstmt = conn.prepareStatement("select pm.attackid,a.name,pm.pp from playerpokemonmoves as pm,attack as a where pm.attackid=a.attackid and pm.uid=? and pm.id=?");
			pstmt.setString(1,uid);
			pstmt.setString(2,player_id);
			ResultSet r = pstmt.executeQuery();
			JSONArray pokeMoves = new JSONArray();
			while(r.next()){
				JSONObject temp = new JSONObject();
				temp.put("uid",uid);
				temp.put("AttackID",r.getString(1));
				temp.put("Name",r.getString(2));
				temp.put("PP",r.getInt(3));
				pokeMoves.put(temp);
			}
			return pokeMoves.toString();
		}
		catch(Exception e){
			System.out.println("Error : "+e);
		}
		return null;
	}
	
	public static String EvolvePokemon(String player_id,String uid){
		try(Connection conn = DriverManager.getConnection(DB,Name,Password);
			PreparedStatement pstmt = conn.prepareStatement("select evolveintoid from pokemon as p,playerpokemon as pp where p.pid=pp.pid and pp.uid=? and pp.id=?");
			PreparedStatement pstmt1 = conn.prepareStatement("update playerpokemon set pid=? where uid=? and id=?");){
			pstmt.setString(1,uid);
			pstmt.setString(2, player_id);
			ResultSet r = pstmt.executeQuery();
			String evolveIntoId = "";
			while(r.next()){
				evolveIntoId = r.getString(1);
			}			
			pstmt1.setString(1, evolveIntoId);
			pstmt1.setString(2, uid);
			pstmt1.setString(3, player_id);
			pstmt1.executeUpdate();
			JSONObject success = new JSONObject();
			success.put("success",true);
			return success.toString();
		}
		catch(Exception e){
			System.out.println("Error : "+e);
		}
		return null;
	}
		

	public static String wildAttack(String player_id,String uid,String attackId,String wildId){
		JSONObject json = new JSONObject();		
		try(Connection conn = DriverManager.getConnection(DB,Name,Password);
			PreparedStatement userPokeData = conn.prepareStatement("select Level,BaseHP,CurrentHP,BaseAttack,BaseDefence,BaseSpeed,TypeList,IV,EV,p.name from PlayerPokemon as pp, Pokemon as p where pp.PID=p.PID and pp.ID=? and pp.UID=?");
			PreparedStatement userMoveData = conn.prepareStatement("select a.Name, a.Power, (a.Accuracy/100) as Accuracy, a.Type,ppm.PP from PlayerPokemonMoves as ppm, Attack as a where ppm.AttackID=a.AttackID and ppm.ID=? and ppm.UID=? and ppm.AttackID=?");
			PreparedStatement wildMoveData = conn.prepareStatement("select wpm.AttackId, a.Name, a.Power, (a.Accuracy/100) as Accuracy, a.Type, wpm.PP from WildPokemonMoves as wpm, Attack as a where wpm.AttackID=a.AttackID and wpm.WildID=?");
			PreparedStatement wildPokeData = conn.prepareStatement("select Level,BaseHP,CurrentHP,BaseAttack,BaseDefence,BaseSpeed,TypeList,IV,EV,p.name from WildPokemon as wp, Pokemon as p where wp.PID=p.PID and wp.WildID=?");){
			userPokeData.setString(1, player_id);
			userPokeData.setString(2, uid);
			userMoveData.setString(2, uid);
			userMoveData.setString(3, attackId);
			userMoveData.setString(1,player_id);
			wildMoveData.setString(1, wildId);
			wildPokeData.setString(1, wildId);
			ResultSet r1 = userPokeData.executeQuery();
			ResultSet r2 = userMoveData.executeQuery();
			ResultSet r3 = wildPokeData.executeQuery();
			ResultSet r4 = wildMoveData.executeQuery();
			
			r1.next();
			r2.next();
			r3.next();
			r4.next();
			if(r2.getInt(5)>0) {
				json.put("status", true);
				int temp=0;
				while(temp!=0) {
					r4 = wildMoveData.executeQuery();
					int rand = ThreadLocalRandom.current().nextInt(0, 4);
					for(int i=0;i<=rand;i++)
						r4.next();
					temp=r4.getInt(6);
				}
				PreparedStatement UserPokeUpdate = conn.prepareStatement("Update PlayerPokemon set CurrentHP=? where ID=? and UID=?");
				PreparedStatement WildPokeUpdate = conn.prepareStatement("Update WildPokemon set CurrentHP=? where WildID=?");
				PreparedStatement UserPokeMoveUpdate = conn.prepareStatement("Update PlayerPokemonMoves set PP=? where ID=? and UID=? and AttackID=?");
				PreparedStatement WildPokeMoveUpdate = conn.prepareStatement("Update WildPokemonMoves set PP=? where WildID=? and AttackID=?");
				int Level1 = r1.getInt(1);
				int Level2 = r3.getInt(1);
				int TotalHp1 = calculateStat(Level1,r1.getInt(2),r1.getInt(9),r1.getInt(8),true);
				int TotalHp2 = calculateStat(Level2,r3.getInt(2),r3.getInt(9),r3.getInt(8),true);
				int Attack1 = calculateStat(Level1,r1.getInt(4),r1.getInt(9),r1.getInt(8),false);
				int Attack2 = calculateStat(Level2,r3.getInt(4),r3.getInt(9),r3.getInt(8),false);
				int Defense1 = calculateStat(Level1,r1.getInt(5),r1.getInt(9),r1.getInt(8),false);
				int Defense2 = calculateStat(Level2,r3.getInt(5),r3.getInt(9),r3.getInt(8),false);
				int Speed1 = calculateStat(Level1,r1.getInt(6),r1.getInt(9),r1.getInt(8),false);
				int Speed2 = calculateStat(Level2,r3.getInt(6),r3.getInt(9),r3.getInt(8),false);
				int UserDoneDamage =(int) (((((2*Level1/5.0)+2)*r2.getInt(2)*(Attack1/Defense2)/50)+2)*(ThreadLocalRandom.current().nextInt(850, 1000)/1000.0));
				int WildDoneDamage =(int) (((((2*Level2/5.0)+2)*r4.getInt(3)*(Attack2/Defense1)/50)+2)*(ThreadLocalRandom.current().nextInt(850, 1000)/1000.0));
				//Add STAB effect and Type effect after type effect table is populated
				if(r2.getInt(2)==0) {
					UserDoneDamage=0;
				}
				int CurrHp2=Math.max(0, r3.getInt(3)-UserDoneDamage);
				int CurrHp1=Math.max(0, r1.getInt(3)-WildDoneDamage);
				UserPokeUpdate.setInt(1,CurrHp1);
				UserPokeUpdate.setString(2, player_id);
				UserPokeUpdate.setString(3, uid);
				WildPokeUpdate.setInt(1, CurrHp2);
				WildPokeUpdate.setString(2, wildId);
				UserPokeMoveUpdate.setInt(1,r2.getInt(5)-1);
				UserPokeMoveUpdate.setString(2,player_id);
				UserPokeMoveUpdate.setString(3,uid);
				UserPokeMoveUpdate.setString(4,attackId);
				WildPokeMoveUpdate.setInt(1,r4.getInt(6)-1);
				WildPokeMoveUpdate.setString(2,wildId);
				WildPokeMoveUpdate.setString(3,r4.getString(1));
				String Message = "";
				try {
					conn.setAutoCommit(false);
					if(CurrHp2!=0 || (CurrHp2==0 && Speed2>Speed1)) {
						UserPokeUpdate.executeUpdate();
						WildPokeMoveUpdate.executeUpdate();
						json.put("WildDoneDamage", WildDoneDamage);
						Message = Message + "Enemy "+r3.getString(10)+ " used "+r4.getString(2)+ " and caused "+Integer.toString(WildDoneDamage)+"HP damage.";
						
					}
					else {
						json.put("WildDoneDamage", 0);
					}
					if(CurrHp1!=0 || (CurrHp1==0 && Speed1>Speed2)) {
						WildPokeUpdate.executeUpdate();
						UserPokeMoveUpdate.executeUpdate();
						json.put("UserDoneDamage", UserDoneDamage);
						json.put("PP", r2.getInt(5)-1);
						Message = Message + "Your "+r1.getString(10)+ " used "+r2.getString(1)+ " and caused "+Integer.toString(UserDoneDamage)+"HP damage.";
					}
					else {
						json.put("UserDoneDamage", 0);
						json.put("PP", r2.getInt(5));
					}
					conn.commit();
					conn.setAutoCommit(true);
					json.put("UserCurrHP", CurrHp1);
					json.put("WildCurrHP", CurrHp2);
					json.put("UserHp", TotalHp1);
					json.put("WildHp", TotalHp2);
					json.put("message", Message);
				}
				catch(Exception e) {
					System.out.println("Error : "+e);
					conn.rollback();
					return null;
				}
			}
			else {
				json.put("status", false);
				json.put("Message", "Insufficient Power Points");
			}
			return json.toString();
		}
		catch(Exception e){
			System.out.println("Error : "+e);
		}
		return null;
	}
	
	public static String healPlayerTeam(String player_id){
		try(Connection conn = DriverManager.getConnection(DB,Name,Password);){
			return Constants.getPlayerPokemonTeamInfo(player_id);
		}
		catch(Exception e){
			System.out.println("Error : "+e);
		}
		return null;
	}
}
