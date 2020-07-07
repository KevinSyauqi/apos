class Pegawai {
  String _id_employee;
  String _id_outlet;
  String _id_user;
  String _name_user;
  String _role;
  String _status;


  Pegawai(this._id_outlet,
      this._name_user, this._role);


  String get id_employee => _id_employee;

  String get id_outlet => _id_outlet;

  set id_outlet(String value) {
    _id_outlet = value;
  }

  String get id_user => _id_user;

  String get name_user => _name_user;

  set name_user(String value) {
    _name_user = value;
  }

  String get role => _role;

  set role(String value) {
    _role = value;
  }

  String get status => _status;

  set status(String value) {
    _status = value;
  }

  Pegawai.fromJson(Map<String, dynamic> json) {
    _id_employee = json["id_employee"];
    _id_outlet = json["id_outlet"];
    _id_user = json["id_user"];
    _name_user = json["name_employee"];
    _role = json["role"];
    _status = json["status"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_employee'] = this._id_employee;
    data['id_outlet'] = this._id_outlet;
    data['id_user'] = this._id_user;
    data['name_employee'] = this._name_user;
    data['role'] = this._role;
    data['status'] = this._status;
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