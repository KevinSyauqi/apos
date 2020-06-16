class Pegawai{
  String _id_outlet;
  String _id_store;
  String _name_outlet;
  String _address_outlet;
  String _phone_outlet;


  Pegawai(this._id_store, this._name_outlet, this._address_outlet);

  String get id_outlet => _id_outlet;

  String get id_store => _id_store;

  String get address_outlet => _address_outlet;

  set address_outlet(String value) {
    _address_outlet = value;
  }

  String get name_outlet => _name_outlet;

  set name_outlet(String value) {
    _name_outlet = value;
  }

  String get phone_outlet => _phone_outlet;

  set phone_outlet(String value) {
    _phone_outlet = value;
  }

  Pegawai.fromJson(Map<String, dynamic> json) {
    _id_outlet = json["id_outlet"];
    _id_store = json['id_store'];
    _name_outlet = json['name_outlet'];
    _address_outlet = json['address_outlet'];
    _phone_outlet = json['phone_outlet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name_outlet'] = this._name_outlet;
    data['address_outlet'] = this._address_outlet;
    data['phone_outlet'] = this._phone_outlet;
  }

}

class ListPegawai {
  List<Pegawai> listPegawai;

  ListPegawai(this.listPegawai);

  ListPegawai.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      listPegawai = new List<Pegawai>();
      json['data'].forEach((v) {
        listPegawai.add(new Pegawai.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listPegawai != null) {
      data['outlets'] = this.listPegawai.map((v) => v.toJson()).toList();
    }
    return data;
  }
}