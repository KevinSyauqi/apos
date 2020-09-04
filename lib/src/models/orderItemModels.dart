class OrderItem{
  String _id_order_item;
  String _id_order;
  String _name_menu;
  int _quantity;
  int _subtotal_price;


  OrderItem(this._name_menu, this._quantity, this._subtotal_price);


  String get id_order_item => _id_order_item;

  String get id_order => _id_order;

  String get id_menu => _name_menu;

  int get quantity => _quantity;

  int get subtotal_price => _subtotal_price;

  String get name_menu => _name_menu;

  set quantity(int value) {
    _quantity = value;
  }

  set subtotal_price(int value) {
    _subtotal_price = value;
  }

  set name_menu(String value) {
    _name_menu = value;
  }

  OrderItem.fromJson(Map<String, dynamic> json) {
    _id_order_item = json["id_order_item"];
    _id_order = json["id_order"];
    _name_menu = json["name_menu"];
    _quantity = json["quantity"];
    _subtotal_price = json["subtotal_price"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_order_item'] = this._id_order_item;
    data['id_order'] = this._id_order;
    data['name_menu'] = this._name_menu;
    data['quantity'] = this._quantity;
    data['subtotal_price'] = this._subtotal_price;
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
      data['list_order_item'] = this.listOrderItem.map((v) => v.toJson()).toList();
    }
    return data;
  }
}