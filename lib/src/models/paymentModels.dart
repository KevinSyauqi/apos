class Payment{
  String _id_payment;
  int _cash;
  int _change_amount;
  DateTime _date;


  Payment(this._cash, this._change_amount);


  String get id_payment => _id_payment;

  int get cash => _cash;

  int get change_amount => _change_amount;

  DateTime get date => _date;

  Payment.fromJson(Map<String, dynamic> json) {
    _id_payment = json["id_payment"];
    _cash = json["cash"];
    _change_amount = json["change_amount"];
    _date = DateTime.parse(json["created_at"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_payment'] = this._id_payment;
    data['cash'] = this._cash;
    data['change_amount'] = this._change_amount;
    data['created_at'] = this._date;
    return data;
  }

}