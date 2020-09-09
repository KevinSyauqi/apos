class OrderItem{
  String _id_order_item;
  String _id_order;
  String _id_menu;
  String _name_menu;
  int _quantity;
  int _subtotal_price;
  int _subtotal_cost;


  OrderItem(this._id_menu, this._name_menu, this._quantity, this._subtotal_price, this._subtotal_cost);


  String get id_order_item => _id_order_item;

  String get id_order => _id_order;

  String get id_menu => _id_menu;

  int get quantity => _quantity;

  int get subtotal_price => _subtotal_price;

  int get subtotal_cost => _subtotal_cost;

  String get name_menu => _name_menu;

  set quantity(int value) {
    _quantity = value;
  }

  set subtotal_price(int value) {
    _subtotal_price = value;
  }

  set subtotal_cost(int value) {
    _subtotal_cost = value;
  }

  set name_menu(String value) {
    _name_menu = value;
  }

  set id_menu(String value) {
    _id_menu = value;
  }

  OrderItem.fromJson(Map<String, dynamic> json) {
    _id_order_item = json["id_order_item"];
    _id_order = json["id_order"];
    _id_menu = json["id_menu"];
    _name_menu = json["name_menu"];
    _quantity = json["quantity"];
    _subtotal_price = json["subtotal_price"];
    _subtotal_cost = json["subtotal_cost"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_order_item'] = this._id_order_item;
    data['id_order'] = this._id_order;
    data['id_menu'] = this._id_menu;
    data['name_menu'] = this._name_menu;
    data['quantity'] = this._quantity;
    data['subtotal_price'] = this._subtotal_price;
    data['subtotal_cost'] = this._subtotal_cost;
    return data;
  }
}

class ListOrderItem{
  List<OrderItem> listOrderItem;

  ListOrderItem(this.listOrderItem);

  ListOrderItem.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      listOrderItem = new List<OrderItem>();
      json['data'].forEach((v) {
        listOrderItem.add(new OrderItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listOrderItem != null) {
      data['cart'] = this.listOrderItem.map((v) => v.toJson()).toList();
    }
    return data;
  }
}