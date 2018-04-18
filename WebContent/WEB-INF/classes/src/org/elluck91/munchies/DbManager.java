package org.elluck91.munchies;
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Eslam
 */
public class DbManager implements IRepo{


	Connection con ;
	public DbManager(){



	}


	@Override
	public int Login(String username, String password) {

		System.out.println("Username: " + username + " Password: " + password);
		try {

			Class.forName("com.mysql.jdbc.Driver");

			con  = DriverManager.getConnection("jdbc:mysql://localhost/munchies","root","admin");

			//con  = DriverManager.getConnection("jdbc:mysql://localhost/munchies","elluck91","blank");

			PreparedStatement sql = con.prepareStatement("SELECT COUNT(*) FROM Users WHERE Username=? AND Password=sha2(?, 256)");
			sql.setString(1, username);
			sql.setString(2, password);


			ResultSet res=  sql.executeQuery();

			res.next();
			System.out.println("Result: " + res.getInt(1));


			return res.getInt(1);


		} catch (SQLException ex) {
			Logger.getLogger(DbManager.class.getName()).log(Level.SEVERE, "ex happened !!!", ex);
			return 0;
		} catch (ClassNotFoundException ex) {
			Logger.getLogger(DbManager.class.getName()).log(Level.SEVERE, null, ex);
			return 0;
		}catch(Exception ex){
			Logger.getLogger(DbManager.class.getName()).log(Level.SEVERE, ex.getMessage(), ex);
			return 0;
		}finally{
			try {
				con.close();
			} catch (SQLException ex) {
				Logger.getLogger(DbManager.class.getName()).log(Level.SEVERE, null, ex);
			}
		}

	}

	@Override
	public int Register(User user) {
		try {

			Class.forName("com.mysql.jdbc.Driver");
			//con  = DriverManager.getConnection("jdbc:mysql://localhost/Students","cmpe133","cmpe133_Spring2018!");

			con  = DriverManager.getConnection("jdbc:mysql://localhost/munchies","root","admin");

			//con  = DriverManager.getConnection("jdbc:mysql://localhost/munchies","elluck91","blank");


			PreparedStatement sql = con.prepareStatement("INSERT INTO Users VALUES(?,sha2(?, 256),?,?,?)");
			sql.setString(1, user.username);
			sql.setString(2, user.password);
			sql.setString(3, user.email);
			sql.setDate(4, user.lastlogin);
			sql.setString(5, user.name);

			sql.execute();
			return 1;


		} catch (SQLException ex) {
			Logger.getLogger(DbManager.class.getName()).log(Level.SEVERE, "ex happened !!!", ex);
			return 0;
		} catch (ClassNotFoundException ex) {
			Logger.getLogger(DbManager.class.getName()).log(Level.SEVERE, null, ex);
			return 0;
		}catch(Exception ex){
			Logger.getLogger(DbManager.class.getName()).log(Level.SEVERE, ex.getMessage(), ex);
			return 0;
		}finally{
			try {
				con.close();
			} catch (SQLException ex) {
				Logger.getLogger(DbManager.class.getName()).log(Level.SEVERE, null, ex);
			}
		}


	}

	@Override
	public User GetUser(String byUsername) {
		try {

			Class.forName("com.mysql.jdbc.Driver");
			con  = DriverManager.getConnection("jdbc:mysql://localhost/munchies","root","admin");
			//con  = DriverManager.getConnection("jdbc:mysql://localhost/munchies","elluck91","blank");


			User user = new User();

			PreparedStatement sql = con.prepareStatement("SELECT * FROM Users WHERE username=?");
			sql.setString(1, byUsername);

			ResultSet res = sql.executeQuery();
			res.next();

			user.ID = res.getInt(1);
			user.username = res.getString(2);
			user.email = res.getString(3);
			user.password = res.getString(4);
			user.lastlogin = res.getDate(5);
			user.name = res.getString(6);
			return user;


		} catch (SQLException ex) {
			Logger.getLogger(DbManager.class.getName()).log(Level.SEVERE, "ex happened !!!", ex);
			return null;
		} catch (ClassNotFoundException ex) {
			Logger.getLogger(DbManager.class.getName()).log(Level.SEVERE, null, ex);
			return null;
		}catch(Exception ex){
			Logger.getLogger(DbManager.class.getName()).log(Level.SEVERE, ex.getMessage(), ex);
			return null;
		}finally{
			try {
				con.close();
			} catch (SQLException ex) {
				Logger.getLogger(DbManager.class.getName()).log(Level.SEVERE, null, ex);
			}
		}
	}

/*
	@Override
	public List<Post> SearchPosts(String title){

		try {

			Class.forName("com.mysql.jdbc.Driver");
			con  = DriverManager.getConnection("jdbc:mysql://localhost/blog","elluck91","blank");

			Post post;
			List<Post>  posts = new ArrayList<Post>();
			PreparedStatement sql = con.prepareStatement("SELECT * FROM Posts WHERE PostTitle LIKE '%"+title+"%'");

			ResultSet res = sql.executeQuery();
			while( res.next()){
				post = new Post();
				post.ID = res.getInt(1);
				post.PostTitle = res.getString(2);
				post.PostContent = res.getString(3);
				post.PostDescription = res.getString(4);
				post.PostImage = res.getString(5);
				post.PublishDate = res.getString(6);
				post.PostAuthor = res.getString(7);
				post.IsVisiable = res.getBoolean(8);
				post.AllowComments = res.getBoolean(9);
				posts.add(post);
			}
			return posts;


		} catch (SQLException ex) {
			Logger.getLogger(DbManager.class.getName()).log(Level.SEVERE, "ex happened !!!", ex);
			return null;
		} catch (ClassNotFoundException ex) {
			Logger.getLogger(DbManager.class.getName()).log(Level.SEVERE, null, ex);
			return null;
		}catch(Exception ex){
			Logger.getLogger(DbManager.class.getName()).log(Level.SEVERE, ex.getMessage(), ex);
			return null;
		}finally{
			try {
				con.close();
			} catch (SQLException ex) {
				Logger.getLogger(DbManager.class.getName()).log(Level.SEVERE, null, ex);
			}
		}
	}

	@Override
	public int InsertPost(Post post) {
		try {

			Class.forName("com.mysql.jdbc.Driver");
			con  = DriverManager.getConnection("jdbc:mysql://localhost/blog","elluck91","blank");

			PreparedStatement sql = con.prepareStatement("INSERT INTO Posts VALUES(NULL,?,?,?,?,?,?,?,?)");
			sql.setString(1, post.PostTitle);
			sql.setString(2, post.PostContent);
			sql.setString(3, post.PostDescription);
			sql.setString(4, post.PostImage);
			sql.setString(5, post.PublishDate);
			sql.setString(6, post.PostAuthor);
			sql.setBoolean(7, post.IsVisiable);
			sql.setBoolean(8, post.AllowComments);
			sql.execute();

			return 1;


		} catch (SQLException ex) {
			Logger.getLogger(DbManager.class.getName()).log(Level.SEVERE, "ex happened !!!", ex);
			return 0;
		} catch (ClassNotFoundException ex) {
			Logger.getLogger(DbManager.class.getName()).log(Level.SEVERE, null, ex);
			return 0;
		}catch(Exception ex){
			Logger.getLogger(DbManager.class.getName()).log(Level.SEVERE, ex.getMessage(), ex);
			return 0;
		}finally{
			try {
				con.close();
			} catch (SQLException ex) {
				Logger.getLogger(DbManager.class.getName()).log(Level.SEVERE, null, ex);
			}
		}


	}

	@Override
	public List<Post> SearchPostsInsecure(String title, String username){
		try {

			Class.forName("com.mysql.jdbc.Driver");
			con  = DriverManager.getConnection("jdbc:mysql://localhost/blog","elluck91","blank");


			Post post;
			List<Post>  posts = new ArrayList<Post>();


			String accountBalanceQuery = "SELECT * FROM Posts WHERE PostTitle='" + title + "' AND PostAuthor='" + username + "'";
			System.out.println(accountBalanceQuery);
			Statement statement = con.createStatement();
			ResultSet res = statement.executeQuery(accountBalanceQuery);
			while( res.next()){
				post = new Post();
				post.ID = res.getInt(1);
				post.PostTitle = res.getString(2);
				post.PostContent = res.getString(3);
				post.PostDescription = res.getString(4);
				post.PostImage = res.getString(5);
				post.PublishDate = res.getString(6);
				post.PostAuthor = res.getString(7);
				post.IsVisiable = res.getBoolean(8);
				post.AllowComments = res.getBoolean(9);
				posts.add(post);
			}

				System.out.println("Size of posts: " + posts.size());
			return posts;
		} catch (SQLException ex) {
			Logger.getLogger(DbManager.class.getName()).log(Level.SEVERE, "ex happened !!!", ex);
			return null;
		} catch (ClassNotFoundException ex) {
			Logger.getLogger(DbManager.class.getName()).log(Level.SEVERE, null, ex);
			return null;
		}catch(Exception ex){
			Logger.getLogger(DbManager.class.getName()).log(Level.SEVERE, ex.getMessage(), ex);
			return null;
		}finally{
			try {
				con.close();
			} catch (SQLException ex) {
				Logger.getLogger(DbManager.class.getName()).log(Level.SEVERE, null, ex);
			}
		}


	}
	
	@Override
	public List<Post> GetAllPostsInsecure(String username) {
		try {

			Class.forName("com.mysql.jdbc.Driver");
			con  = DriverManager.getConnection("jdbc:mysql://localhost/blog","elluck91","blank");

			Post post;
			List<Post>  posts = new ArrayList<Post>();
			PreparedStatement sql = con.prepareStatement("SELECT * FROM Posts WHERE PostAuthor='" + username + "'");

			ResultSet res = sql.executeQuery();
			while( res.next()){
				post = new Post();
				post.ID = res.getInt(1);
				post.PostTitle = res.getString(2);
				post.PostContent = res.getString(3);
				post.PostDescription = res.getString(4);
				post.PostImage = res.getString(5);
				post.PublishDate = res.getString(6);
				post.PostAuthor = res.getString(7);
				post.IsVisiable = res.getBoolean(8);
				post.AllowComments = res.getBoolean(9);
				posts.add(post);
			}


			return posts;


		} catch (SQLException ex) {
			Logger.getLogger(DbManager.class.getName()).log(Level.SEVERE, "ex happened !!!", ex);
			return null;
		} catch (ClassNotFoundException ex) {
			Logger.getLogger(DbManager.class.getName()).log(Level.SEVERE, null, ex);
			return null;
		}catch(Exception ex){
			Logger.getLogger(DbManager.class.getName()).log(Level.SEVERE, ex.getMessage(), ex);
			return null;
		}finally{
			try {
				con.close();
			} catch (SQLException ex) {
				Logger.getLogger(DbManager.class.getName()).log(Level.SEVERE, null, ex);
			}
		}
	}

*/
}
