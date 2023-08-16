class ProductModel {
  List images = [];
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
      'image': images,
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

  ProductModel fromMap({required Map productFromMap}) {
    ProductModel productModel = ProductModel();
    productModel.images = productFromMap['image'];
    productModel.name = productFromMap['name'];
    productModel.description = productFromMap['description'];
    productModel.category = productFromMap['category'];
    productModel.brand = productFromMap['brand'];
    productModel.connectionType = productFromMap['connectionType'];
    productModel.price = productFromMap['price'];
    productModel.discount = productFromMap['discount'];
    productModel.quantity = productFromMap['quantity'];

    return productModel;
  }
}
