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

	public String getProductList() {
		return productList;
	}

	public void setProductList(String productList) {
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
	String productList;
	Date date;
	Double totalSum;
	
	Transaction() {
		productList = "";
		date = new Date(0);
		totalSum = 0.0;
	}
	
	Transaction(int transaction_id, String productList, Date date, Double totalSum) {
		this.transaction_id = transaction_id;
		this.productList = productList;
		this.date = date;
		this.totalSum = totalSum;
	}
	
	public void addProduct(Product p) {
		productList += "," + p;
	}

	@Override
	public String toString() {
		return "Transaction [transaction_id=" + transaction_id + ", productList=" + productList + ", date=" + date
				+ ", totalSum=" + totalSum + "]";
	}
	
	
}
