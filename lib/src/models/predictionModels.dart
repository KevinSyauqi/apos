class Prediction{
  DateTime _start_periode_date;
  DateTime _end_periode_date;
  int _periode;
  String _id_outlet_menu;
  String _name_menu;
  double _mape;
  double _wma;

  Prediction(this._start_periode_date, this._end_periode_date, this._mape,
      this._wma);

  double get wma => _wma;

  set wma(double value) {
    _wma = value;
  }

  double get mape => _mape;

  set mape(double value) {
    _mape = value;
  }

  DateTime get end_periode_date => _end_periode_date;

  set end_periode_date(DateTime value) {
    _end_periode_date = value;
  }

  DateTime get start_periode_date => _start_periode_date;

  set start_periode_date(DateTime value) {
    _start_periode_date = value;
  }


  int get periode => _periode;

  set periode(int value) {
    _periode = value;
  }

  Prediction.fromJson(Map<String, dynamic> json) {
    _start_periode_date = json["start_periode_date"];
    _end_periode_date = json['end_periode_date'];
    _mape = double.parse(json['mape']);
    _wma = double.parse(json['wma']);
//    _periode = int.parse(json['periode']);
    _name_menu = json['name_menu'];
    _id_outlet_menu = json['id_outlet_menu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_periode_date'] = this._start_periode_date;
    data['end_periode_date'] = this._end_periode_date;
    data['id_outlet_menu'] = this._id_outlet_menu;
    data['name_menu'] = this._name_menu;
    data['periode'] = this._periode;
    data['mape'] = this._mape;
    data['wma'] = this._wma;
    return data;
  }

  String get id_outlet_menu => _id_outlet_menu;

  set id_outlet_menu(String value) {
    _id_outlet_menu = value;
  }

  String get name_menu => _name_menu;

  set name_menu(String value) {
    _name_menu = value;
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
      data['predictions'] = this.listPredictions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}