package org.elluck91.munchies;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class TransactionAPI
 */
@WebServlet(name = "/TransactionAPI", urlPatterns = { "/TransactionAPI" })
//@WebServlet("/TransactionAPI")
public class TransactionAPI extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TransactionAPI() {
        super();
        // TODO Auto-generated constructor stub
    }
    
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			/* TODO output your page here. You may use following sample code. */
			out.println("<!DOCTYPE html>");
			out.println("<html>");
			out.println("<head>");
			out.println("<title>Servlet LoginAPI</title>");            
			out.println("</head>");
			out.println("<body>");
			out.println("<h1>You successfully accessed TransactionAPI</h1>");
			out.println("</body>");
			out.println("</html>");
		} finally {
			out.close();
		}
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		DbManager db = new DbManager();
		
		ArrayList<Transaction> transactionListComplete = null;
		
		//String transactions = db.getTransactions(request.getParameter("username"));
		String[] transactionList = db.getTransactionList(request.getParameter("username"));
		if (transactionList != null) {
			transactionListComplete = new ArrayList<Transaction>();
			Transaction tempTransaction;
			for (String transaction : transactionList) {
				System.out.println("Transaction: " + transaction);
				tempTransaction = db.getTransactionDetails(transaction);
				transactionListComplete.add(tempTransaction);
			}
			/*
			for (Transaction transaction : transactionListComplete) {
				System.out.println(transaction.toString());
			}
			*/
		}
		else {
			System.out.println("Transaction list is empty.");
		}
		
		request.setAttribute("transactionList", transactionListComplete);
		RequestDispatcher requestDispatcher; 
		requestDispatcher = request.getRequestDispatcher("/transaction_info.jsp");
		requestDispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		DbManager db = new DbManager();
		String username = (String) request.getParameter("username");
		System.out.println("Username: " + username);
		if (username.equals("")) {
			session.setAttribute("cart", new Cart());
		}
		else {
			int transaction_id = 1;
			String productList = request.getParameter("productList");
			Date date = new Date(Calendar.getInstance().getTime().getTime());
			Double totalSum = Double.parseDouble(request.getParameter("totalSum"));
			
			System.out.println("String: " + username + "\ntransaction_id: " + transaction_id + "\nproductList: " + productList + "\ndate: " + date + "\ntotalSum: " + totalSum);
			Transaction transaction = new Transaction(transaction_id, productList, date, totalSum);
			transaction.setProductListString(productList);
			
			transaction_id = db.insertTransaction(transaction);
			System.out.println("Updating user");
			db.updateUser(username, transaction_id);
			request.setAttribute("cart", new Cart());
			session.setAttribute("cart", new Cart());
		}
		
		RequestDispatcher requestDispatcher; 
		requestDispatcher = request.getRequestDispatcher("/thank_you.jsp");
		requestDispatcher.forward(request, response);
		
	}

}
