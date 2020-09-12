class Report{
  String _id_menu;
  String _name_menu;
  int _quantity;
  int _income;
  int _profit;


  String get id_menu => _id_menu;

  String get name_menu => _name_menu;

  int get quantity => _quantity;

  int get income => _income;

  int get profit => _profit;

  Report.fromJson(Map<String, dynamic> json) {
    _id_menu = json["id_menu"];
    _name_menu = json["name_menu"];
    _quantity = json["quantity"];
    _income = json["income"];
    _profit = json["profit"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_menu'] = this._id_menu;
    data['name_menu'] = this._name_menu;
    data['quantity'] = this._quantity;
    data['income'] = this._income;
    data['profit'] = this._profit;
    return data;
  }
}

class ListReport{
  List<Report> listReport;

  ListReport(this.listReport);

  ListReport.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      listReport = new List<Report>();
      json['data'].forEach((v) {
        listReport.add(new Report.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listReport != null) {
      data['list_report'] = this.listReport.map((v) => v.toJson()).toList();
    }
    return data;
  }
}