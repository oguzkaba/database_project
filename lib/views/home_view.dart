import 'package:database_project/data/local/providers/local_data_provider.dart';
import 'package:database_project/views/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    LocalDataProvider localDataProvider =
        Provider.of<LocalDataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Test App"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                CustomButton(
                  press: (() async {
                    await localDataProvider.insertData(context);
                  }),
                  text: "Oluştur ve Doldur",
                  width: _size.width,
                  enabled: localDataProvider.localData.isEmpty ? true : false,
                ),
                localDataProvider.localData.isEmpty ||
                        localDataProvider.isGetAllLoading
                    ? SizedBox(
                        height: _size.height - 300,
                        child: Center(
                            child: Text(localDataProvider.isInsertLoading
                                ? "Listelenecek Veri Yok"
                                : "Veriler Eklendi Listelenebilir")),
                      )
                    : SizedBox(
                        height: _size.height - 300,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Text(
                                  localDataProvider.localData[index].value);
                            },
                            separatorBuilder: (context, index) => const Divider(
                              color: Colors.black,
                            ),
                            itemCount: localDataProvider.localData.length,
                          ),
                        ),
                      ),
                CustomButton(
                  press: localDataProvider.getAllData,
                  text: "Tümünü Listele",
                  width: _size.width * .6,
                ),
                CustomButton(
                  press: localDataProvider.getThreeData,
                  text: "ID'si 3 ün Katı Olanları Listele",
                  width: _size.width * .6,
                ),
                CustomButton(
                  press: localDataProvider.clearTable,
                  text: "Boyutu 4 Olanları Listele",
                  width: _size.width * .6,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
