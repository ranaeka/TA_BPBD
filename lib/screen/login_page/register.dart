import 'dart:io';

import 'package:bpbd/api_service/api.dart';
import 'package:bpbd/screen/widgets/widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';
import 'package:bpbd/screen/login_page/toast.dart';


class RegisterPage extends StatefulWidget {
  // static var routeName;
  static const String routeName = '/RegisterPage';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  File _image;
  final picker = ImagePicker();

  String email = '';
  String password = '';
  String nama ='';
  String alamat ='';
  String noHp ='';

  bool _isHidePassword = true;

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _nama = TextEditingController();
  TextEditingController _alamat = TextEditingController();
  TextEditingController _noHp = TextEditingController();

    Future<bool>register()async{
    Dio dio= new Dio();
    ProgressDialog pg = new ProgressDialog(context, message: Text('loading'));
    pg.show();
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
      ToastUtils.show("Registrasi Berhasil");
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

  void _tooglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(top: 30, left: 20, right: 20),
        children: <Widget>[
          Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: 'Reg',
                  style: GoogleFonts.portLligatSans(

                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffe46b10),
                  ),
                  children: [
                    TextSpan(
                      text: 'istr',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    TextSpan(
                      text: 'asi',
                      style: TextStyle(color: Color(0xffe46b10), fontSize: 20),
                    ),
                  ]),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextField(
            controller: _nama,
            decoration: InputDecoration(
              icon: Icon(
                Icons.person,
                color: Colors.grey,
              ),
              labelText: "Nama",
              labelStyle: GoogleFonts.lato(
                textStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: _alamat,
            decoration: InputDecoration(
              icon: Icon(
                Icons.home,
                color: Colors.grey,
              ),
              labelText: "Alamat",
              labelStyle: GoogleFonts.lato(
                textStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: _noHp,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              icon: Icon(
                Icons.phone,
                color: Colors.grey,
              ),
              labelText: "No Hp",
              labelStyle: GoogleFonts.lato(
                textStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.email, color: Colors.grey),
              labelText: "Email",
              labelStyle: GoogleFonts.lato(
                textStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: _password,
            obscureText: _isHidePassword,
            decoration: InputDecoration(
              icon: Icon(Icons.vpn_key, color: Colors.grey),
              labelText: "Password",
              labelStyle: GoogleFonts.lato(
                textStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  _tooglePasswordVisibility();
                },
                child: Icon(
                  _isHidePassword ? Icons.visibility_off : Icons.visibility,
                  color: _isHidePassword ? Colors.grey : Colors.blue,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            child:Center(
              child:Text(
                "Silahkan Pilih Foto Untuk di Jadikan Foto Profil",
                style: GoogleFonts.portLligatSans(
                    fontSize: ScreenConfig.blockHorizontal*3,
                    // fontWeight: FontWeight.w700,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: ScreenConfig.blockVertical,
              horizontal: ScreenConfig.blockHorizontal*15
            ),
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
          SizedBox(
            height: 20,
          ),
          FlatButton(
            onPressed: () {
              register();
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.orange,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: ScreenConfig.blockVertical/1),
              // width: AppTheme.fullWidth(context) * .7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Registrasi',
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: ScreenConfig.blockHorizontal*5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
