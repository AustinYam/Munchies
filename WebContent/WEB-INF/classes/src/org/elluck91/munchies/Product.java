package org.elluck91.munchies;

public class Product {
	String product_uniquename;
	String product_name;
	double product_price;
	String product_description;
	String product_img;
	String product_category;
	int product_id;
	int product_quantity;
	
	public int getProduct_quantity() {
		return product_quantity;
	}

	public void setProduct_quantity(int product_quantity) {
		this.product_quantity = product_quantity;
	}

	public Product() {
		
	}

	public Product(String product_uniquename, String product_name, double product_price, String product_description,
			String product_img, String product_category, int product_id) {
		super();
		this.product_uniquename = product_uniquename;
		this.product_name = product_name;
		this.product_price = product_price;
		this.product_description = product_description;
		this.product_img = product_img;
		this.product_category = product_category;
		this.product_id = product_id;
		
	}

	public String getProduct_uniquename() {
		return product_uniquename;
	}

	public void setProduct_uniquename(String product_uniquename) {
		this.product_uniquename = product_uniquename;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public double getProduct_price() {
		return product_price;
	}

	public void setProduct_price(double product_price) {
		this.product_price = product_price;
	}

	public String getProduct_description() {
		return product_description;
	}

	public void setProduct_description(String product_description) {
		this.product_description = product_description;
	}

	public String getProduct_img() {
		return product_img;
	}

	public void setProduct_img(String product_img) {
		this.product_img = product_img;
	}

	public String getProduct_category() {
		return product_category;
	}

	public void setProduct_category(String product_category) {
		this.product_category = product_category;
	}

	public int getProduct_id() {
		return product_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	@Override
	public String toString() {
		return "Product [product_uniquename=" + product_uniquename + ", product_name=" + product_name
				+ ", product_price=" + product_price + ", product_description=" + product_description + ", product_img="
				+ product_img + ", product_category=" + product_category + ", product_id=" + product_id
				+ ", product_quantity=" + product_quantity + "]";
	}

	
}
