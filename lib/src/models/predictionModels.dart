class Prediction{
  DateTime _start_periode_date;
  DateTime _end_periode_date;
  int _periode;
  String _id_menu;
  String _name_menu;
  int _income;
  int _profit;
  double _mape;
  int _wma;


  DateTime get start_periode_date => _start_periode_date;

  DateTime get end_periode_date => _end_periode_date;

  int get periode => _periode;

  String get id_menu => _id_menu;

  int get income => _income;

  int get profit => _profit;

  double get mape => _mape;

  int get wma => _wma;

  String get name_menu => _name_menu;

  Prediction.fromJson(Map<String, dynamic> json) {
    _start_periode_date = json["start_periode_date"];
    _end_periode_date = json['end_periode_date'];
    _id_menu = (json['id_menu']);
    _mape = double.parse(json['mape']);
    _wma = int.parse(json['wma']);
    _periode = json['periode'];
    _name_menu = json['name_menu'];
    _income = int.parse(json['income']);
    _profit = int.parse(json['profit']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_periode_date'] = this._start_periode_date;
    data['end_periode_date'] = this._end_periode_date;
    data['id_menu'] = this._id_menu;
    data['name_menu'] = this._name_menu;
    data['periode'] = this._periode;
    data['mape'] = this._mape;
    data['wma'] = this._wma;
    data['income'] = this._income;
    data['profit'] = this._profit;
    return data;
  }
}

class ListPrediction{
  List<Prediction> listPredictions;

  ListPrediction(this.listPredictions);

  ListPrediction.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      listPredictions = new List<Prediction>();
      json['data'].forEach((v) {
        listPredictions.add(new Prediction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listPredictions != null) {
      data['listPredictionSales'] = this.listPredictions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}