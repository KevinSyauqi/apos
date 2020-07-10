class Sales{
  String _id_sales;
  String _id_outlet;
  String _id_employee;
  int _total_price;
  int _tax;
  String _customer_name;
  bool _is_paid;
  DateTime _date_created;


  Sales(this._id_outlet, this._id_employee, this._total_price, this._tax,
      this._customer_name, this._is_paid);

  String get id_sales => _id_sales;

  String get id_outlet => _id_outlet;

  DateTime get date_created => _date_created;

  set id_outlet(String value) {
    _id_outlet = value;
  }

  String get id_employee => _id_employee;

  bool get is_paid => _is_paid;

  set is_paid(bool value) {
    _is_paid = value;
  }

  String get customer_name => _customer_name;

  set customer_name(String value) {
    _customer_name = value;
  }

  int get tax => _tax;

  set tax(int value) {
    _tax = value;
  }

  int get total_price => _total_price;

  set total_price(int value) {
    _total_price = value;
  }

  set id_employee(String value) {
    _id_employee = value;
  }

  Sales.fromJson(Map<String, dynamic> json) {
    _id_outlet = json["id_outlet"];
    _id_employee = json["id_employee"];
    _id_sales = json["id_sales"];
    _total_price = json["total_price"];
    _tax = json["tax"];
    _customer_name = json["customer_name"];
    _is_paid = json["is_paid"];
    _date_created = DateTime.parse(json["created_at"]);
    print("Masuk from json");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_sales'] = this._id_sales;
    data['id_outlet'] = this._id_outlet;
    data['id_employee'] = this._id_employee;
    data['total_price'] = this._total_price;
    data['tax'] = this._tax;
    data['customer_name'] = this._customer_name;
    data['is_paid'] = this._is_paid;
    data['created_at'] = this._date_created;
    return data;
  }
}

class ListSales{
  List<Sales> listSales;

  ListSales(this.listSales);

  ListSales.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      listSales = new List<Sales>();
      json['data'].forEach((v) {
        listSales.add(new Sales.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listSales != null) {
      data['list_sales'] = this.listSales.map((v) => v.toJson()).toList();
    }
    return data;
  }
}