class Sales{
  String _id_sales;
  String _id_user;
  String _id_payment;
  String _id_order;
  DateTime _date_created;

  Sales(this._id_order);


  String get id_sales => _id_sales;

  String get id_user => _id_user;

  String get id_payment => _id_payment;

  String get id_order => _id_order;

  DateTime get date_created => _date_created;


  Sales.fromJson(Map<String, dynamic> json) {
    _id_sales = json["id_sales"];
    _id_user = json["id_user"];
    _id_order = json["id_order"];
    _id_payment = json["id_payment"];
    _date_created = DateTime.parse(json["created_at"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_sales'] = this._id_sales;
    data['id_user'] = this._id_user;
    data['id_order'] = this._id_order;
    data['id_payment'] = this._id_payment;
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