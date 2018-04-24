package org.elluck91.munchies;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class CartAPI
 */
@WebServlet("/CartAPI")
public class CartAPI extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CartAPI() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		DbManager db = new DbManager();
		Cart cart;
		String param = request.getParameter("action");
		if (param != null && param.equals("delete")) {
			if ((cart = (Cart) session.getAttribute("cart")) != null) {
				cart.removeProductFromCart(request.getParameter("product_id"));
			}
		}
		else {
			Product product = db.getProduct(request.getParameter("product_id"));
			String count = request.getParameter("count");
			product.setProduct_quantity(Integer.parseInt(count));
			if ((cart = (Cart) session.getAttribute("cart")) != null) {
				System.out.println("Cart before adding: \n" + cart.toString());
				System.out.println("Incrementing product count");
				cart.addProductToCart(product, count);
				session.setAttribute("cart", cart);
				System.out.println("Cart after adding: \n" + cart.toString());
			}
			else {
				System.out.println("Adding new product to cart");
				cart = new Cart();
				System.out.println("Cart before adding: \n" + cart.toString());
				cart.addProductToCart(product, count);
				session.setAttribute("cart", cart);
				System.out.println("Cart after adding: \n" + cart.toString());
			}
		}
		
		
		
		response.sendRedirect("./ProductAPI?product_id=" + request.getParameter("product_id"));
		
	}

}
