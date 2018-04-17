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
}
