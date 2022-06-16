class LocalDataModel {
  int? id;
  String value;
  int length;

  LocalDataModel({this.id, required this.value, required this.length});

  Map<String, dynamic> toMap() {
    return {'id': id, 'value': value, 'length': length};
  }

  @override
  String toString() {
    return 'LocalQuestionsModel{id: $id, value: $value, length:$length}';
  }
}
