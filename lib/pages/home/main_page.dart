import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shamo/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  late Future<String> name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = _prefs.then((SharedPreferences prefs) {
      print(prefs.getString('name'));
      return prefs.getString('name') ?? "World";
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget cartButton() {
      return FloatingActionButton(
        backgroundColor: secondaryColor,
        onPressed: () {},
        child: Image.asset(
          "assets/ic_cart.png",
          width: 20,
        ),
      );
    }

    Widget header() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultMargin, left: defaultMargin, right: defaultMargin),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<String>(
                      future: name,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return const CircularProgressIndicator();
                          default:
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return Text(
                                "Halo, ${snapshot.data}",
                                style: primaryTextStyle.copyWith(fontSize: 24),
                              );
                            }
                        }
                      }),
                ],
              ),
            ),
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: AssetImage("assets/ic_user.png"))),
            )
          ],
        ),
      );
    }

    Widget categories() {
      return Container(
        margin: EdgeInsets.only(top: defaultMargin),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: defaultMargin),
              Container(
                margin: EdgeInsets.only(right: 16),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: primaryColor),
                child: Text(
                  "All Shoes",
                  style: primaryTextStyle.copyWith(
                      fontSize: 13, fontWeight: medium),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 16),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: subtitleTextColor),
                    borderRadius: BorderRadius.circular(12),
                    color: transparentColor),
                child: Text(
                  "Running",
                  style: subtitleTextStyle.copyWith(
                      fontSize: 13, fontWeight: medium),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 16),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: subtitleTextColor),
                    borderRadius: BorderRadius.circular(12),
                    color: transparentColor),
                child: Text(
                  "Hikking",
                  style: subtitleTextStyle.copyWith(
                      fontSize: 13, fontWeight: medium),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 16),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: subtitleTextColor),
                    borderRadius: BorderRadius.circular(12),
                    color: transparentColor),
                child: Text(
                  "Basket Ball",
                  style: subtitleTextStyle.copyWith(
                      fontSize: 13, fontWeight: medium),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget item() {
      return Container(
        padding: EdgeInsets.only(top: 16),
        child: GridView.builder(
          primary: false,
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            crossAxisCount: 2,
          ),
          itemCount: 7,
          itemBuilder: (_, int index) => Card(
              margin: EdgeInsets.only(left: 10, right: 10, top: 12),
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                height: 180,
                child: Stack(children: [
                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/image_shoes.png",
                                fit: BoxFit.fitHeight,
                              ),
                            ],
                          ))),
                  Positioned(
                      bottom: 8,
                      left: 0,
                      right: 0,
                      child: Container(
                        child: Column(
                          children: [
                            Text("Nike Air Max 2021",
                                style: TextStyle(
                                    fontWeight: medium,
                                    fontSize: 13,
                                    color: backgroundColor1),
                                textAlign: TextAlign.center),
                          ],
                        ),
                      )),
                ]),
              )),
        ),
      );
    }

    Widget drawer() {
      return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff1F1D2B),
              ),
              child: Center(
                  child: Text(
                'Halo!',
                style: TextStyle(color: Color(0xffF1F0F2)),
              )),
            ),
            ListTile(
              style: ListTileStyle.list,
              title: const Text('Mahasiswa'),
              onTap: () {
                Navigator.pushNamed(context, '/mahasiswa');
              },
            ),
            ListTile(
              title: const Text('Dosen'),
              onTap: () {
                Navigator.pushNamed(context, '/dosen');
              },
            ),
            ListTile(
              title: const Text('Tambah Mahasiswa'),
              onTap: () {
                Navigator.pushNamed(context, '/mahasiswa_form');
              },
            ),
            ListTile(
              title: const Text('Tambah Dosen'),
              onTap: () {
                Navigator.pushNamed(context, '/dosen_form');
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
        key: _key,
        drawer: drawer(),
        backgroundColor: backgroundColor1,
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(left: defaultMargin, top: defaultMargin),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      _key.currentState?.openDrawer();
                    },
                    child: AnimatedContainer(
                        height: 45,
                        width: 45,
                        padding: EdgeInsets.all(5),
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade300)),
                        child: Center(
                            child: Image.asset(
                          "assets/ic_hamburger.png",
                          width: 24,
                          height: 24,
                        ))),
                  ),
                ],
              ),
            ),
            header(),
          ],
        ));
  }
}
