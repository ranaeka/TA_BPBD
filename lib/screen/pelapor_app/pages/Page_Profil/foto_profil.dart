import 'dart:io';

import 'package:bpbd/api_service/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';

class FotoProfilView extends StatefulWidget {
  // static var routeName;

  @override
  _FotoProfilViewState createState() => _FotoProfilViewState();
}

class _FotoProfilViewState extends State<FotoProfilView> {
  File _image;
  final picker = ImagePicker();

    String email = '';
  String password = '';
  String nama ='';
  String alamat ='';
  String nohp ='';

  // bool _isHidePassword = true;

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _nama = TextEditingController();
  TextEditingController _alamat = TextEditingController();
  TextEditingController _noHp = TextEditingController();

    Future<bool>register()async{
    Dio dio= new Dio();
    ProgressDialog pg = new ProgressDialog(context, message: Text('loading'));
    pg.show();
    print(_email.text);
    var formdata = FormData.fromMap({
      "foto": await MultipartFile.fromFile(_image.path,filename: _image.path.split('/').last),
      "email": "${_email.text}",
      "password": "${_password.text}",
      "nama": "${_nama.text}",
      "alamat": "${_alamat.text}",
      "no_hp": "${_noHp.text}"
    });

    Response response;
    response = await dio.post(ApiServer.register,data: formdata);

    if(response.statusCode==200){
      pg.dismiss();
      print(response.data);
      if(response.data['code']==200){
        Navigator.pop(context);
      }
    } 
    return true;
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _image.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      setState(() {
        _image = croppedFile;
      });
    }
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
      _cropImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text('Edit Profil')),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          child: Stack(children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 130, left: 50, right: 50),
            child:Center(
              child:Text(
                "Silahkan Pilih Foto Untuk di Jadikan Foto Profil",
                style: GoogleFonts.portLligatSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.only(top: 170, left: 100, right: 50),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Row(children: <Widget>[
                    Stack(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 105,
                          backgroundColor: Colors.orange[800],
                          child: ClipOval(
                            child: SizedBox(
                              width: 200.0,
                              height: 200.0,
                              child: _image == null
                                  ? Icon(Icons.camera_alt, size: 100)
                                  : Image.file(
                                      _image,
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                        Positioned(
                        bottom: 15,
                        child:
                        FloatingActionButton(
                          mini: true,
                          backgroundColor: Colors.orangeAccent,
                          onPressed: () {
                            getImage();
                          },
                          child: Icon(Icons.edit, color: Colors.white,),
                        ),
                        ),
                      ],
                    ),
                  ]),
                ]),
          ),
          Stack(
            children: <Widget>[
              Container(
                // padding: EdgeInsets.only(
                //   top: 500, left: 150, right: 100
                // ),
                margin: EdgeInsets.only(top: 500, left: 110, ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {register();},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          color: Colors.blue,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 50),
                            // width: AppTheme.fullWidth(context) * .7,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Registrasi',
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(20)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ])),
      ),
    );
  }
}
