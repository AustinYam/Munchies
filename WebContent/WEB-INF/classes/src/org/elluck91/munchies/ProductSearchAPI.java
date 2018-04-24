package org.elluck91.munchies;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ProductSearchAPI
 */
@WebServlet("/ProductSearchAPI")
public class ProductSearchAPI extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductSearchAPI() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String searchTerm;
		
		if ((searchTerm = request.getParameter("product_name")) != null) {
			System.out.println("searching for products");
			ArrayList<Product> products = new ArrayList<Product>();
			DbManager db = new DbManager();
			
			products = db.productSearch(searchTerm);
			
			request.setAttribute("searchedProducts", products);
			RequestDispatcher requestDispatcher; 
			requestDispatcher = request.getRequestDispatcher("/productSearch_info.jsp");
			requestDispatcher.forward(request, response);
		}
		
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
