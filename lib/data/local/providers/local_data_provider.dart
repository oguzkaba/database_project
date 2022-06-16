import 'package:database_project/data/local/models/local_data_model.dart';
import 'package:database_project/data/local/services/local_data_services.dart';
import 'package:flutter/material.dart';

class LocalDataProvider extends ChangeNotifier {
  List<LocalDataModel> localData = <LocalDataModel>[];
  bool isGetAllLoading = true;
  bool isInsertLoading = true;
  bool buttonEnabled = true;

  //All Data Getter method
  Future<void> getAllData() async {
    localData.clear();
    try {
      isGetAllLoading = true;
      await LocalDataServices.instance.queryAllRows().then((value) {
        for (var element in value) {
          localData.add(LocalDataModel(
              id: element['id'],
              value: element['value'],
              length: element['length']));
        }
      });
    } finally {
      isGetAllLoading = false;
    }
    notifyListeners();
  }

  //ID's 3-69...  Getter method
  Future<void> getThreeData() async {
    localData.clear();
    try {
      isGetAllLoading = true;
      await LocalDataServices.instance.queryAllRows().then((value) {
        for (var element in value) {
          if (element['id'] % 3 == 0) {
            localData.add(LocalDataModel(
                id: element['id'],
                value: element['value'],
                length: element['length']));
          }
        }
      });
    } finally {
      isGetAllLoading = false;
    }
    notifyListeners();
  }

//Length 4...  Getter method
  Future<void> getLengthFourData() async {
    localData.clear();
    try {
      isGetAllLoading = true;
      await LocalDataServices.instance.queryAllRows().then((value) {
        for (var element in value) {
          if (element['length'] == 4) {
            localData.add(LocalDataModel(
                id: element['id'],
                value: element['value'],
                length: element['length']));
          }
        }
      });
    } finally {
      isGetAllLoading = false;
    }
    notifyListeners();
  }

  //Insert sqflite method
  Future<void> insertData(BuildContext context) async {
    isGetAllLoading = true;
    localData.clear();
    valueGenerate();
    try {
      isInsertLoading = true;
      for (var i = 0; i < localData.length; i++) {
        await LocalDataServices.instance.insert(localData[i]);
      }
    } finally {
      isInsertLoading = false;
      buttonEnabled = true;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Veriler Eklendi"),
        backgroundColor: Colors.greenAccent,
      ));
    }
    notifyListeners();
  }

  void valueGenerate() {
    //alphabet list
    List<String> alph = [];
    int c = "a".codeUnitAt(0);
    int end = "z".codeUnitAt(0);
    while (c <= end) {
      alph.add(String.fromCharCode(c));
      c++;
    }

    //a-aa-aaa-... list
    //List<String> value = [];
    for (var i = 0; i < alph.length; i++) {
      for (var j = 1; j < 6; j++) {
        //value.add(alph[i] * j);
        //model genarete
        localData.add(LocalDataModel(value: alph[i] * j, length: j));
      }
    }
  }

  //Delete Table---debugTest
  Future<void> clearTable() async {
    try {
      LocalDataServices.instance.clearTable();
      localData.clear();
      isInsertLoading = true;
    } finally {
      print("tablo temizlendi");
    }
    notifyListeners();
  }
}
