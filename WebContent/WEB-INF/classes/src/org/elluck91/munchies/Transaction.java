package org.elluck91.munchies;

import java.sql.Date;
import java.util.ArrayList;

public class Transaction {
	ArrayList<Product> productList;
	Date date;
	Double totalSum;
	
	Transaction() {
		productList = new ArrayList<Product>();
		date = new Date(0);
		totalSum = 0.0;
	}
	
	public void addProduct(Product p) {
		productList.add(p);
	}
}
