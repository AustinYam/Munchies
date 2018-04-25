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
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author elluck91
 */
public class DbManager implements IRepo{


	Connection con ;
	
	public DbManager(){

	}


	@Override
	public int Login(String username, String password) {
		try {

			Class.forName("com.mysql.jdbc.Driver");
			con  = DriverManager.getConnection("jdbc:mysql://localhost/munchies","elluck91","blank");

			PreparedStatement sql = con.prepareStatement("SELECT COUNT(*) FROM users WHERE Username=? AND Password=sha2(?, 256)");
			sql.setString(1, username);
			sql.setString(2, password);


			ResultSet res=  sql.executeQuery();

			res.next();

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
			con  = DriverManager.getConnection("jdbc:mysql://localhost/munchies","elluck91","blank");
			PreparedStatement sql = con.prepareStatement("INSERT INTO users VALUES(?,sha2(?, 256),?,?,?)");
			sql.setString(1, user.username);
			sql.setString(2, user.password);
			sql.setString(3, user.email);
			sql.setString(4, user.name);
			sql.setString(5,  user.transactions);

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
			con  = DriverManager.getConnection("jdbc:mysql://localhost/munchies","elluck91","blank");

			User user = new User();

			PreparedStatement sql = con.prepareStatement("SELECT * FROM users WHERE username=?");
			sql.setString(1, byUsername);

			ResultSet res = sql.executeQuery();
			res.next();

			user.username = res.getString(1);
			user.password = res.getString(2);
			user.email = res.getString(3);
			user.name = res.getString(4);
			user.transactions = res.getString(5);
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


	public String[] getTransactionList(String username) {
		String[] result = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con  = DriverManager.getConnection("jdbc:mysql://localhost/munchies","elluck91","blank");
			PreparedStatement sql = con.prepareStatement("SELECT * FROM users where username=?");
			sql.setString(1, username);

			ResultSet res = sql.executeQuery();
			
			while (res.next())
			    result = res.getString("transactions").split(",");
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}


	public Transaction getTransactionDetails(String transaction) {
		Transaction result = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con  = DriverManager.getConnection("jdbc:mysql://localhost/munchies","elluck91","blank");
			PreparedStatement sql = con.prepareStatement("SELECT * FROM transaction where transaction_id=?");
			sql.setString(1, transaction);

			ResultSet res = sql.executeQuery();
			String[] productList;
			Product prod;
			while (res.next()) {
				result = new Transaction(res.getInt("transaction_id"), res.getString("transaction_products"),
						res.getDate("transaction_date"), res.getDouble("transaction_total"));
				productList = res.getString("transaction_products").split(",");
				for (String product : productList) {
					prod = getProduct(product);
					if (prod != null) {
						result.addProduct(prod);
					}		
				}
			}
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}


	public Product getProduct(String product_id) {
		Product product = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con  = DriverManager.getConnection("jdbc:mysql://localhost/munchies","elluck91","blank");
			PreparedStatement sql = con.prepareStatement("SELECT * FROM product where product_id=?");
			sql.setString(1, product_id);

			ResultSet res = sql.executeQuery();
			
			while (res.next()) {
				product = new Product(res.getString("product_uniquename"), res.getString("product_name"),
						res.getDouble("product_price"), res.getString("product_description"),
						res.getString("product_img"), res.getString("product_category"), res.getInt("product_id"));
				
			}
			
			con.close();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return product;
	}


	public void insertTransaction(Transaction transaction) {
		try {

			Class.forName("com.mysql.jdbc.Driver");
			con  = DriverManager.getConnection("jdbc:mysql://localhost/munchies","elluck91","blank");
			PreparedStatement sql = con.prepareStatement("INSERT INTO transaction VALUES(?,?,?,?)");
			sql.setInt(1, transaction.getTransaction_id());
			sql.setDate(2, transaction.getDate());
			sql.setDouble(3, transaction.getTotalSum());
			sql.setString(4, transaction.getProductListString());
			sql.execute();
			
			

		} catch (SQLException ex) {
			Logger.getLogger(DbManager.class.getName()).log(Level.SEVERE, "ex happened !!!", ex);
		} catch (ClassNotFoundException ex) {
			Logger.getLogger(DbManager.class.getName()).log(Level.SEVERE, null, ex);
		}catch(Exception ex){
			Logger.getLogger(DbManager.class.getName()).log(Level.SEVERE, ex.getMessage(), ex);
		}finally{
			try {
				con.close();
			} catch (SQLException ex) {
				Logger.getLogger(DbManager.class.getName()).log(Level.SEVERE, null, ex);
			}
		}
		
	}


	public void updateUser(String username, int transaction_id) {
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con  = DriverManager.getConnection("jdbc:mysql://localhost/munchies","elluck91","blank");
			PreparedStatement sql = con.prepareStatement("SELECT transactions FROM users where username=?");

			sql.setString(1, username);
			String transactionList = "";
			ResultSet res = sql.executeQuery();
			
			while (res.next()) {
			    transactionList += res.getString("transactions");
				
			}
			transactionList += transaction_id + ",";
			sql = con.prepareStatement("UPDATE users SET transactions=? WHERE username=?");
			sql.setString(1, transactionList);
			sql.setString(2, username);
			
			sql.execute();
			
			con.close();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}


	public ArrayList<Product> getCategoryProducts(String category) {
		ArrayList<Product> productList = new ArrayList<Product>();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con  = DriverManager.getConnection("jdbc:mysql://localhost/munchies","elluck91","blank");
			PreparedStatement sql = con.prepareStatement("SELECT * FROM product where product_category=?");
			sql.setString(1, category);

			ResultSet res = sql.executeQuery();
			Product product;
			while (res.next()) {
				product = new Product(res.getString("product_uniquename"), res.getString("product_name"),
						res.getDouble("product_price"), res.getString("product_description"),
						res.getString("product_img"), res.getString("product_category"), res.getInt("product_id"));
				productList.add(product);
				
			}
			
			con.close();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return productList;
	}
	
	public ArrayList<Product> productSearch(String productName) {
		//word search 
		ArrayList<Product> searchedProducts = new ArrayList<Product>();
		Product product = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con  = DriverManager.getConnection("jdbc:mysql://localhost/munchies","elluck91","blank");
			PreparedStatement sql = con.prepareStatement("SELECT * FROM product where product_name=?");
			sql.setString(1, productName);

			ResultSet res = sql.executeQuery();
			
			while (res.next()) {
				product = new Product(res.getString("product_uniquename"), res.getString("product_name"),
						res.getDouble("product_price"), res.getString("product_description"),
						res.getString("product_img"), res.getString("product_category"), res.getInt("product_id"));
				searchedProducts.add(product);
				
			}
			
			con.close();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return searchedProducts;
	}


	public ArrayList<Product> getProducts() {
		// TODO Auto-generated method stub
		return null;
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
			con  = DriverManager.getConnection("jdbc:mysql://localhost/munchies","elluck91","blank");

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
