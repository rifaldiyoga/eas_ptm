import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shamo/api/api_service.dart';
import 'package:shamo/constants.dart';
import 'package:shamo/models/dosen.dart';
import 'package:shamo/models/mahasiswa.dart';
import 'package:shamo/pages/dosen/form_dosen.dart';
import 'package:shamo/pages/mahasiswa/form_mahasiswa.dart';
import 'package:shamo/theme.dart';

class DosenPage extends StatefulWidget {
  const DosenPage({Key? key}) : super(key: key);

  @override
  State<DosenPage> createState() => _DosenPageState();
}

class _DosenPageState extends State<DosenPage> {
  late ApiService _apiService;
  late Future<List<Mahasiswa>?> mahasiswaList;
  var searchController = TextEditingController();

  _getRequests() async {
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiService = ApiService();
    searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultMargin, left: defaultMargin, right: defaultMargin),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                "assets/ic_back.png",
                height: 20,
                width: 20,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "List Dosen",
                    style: primaryTextStyle.copyWith(fontSize: 24),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget search() {
      return Container(
        padding: EdgeInsets.all(defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  color: backgroundColor2,
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Row(
                  children: [
                    Image.asset(
                      "assets/ic_search.png",
                      width: 20,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: TextFormField(
                      controller: searchController,
                      style: primaryTextStyle,
                      decoration: InputDecoration.collapsed(
                          hintText: "Search", hintStyle: subtitleTextStyle),
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget itemList(var dosenModel) {
      var isMyFav = true;
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DosenFormPage(dosen: dosenModel),
            ),
          ).then((value) => value ? _getRequests() : null);
        },
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 0,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ]),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(children: [
                      Container(
                          width: 60,
                          height: 60,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: "${Constant.url}/${dosenModel.foto}",
                              placeholder: (context, url) => Image.network(url),
                              errorWidget: (context, url, error) =>
                                  Image.asset("assets/ic_user.png"),
                            ),
                          )),
                      SizedBox(width: 10),
                      Flexible(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(dosenModel.nama,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(dosenModel.telp,
                                  style: TextStyle(color: Colors.grey[500])),
                              SizedBox(
                                height: 5,
                              ),
                              Text("${dosenModel.prodi} ${dosenModel.fakultas}",
                                  style: TextStyle(color: Colors.grey[500])),
                            ]),
                      )
                    ]),
                  ),
                  GestureDetector(
                    onTap: () {
                      _apiService.deleteDosen(dosenModel.id);
                      setState(() {});
                    },
                    child: AnimatedContainer(
                        height: 35,
                        padding: EdgeInsets.all(5),
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isMyFav
                                  ? Colors.grey.shade300
                                  : Colors.grey.shade300,
                            )),
                        child: Center(
                            child: Icon(
                          Icons.delete,
                          color: Colors.grey.shade400,
                        ))),
                  )
                ],
              ),
            ],
          ),
        ),
      );
    }

    Widget item() {
      return Container(
        padding: EdgeInsets.only(left: defaultMargin, right: defaultMargin),
        child: FutureBuilder<List<Dosen>>(
            future: _apiService.getDosens(searchController.text),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                return Container(
                  child: Column(
                    children: [
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount:
                              snapshot.data != null ? snapshot.data!.length : 0,
                          itemBuilder: (context, index) {
                            return itemList(snapshot.data![index]);
                          }),
                    ],
                  ),
                );
                // return Text("data");
              }
              if (snapshot.connectionState == ConnectionState.none) {
                return Center(
                  child: Text(
                    "Kosong",
                    style: primaryTextStyle,
                  ),
                );
              }
              return Text("kosong");
            }),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor1,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DosenFormPage(),
            ),
          ).then((value) => value ? _getRequests() : null);
        },
        child: Image.asset(
          "assets/ic_plus.png",
          width: 24,
          height: 24,
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [header(), search(), item()],
      ),
    );
  }
}
