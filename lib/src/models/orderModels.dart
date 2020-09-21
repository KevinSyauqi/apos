class Order{
  String _id_order;
  String _id_user;
  int _table_number;
  String _customer_name;
  int _total_price;
  bool _is_paid;
  DateTime _date;


  Order(this._id_user, this._table_number, this._customer_name,
      this._total_price);

  String get id_order => _id_order;

  String get id_user => _id_user;

  int get table_number => _table_number;

  String get customer_name => _customer_name;

  int get total_price => _total_price;

  bool get is_paid => _is_paid;

  DateTime get date => _date;


  set id_user(String value) {
    _id_user = value;
  }

  set table_number(int value) {
    _table_number = value;
  }

  set customer_name(String value) {
    _customer_name = value;
  }

  set total_price(int value) {
    _total_price = value;
  }

  set id_order(String value) {
    _id_order = value;
  }

  Order.fromJson(Map<String, dynamic> json) {
    _id_order = json["id_order"];
    _id_user = json["id_user"];
    _table_number = json["table_number"];
    _total_price = json["total_price"];
    _customer_name = json["customer_name"];
    _is_paid = json["is_paid"];
    _date = DateTime.parse(json["created_at"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_order'] = this._id_order;
    data['id_user'] = this._id_user;
    data['table_number'] = this._table_number;
    data['customer_name'] = this._customer_name;
    data['total_price'] = this._total_price;
    data['is_paid'] = this._is_paid;
    if(this.date != null) data['created_at'] = this._date.toString();
    return data;
  }
}

class ListOrder{
  List<Order> listOrder;

  ListOrder(this.listOrder);

  ListOrder.fromJson(Map<String, dynamic> json) {
    print("Masuk");
    print(json);
    if (json['data'] != null) {
      listOrder = new List<Order>();
      json['data'].forEach((v) {
        listOrder.add(new Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listOrder != null) {
      data['list_order'] = this.listOrder.map((v) => v.toJson()).toList();
    }
    return data;
  }
}