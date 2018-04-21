package org.elluck91.munchies;

import java.sql.Date;
import java.util.ArrayList;

public class Transaction {
	public int getTransaction_id() {
		return transaction_id;
	}

	public void setTransaction_id(int transaction_id) {
		this.transaction_id = transaction_id;
	}

	public String getProductListString() {
		return productListString;
	}

	public void setProductListString(String productListString) {
		this.productListString = productListString;
	}
	
	public ArrayList<Product> getProductList() {
		return productList;
	}

	public void setProductList(ArrayList<Product> productList) {
		this.productList = productList;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Double getTotalSum() {
		return totalSum;
	}

	public void setTotalSum(Double totalSum) {
		this.totalSum = totalSum;
	}
	
	int transaction_id;
	String productListString;
	Date date;
	Double totalSum;
	ArrayList<Product> productList;
	
	Transaction() {
		productListString = "";
		date = new Date(0);
		totalSum = 0.0;
		productList = new ArrayList<Product>();
	}
	
	Transaction(int transaction_id, String productListString, Date date, Double totalSum) {
		this.transaction_id = transaction_id;
		this.productListString = productListString;
		this.date = date;
		this.totalSum = totalSum;
		productList = new ArrayList<Product>();
	}
	
	public void addProduct(Product p) {
		productListString += p.getProduct_id() + ",";
		productList.add(p);
	}

	@Override
	public String toString() {
		return "Transaction [transaction_id=" + transaction_id + ", productList=" + productList + ", date=" + date
				+ ", totalSum=" + totalSum + "]";
	}
	
	
}
