class SalesLineItem{
  String _id_sales_line;
  String _id_outlet_menu;
  int _qty;
  int _subtotal_price;
  int _discount;

  SalesLineItem(this._id_outlet_menu,this._qty, this._subtotal_price, this._discount);


  String get id_sales_line => _id_sales_line;

  String get id_outlet_menu => _id_outlet_menu;

  set id_outlet_menu(String value) {
    _id_outlet_menu = value;
  }

  int get discount => _discount;

  set discount(int value) {
    _discount = value;
  }

  int get subtotal_price => _subtotal_price;

  set subtotal_price(int value) {
    _subtotal_price = value;
  }

  int get qty => _qty;

  set qty(int value) {
    _qty = value;
  }

  SalesLineItem.fromJson(Map<String, dynamic> json) {
    _id_sales_line = json["id_sales_line"];
    _id_outlet_menu = json["id_outlet_menu"];
    _qty = json["qty"];
    _subtotal_price = json["subtotal_price"];
    _discount = json["discount"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_outlet_menu'] = this._id_outlet_menu;
    data['qty'] = this._qty;
    data['subtotal_price'] = this._subtotal_price;
    data['discount'] = this._discount;
    return data;
  }

}

class ListOrder{
  List<SalesLineItem> listOrder;

  ListOrder(this.listOrder);

  ListOrder.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      listOrder = new List<SalesLineItem>();
      json['data'].forEach((v) {
        listOrder.add(new SalesLineItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listOrder != null) {
      data['listOrder'] = this.listOrder.map((v) => v.toJson()).toList();
    }
    return data;
  }


}