// import 'package:bpbd/login_page/loginPage.dart';
import 'package:bpbd/screen/login_page/validation.dart';
import 'package:bpbd/screen/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPasswordPage extends StatefulWidget {
  // static var routeName;
  static const String routeName = '/ForgetPasswordPage';

  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage>
    with Validation {
  final formKey = GlobalKey<FormState>();

  String email = '';

  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
          children: <Widget>[
          Container(
            // height: ScreenConfig.screenHeight/10,
            padding: EdgeInsets.only(
              top:ScreenConfig.screenHeight/3
            ),
            // width: ScreenConfig.screenWidth * 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: 'Fo',
                      style: GoogleFonts.portLligatSans(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffe46b10),
                      ),
                      children: [
                        TextSpan(
                          text: 'rg',
                          style: TextStyle(color: Colors.black, fontSize: 25),
                        ),
                        TextSpan(
                          text: 'et',
                          style:
                              TextStyle(color: Color(0xffe46b10), fontSize: 25),
                        ),
                      ]),
                ),
                Padding(padding: EdgeInsets.all(5.0)),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: 'Pas',
                      style: GoogleFonts.portLligatSans(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffe46b10),
                      ),
                      children: [
                        TextSpan(
                          text: 'sw',
                          style: TextStyle(color: Colors.black, fontSize: 25),
                        ),
                        TextSpan(
                          text: 'ord',
                          style:
                              TextStyle(color: Color(0xffe46b10), fontSize: 25),
                        ),
                      ]),
                )
              ],
            ),
          ),
          SizedBox(height: ScreenConfig.screenHeight/40),
          Container(
            // height: ScreenConfig.screenHeight/10,
            padding: EdgeInsets.symmetric(
              vertical:ScreenConfig.blockVertical/500,
              horizontal:ScreenConfig.blockHorizontal/3
            ),
            // width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Masukkan Email Pemulihan",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: ScreenConfig.blockHorizontal*3
                    ),
                  ),
                ),
                Text(
                  "Untuk Mereset Kembali Password Anda",
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: ScreenConfig.blockHorizontal*3,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: ScreenConfig.screenHeight/500,
          ),
          Container(
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: ScreenConfig.blockHorizontal*5),
                    child: Column(children: <Widget>[
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.email,
                                color: Colors.grey,
                              ),
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue))),
                          validator:
                              validateEmail, //BERLAKU SAMA DENGAN HELPERS SEBELUMNYA
                          onSaved: (String value) {
                            email = value;
                          }),
                    ]),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0),
                    child: FlatButton(
                      onPressed: () {
                        //  Navigator.of(context).pushReplacementNamed('/IndexView');
                        if (formKey.currentState.validate()) {
                          //JIKA TRUE
                          formKey.currentState.save();
                          print('Email: $email');
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
                              'Kirim',
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
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
