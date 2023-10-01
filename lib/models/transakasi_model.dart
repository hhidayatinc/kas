class TransaksiModel {
  /*
  tipe
  1 -> pemasukan
  2 -> pengeluaran
  */
  int? id,total;
  String? name, tanggal, type;

  TransaksiModel(
      {this.id,
        this.type,
        this.total,
        this.name,
        this.tanggal});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    map['tanggal'] = tanggal;
    map['total'] = total;
    map['type'] = type;
    map['name'] = name;
    return map;
  }

  TransaksiModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    tanggal = map['tanggal'];
    total = map['total'];
    type = map['type'];
    name = map['name'];
  }
}