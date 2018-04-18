package org.elluck91.munchies;

public class Product {
	String name;
	String uniqueName;
	double price;
	String description;
	String imgUrl;
	
	Product() {
		name = "Product Name";
		uniqueName = "Unique Product Name";
		price = 10.99;
		description = "Default product description.";
		imgUrl = "WebContent/foodimg/baking/baking.jpeg";
	}
	
	public String toString() {
		String str = "Name: " + name + " | Unique Name: " + uniqueName+ " | Price: " + price
				+ " | Description: " + description + " | imgUrl: " + imgUrl;
		return str;
	}
	
	public String getName(){
		return this.name;
	}
	
	public String getUniqueName(){
		return this.uniqueName;
	}
	
	public double getPrice(){
		return this.price;
	}
	
	public String getDescription(){
		return this.description;
	}
	
	public String getImgUrl(){
		return this.imgUrl;
	}
	
}
