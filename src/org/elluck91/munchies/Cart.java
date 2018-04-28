package org.elluck91.munchies;

import java.util.ArrayList;

public class Cart {
	ArrayList<Product> productList;
	
	public Cart() {
		productList = new ArrayList<Product>();
	}
	
	public ArrayList<Product> getProductList() {
		return productList;
	}

	public void setProductList(ArrayList<Product> productList) {
		this.productList = productList;
	}

	public boolean contains(int product_id) {
		boolean contains = false;
		for (int i = 0; i < productList.size(); i++) {
			if (productList.get(i).getProduct_id() == product_id) {
				contains = true;
				break;
			}
		}
		
		return contains;
	}
	
	public void addProductToCart(Product product, String count) {
		if (product == null) {
			System.out.println("Product is null.");
		}
		
		else if (count == null) {
			System.out.println("Count is null");
		}
		int product_id = product.getProduct_id();
		for (int i = 0; i < productList.size(); i++) {
			if (productList.get(i).getProduct_id() == product_id) {
				System.out.println("Product count incremented by " + count);
				productList.get(i).setProduct_quantity(productList.get(i).getProduct_quantity() + Integer.parseInt(count));;
				return;
			}
		}
		System.out.println("New product added to the cart, quantity: " + count);
		productList.add(product);
	}
	
	public void removeProductFromCart(String product_id) {

		Integer prod_id = Integer.parseInt(product_id);
		for (int i = 0; i < productList.size(); i++) {
			if (productList.get(i).getProduct_id() == prod_id) {
				productList.remove(i);
				return;
			}
		}
	}
	
	public String toString() {
		String str = "";
		str += "Items in the cart: " + productList.size() + "\n";
		for (int i = 0; i < productList.size(); i++)
			str += productList.get(i).toString() + "\n";
		
		return str;
		
		
	}
	
	
}
