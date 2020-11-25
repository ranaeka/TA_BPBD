// import 'package:bpbd/login_page/forget_password.dart';
// import 'package:bpbd/login_page/register.dart';
// import 'package:bpbd/pages/index.dart';
// import 'package:bpbd/main.dart';
import 'package:bpbd/api_service/api.dart';
import 'package:bpbd/screen/login_page/validation.dart';
import 'package:bpbd/screen/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';
import 'package:ndialog/ndialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:responsive_widgets/responsive_widgets.dart';
// import 'package:bpbd/screen/widgets/widget.dart';

class LoginPage extends StatefulWidget {
  static var routeName;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with Validation {
  final formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String nama = '';
  String alamat = '';
  String noHp = '';

  bool _isHidePassword = true;

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  Future<bool> login() async {
    Dio dio = new Dio();
    ProgressDialog pg = new ProgressDialog(context, message: Text('loading'));
    pg.show();
    Response response;
    response = await dio.post(ApiServer.login,
        data: {"email": "${_email.text}", "password": "${_password.text}"});
    if (response.statusCode == 200) {
      pg.dismiss();
      print(response.data);
      if (response.data['code'] == 200) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('id', response.data['data']['id'].toString());
        preferences.setString(
            'email', response.data['data']['email'].toString());
        preferences.setString(
            'password', response.data['data']['password'].toString());
        preferences.setString('nama', response.data['data']['nama'].toString());
        preferences.setString(
            'alamat', response.data['data']['alamat'].toString());
        preferences.setString(
            'no_hp', response.data['data']['no_hp'].toString());
        preferences.setString('foto', response.data['data']['foto'].toString());
        preferences.setString(
            'level', response.data['data']['level'].toString());
        if (response.data['data']['level'] == 'petugas') {
          Navigator.of(context).pushReplacementNamed('/IndexPetugasView');
        } else {
          Navigator.of(context).pushReplacementNamed('/IndexPelaporView');
        }
      }
    }
    return true;
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
      backgroundColor: Colors.grey[100],
      body: ListView(
        children: <Widget>[
          Stack(children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: ScreenConfig.screenHeight/3,
                  width: ScreenConfig.screenWidth * 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: AssetImage(
                          "assets/bpbd.png",
                        ),
                        radius: 50,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Aplikasi Pelaporan Dan Penaggulangan Bencana",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenConfig.blockHorizontal* 2.5,
                          ),
                        ),
                      ),
                      Text(
                        "Badan Penanggulangan Bencana Daerah Kabupaten Indramayu",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenConfig.blockHorizontal* 2.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: 'L',
                      style: GoogleFonts.portLligatSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffe46b10),
                      ),
                      children: [
                        TextSpan(
                          text: 'og',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        TextSpan(
                          text: 'in',
                          style:
                              TextStyle(color: Color(0xffe46b10), fontSize: 20),
                        ),
                      ]),
                ),
                Container(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: ScreenConfig.blockVertical* 2,
                              horizontal: ScreenConfig.blockHorizontal* 5
                              ),
                          child: Column(children: <Widget>[
                            TextFormField(
                              controller: _email,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.email, color: Colors.grey),
                                  labelText: 'Email',
                                  labelStyle: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue))),
                              validator:
                                  validateEmail, //BERLAKU SAMA DENGAN HELPERS SEBELUMNYA
                              onSaved: (String value) {
                                email = value;
                              },
                            ),
                          ]),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: ScreenConfig.blockVertical/7,
                              horizontal: ScreenConfig.blockHorizontal* 5
                              ),
                          // only(top: 10.0, left: 20.0, right: 20.0),
                          child: Column(children: <Widget>[
                            TextFormField(
                              controller: _password,
                              obscureText: _isHidePassword,
                              autofocus: false,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.lock_outline,
                                      color: Colors.grey),
                                  labelText: 'Kata Sandi',
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      _tooglePasswordVisibility();
                                    },
                                    child: Icon(
                                      _isHidePassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: _isHidePassword
                                          ? Colors.grey
                                          : Colors.blue,
                                    ),
                                  ),
                                  labelStyle: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  // TextStyle(
                                  //     fontWeight: FontWeight.bold,
                                  //     color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue))),
                              // obscureText: true,
                              // validator:
                              //     validatePassword, ////BERLAKU SAMA DENGAN HELPERS SEBELUMNYA
                              // onSaved: (String value) {
                              //   password = value;
                              // }
                            ),
                            Container(
                                alignment: Alignment(1.0, 0.0),
                                padding: EdgeInsets.only(top: 0.0, left: 10.0),
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed('/ForgetPasswordPage');
                                  },
                                  child: Text(
                                    'Lupa Kata Sandi ?',
                                    style: GoogleFonts.lato(
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ))
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  padding: EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0),
                  child: FlatButton(
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        // formKey.currentState.save();
                        login();
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.orange,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      // width: AppTheme.fullWidth(context) * .7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Masuk',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 0),
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Belum memiliki akun ?',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/RegisterPage');
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                              color: Colors.orange[600],
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ]),
        ],
      ),
    );
  }
}

// class ScreenConfig {
//   static MediaQueryData _mediaQueryData;
//   static double screenWidth;
//   static double screenHeight;
//   static double blockHorizontal;
//   static double blockVertical;
//   static double _safeAreaHorizontal;
//   static double _safeAreaVertical;
//   static double blockHorizontal;
//   static double safeBlockVertical;

//   void init(BuildContext context) {
//     _mediaQueryData = MediaQuery.of(context);
//     screenWidth = _mediaQueryData.size.width;
//     screenHeight = _mediaQueryData.size.height;
//     blockHorizontal = screenWidth / 100;
//     blockVertical = screenHeight / 100;
//     _safeAreaHorizontal =
//         _mediaQueryData.padding.left + _mediaQueryData.padding.right;
//     _safeAreaVertical =
//         _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
//     blockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
//     safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
//   }
// }

// Container(
//   padding: EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0),
//   child: InkWell(
//     onTap: () {
//       Navigator.pushReplacementNamed(context, Index.routeName);
//     },
//     splashColor: Colors.grey,
//     child: Container(
//       width: MediaQuery.of(context).size.width,
//       padding: EdgeInsets.symmetric(vertical: 15),
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(5)),
//           boxShadow: <BoxShadow>[
//             BoxShadow(
//                 color: Colors.grey.shade200,
//                 offset: Offset(2, 4),
//                 blurRadius: 5,
//                 spreadRadius: 2)
//           ],
//           gradient: LinearGradient(
//               begin: Alignment.centerLeft,
//               end: Alignment.centerRight,
//               colors: [Color(0xfffbb448), Color(0xfff7892b)])),
//       child: Text(
//         'Login',
//         style: GoogleFonts.roboto(fontSize: 20, color: Colors.white),
//       ),
//     ),
//   ),
// ),
