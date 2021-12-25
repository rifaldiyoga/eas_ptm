import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shamo/api/api_service.dart';
import 'package:shamo/constants.dart';
import 'package:shamo/models/dosen.dart';
import 'package:shamo/theme.dart';
import 'package:shamo/widget/custom_wiget.dart';

class DosenFormPage extends StatefulWidget {
  const DosenFormPage({Key? key, this.dosen}) : super(key: key);

  final Dosen? dosen;

  @override
  State<DosenFormPage> createState() => _DosenFormPageState();
}

class _DosenFormPageState extends State<DosenFormPage> {
  var _nbiController = TextEditingController();
  var _nameController = TextEditingController();
  var _phoneController = TextEditingController();
  var _addresController = TextEditingController();
  var _emailController = TextEditingController();
  var _birthController = TextEditingController();
  var _prodiController = TextEditingController();
  var _fakultasController = TextEditingController();
  var _fotoController = TextEditingController();

  late ApiService _apiService;
  XFile? _image;

  final ImagePicker _picker = ImagePicker();

  String fakultas = "FISIP";

  String prodi = "Ilmu Komunikasi";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiService = ApiService();

    print("Dosen : ${widget.dosen}");
    if (widget.dosen != null) {
      var model = widget.dosen;
      _nbiController.text = model!.kode_dosen;
      _nameController.text = model.nama;
      _phoneController.text = model.telp;
      _addresController.text = model.alamat;
      _emailController.text = model.email;
      _birthController.text = model.tgl_lahir;
      fakultas = model.fakultas;
      prodi = model.prodi;
      _fotoController.text = model.foto;
    }
  }

  @override
  Widget build(BuildContext context) {
    _imgFromCamera() async {
      XFile? image =
          await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);

      setState(() {
        _image = image;
        if (image != null) {
          _fotoController.text = image.name;
        }
      });
    }

    _imgFromGallery() async {
      XFile? image = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 50);

      setState(() {
        _image = image;
        if (image != null) {
          _fotoController.text = image.name;
        }
      });
    }

    void _showPicker(context) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return SafeArea(
              child: Container(
                child: new Wrap(
                  children: <Widget>[
                    new ListTile(
                        leading: new Icon(Icons.photo_library),
                        title: new Text('Photo Library'),
                        onTap: () {
                          _imgFromGallery();
                          Navigator.of(context).pop();
                        }),
                    new ListTile(
                      leading: new Icon(Icons.photo_camera),
                      title: new Text('Camera'),
                      onTap: () {
                        _imgFromCamera();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            );
          });
    }

    Widget header() {
      return Container(
        margin: EdgeInsets.only(top: defaultMargin),
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
            Column(
              children: [
                Text(
                  "Form Dosen",
                  style: primaryTextStyle.copyWith(
                      fontSize: 24, fontWeight: semiBold),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget inputFoto() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Choose Image",
              style:
                  primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  color: backgroundColor2,
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                        child: TextButton(
                      child: Text(
                        "Choose Image",
                        style: primaryTextStyle,
                      ),
                      onPressed: () {
                        _showPicker(context);
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                    )),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: TextFormField(
                      enabled: false,
                      controller: _fotoController,
                      style: primaryTextStyle,
                      decoration: InputDecoration.collapsed(
                          hintText: "Your Image", hintStyle: subtitleTextStyle),
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget signUpButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(top: defaultMargin),
        child: TextButton(
            onPressed: () {
              Dosen dosen = Dosen(
                id: 1,
                kode_dosen: _nbiController.text,
                nama: _nameController.text,
                telp: _phoneController.text,
                alamat: _addresController.text,
                tgl_lahir: _birthController.text,
                email: _emailController.text,
                prodi: prodi,
                fakultas: fakultas,
                foto: _fotoController.text,
              );

              if (widget.dosen != null) {
                _apiService
                    .updateDosen(dosen, widget.dosen!.id, _image)
                    .then((value) {
                  Navigator.pop(context, true);
                });
              } else {
                print(_image);
                if (_image != null) {
                  _apiService.createDosen(dosen, _image!).then((value) {
                    Navigator.pop(context, true);
                  });
                }
              }
            },
            style: TextButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
            child: Text(
              "Submit",
              style:
                  primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
            )),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor1,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              children: [
                header(),
                input("Kode Dosen", "ic_profile_active.png", _nbiController),
                input("Name", "ic_profile_active.png", _nameController),
                input("Phone", "ic_profile_active.png", _phoneController),
                input("Address", "ic_profile_active.png", _addresController),
                input("Email", "ic_profile_active.png", _emailController),
                input("Birth Date", "ic_profile_active.png", _birthController),
                inputDropdown('Fakultas', Constant.fakultasList, fakultas,
                    (data) {
                  setState(() {
                    this.fakultas = data!;
                    this.prodi = Constant.prodiList[fakultas]![0];
                  });
                }),
                inputDropdown('Prodi', Constant.prodiList[fakultas]!, prodi,
                    (data) {
                  setState(() {
                    this.prodi = data!;
                  });
                }),
                inputFoto(),
                signUpButton(),
                SizedBox(height: defaultMargin)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
