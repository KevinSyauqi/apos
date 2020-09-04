class Sales{
  String _id_sales;
  String _id_user;
  String _id_order;
  String _id_payment;
  int _cash;
  int _change_amount;
  DateTime _date_created;

  Sales(this._id_order, this._id_user, this._cash, this._change_amount);


  String get id_sales => _id_sales;

  String get id_user => _id_user;

  String get id_order => _id_order;

  String get id_payment => _id_payment;

  int get cash => _cash;

  int get change_amount => _change_amount;

  DateTime get date_created => _date_created;


  set id_user(String value) {
    _id_user = value;
  }

  Sales.fromJson(Map<String, dynamic> json) {
    _id_sales = json["id_sales"];
    _id_user = json["id_user"];
    _id_order = json["id_order"];
    _id_payment = json["id_payment"];
    _cash = json["cash"];
    _change_amount = json["change_amount"];
    _date_created = DateTime.parse(json["created_at"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_sales'] = this._id_sales;
    data['id_user'] = this._id_user;
    data['id_order'] = this._id_order;
    data['id_payment'] = this._id_payment;
    data['cash'] = this._cash;
    data['change_amount'] = this._change_amount;
    data['created_at'] = this._date_created;
    return data;
  }

  set id_order(String value) {
    _id_order = value;
  }

  set cash(int value) {
    _cash = value;
  }

  set change_amount(int value) {
    _change_amount = value;
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