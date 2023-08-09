class ProductModel {
  String image = '';
  String name = '';
  String description = '';
  String category = '';
  String brand = '';
  String connectionType = '';
  String stringprice = '';
  String stringdiscount = '';
  String stringquantity = '';
  int? price = 0;
  int? discount = 0;
  int? quantity = 0;

 Map<String, dynamic> tomap() {
    return {
      'image': image,
      'name': name,
      'description': description,
      'category': category,
      'brand': brand,
      'connectionType': connectionType,
      'price': price,
      'discount': discount,
      'quantity': quantity,
    };
  }

  
}