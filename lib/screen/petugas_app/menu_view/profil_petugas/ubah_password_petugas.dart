// import 'dart:io';

import 'package:bpbd/api_service/api.dart';
import 'package:bpbd/screen/login_page/toast.dart';
import 'package:bpbd/screen/widgets/widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ndialog/ndialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UbahPasswordPetugasView extends StatefulWidget {
  // static var routeName;

  @override
  _UbahPasswordPetugasViewState createState() => _UbahPasswordPetugasViewState();
}

class _UbahPasswordPetugasViewState extends State<UbahPasswordPetugasView> {
  String password = '';
  String id = '';

  bool _isHidePassword = true;

  TextEditingController _password = TextEditingController();

  getsession() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.get('id');
    });
  }

  Future<bool> ubahPassword() async {
    Dio dio = new Dio();
    ProgressDialog pg = new ProgressDialog(context, message: Text('loading'));
    Response response;
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.get("id");
    print(_password.text);
    var url = "${ApiServer.updatePassword}/$id";
    response = await dio.post(url, data: {"password": "${_password.text}"});
    if (response.statusCode == 200) {
      pg.dismiss();
      print(response.data);
      ToastUtils.show("Kata Sandi Anda Telah Berhasil di ubah");
      if(response.data['code']== 200){
        Navigator.pop(context);
      }
      return true;
    }
    // then((value) {
    //   pg.dismiss();
    //   print(response.data);
    //   ToastUtils.show("Password Telah Berhasil di ubah");
    // }
    // );
    return true;
  }

  void _tooglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
      // _isHidePassword = !_isHidePassword;
    });
  }

  void initState() {
    super.initState();
    getsession();
  }

  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text('Ubah Kata Sandi',style: GoogleFonts.lato(
            textStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: ScreenConfig.blockHorizontal * 5,
            ),
          ),)),
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
          decoration: BoxDecoration(color: Colors.grey[100]),
          child: Stack(children: <Widget>[
            Container(
              // height: MediaQuery.of(context).size.height * .30,
              // padding: EdgeInsets.only(top: 200, left: 30, right: 30),
              // width: MediaQuery.of(context).size.width,
              height: ScreenConfig.screenHeight / 10,
              child: Center(
                child: Text(
                  "Silahkan Isi Form Dibawah untuk merubah kata sandi anda",
                 style: GoogleFonts.portLligatSans(
                    fontSize: ScreenConfig.blockHorizontal * 2.9,
                    fontWeight: FontWeight.w700,
                    color: Colors.orange[600],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              // padding: EdgeInsets.only(top: 280, left: 20, right: 20),
              padding: EdgeInsets.symmetric(
                  vertical: ScreenConfig.blockVertical * 8,
                  horizontal: ScreenConfig.blockHorizontal * 6),
              child: TextField(
                controller: _password,
                obscureText: _isHidePassword,
                decoration: InputDecoration(
                  icon: Icon(Icons.vpn_key, color: Colors.grey),
                  labelText: "Kata Sandi",
                  labelStyle: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenConfig.blockHorizontal * 3.5,
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
              // TextField(
              //   controller: _password,
              //   keyboardType: TextInputType.text,
              //   decoration: InputDecoration(
              //     // hintText: "Nama",
              //     labelText: 'Password',
              //     border: new OutlineInputBorder(
              //         borderRadius: new BorderRadius.circular(20.0)),
              //     suffixIcon: GestureDetector(
              //       onTap: () {
              //         _tooglePasswordVisibility();
              //       },
              //       child: Icon(
              //         _isHidePassword ? Icons.visibility_off : Icons.visibility,
              //         color: _isHidePassword ? Colors.grey : Colors.blue,
              //       ),
              //     ),
              //   ),
              // ),
            ),
            Container(
              // padding: EdgeInsets.only(top: 360, left: 120, right: 100),
               padding: EdgeInsets.symmetric(
                  vertical: ScreenConfig.blockVertical * 20,
                  horizontal: ScreenConfig.blockHorizontal * 3),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          ubahPassword();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: Colors.orange,
                        child: Container(
                         padding: EdgeInsets.symmetric(
                              vertical: ScreenConfig.blockVertical * 2,
                              horizontal: ScreenConfig.blockHorizontal * 30),
                          // width: AppTheme.fullWidth(context) * .7,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Ubah',
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenConfig.blockHorizontal*4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ])),
    );
  }
}
