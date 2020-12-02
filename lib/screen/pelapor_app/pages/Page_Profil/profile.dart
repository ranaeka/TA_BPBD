// import 'package:bpbd/login_page/loginPage.dart';
import 'package:bpbd/api_service/api.dart';
import 'package:bpbd/screen/login_page/loginPage.dart';
import 'package:bpbd/screen/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  // static var routeName;
  static const String routeName = '/Profil';

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String email = '';
  String password = '';
  String nama = '';
  String alamat = '';
  String noHp = '';
  String foto = '';

  getsesion() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences.get('email');
      password = preferences.get('password');
      nama = preferences.get('nama');
      alamat = preferences.get('alamat');
      noHp = preferences.get('no_hp');
      foto = ApiServer.rootImg + "/" + preferences.get('foto');
      print(ApiServer.rootImg + "/" + foto);
    });
  }

  logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('id');
    Navigator.pop(context);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);
  }

  _callAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('Apakah Yakin Ingin Keluar ?',style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenConfig.blockHorizontal*3,
                      ),
                    ),),
            actions: <Widget>[
              FlatButton(
                color: Colors.orange,
                  onPressed: () {
                    logout();
                  },
                  child: Text(
                    'Ya',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenConfig.blockHorizontal*4,
                      ),
                    ),
                  )),
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Tidak',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenConfig.blockHorizontal*4,
                      ),
                    ),
                  ))
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    getsesion();
  }

  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    return Scaffold(
      body:
          // SingleChildScrollView(
          //   physics: ClampingScrollPhysics(),
          //   child:
          Container(
        // padding: EdgeInsets.symmetric(vertical:ScreenConfig.blockVertical*5),
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  // Add one stop for each color. Stops should increase from 0 to 1
                  stops: [0.2, 0.7],
                  colors: [
                    Colors.orange[800],
                    Colors.deepOrange,
                  ],
                  // stops: [0.0, 0.1],
                ),
              ),
              height: ScreenConfig.screenHeight / 3,
              padding: EdgeInsets.only(top: ScreenConfig.screenHeight / 20),
              child: Container(
                width: ScreenConfig.screenWidth * 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // SizedBox(
                    //   height: 10,
                    // ),
                    ClipOval(
                      child: SizedBox(
                        width: 150.0,
                        height: 150.0,
                        //  Icon(Icons.camera_alt, size: 50, color: Colors.grey,)
                        child: CachedNetworkImage(
                          progressIndicatorBuilder: (context, url, progress) =>
                              CircularProgressIndicator(
                            value: progress.progress,
                          ),
                          imageUrl: "$foto",
                          fit: BoxFit.cover,
                        ),
                        //   Image.network(
                        //   "${ApiServer.rootImg}/$foto",
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenConfig.blockVertical * 3,
                      horizontal: ScreenConfig.blockHorizontal * 3),
                  width: ScreenConfig.screenWidth * 3,
                  margin: EdgeInsets.only(top: ScreenConfig.screenHeight / 3.5),
                  // height: ScreenConfig.screenHeight/2,
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: Offset(1, 1),
                              blurRadius: 9,
                            )
                          ],
                        ),
                        child: SizedBox(
                          width: ScreenConfig.screenWidth * 3,
                          // height: ScreenConfig.screenHeight/1,
                          child: Card(
                            elevation: 10,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: ScreenConfig.blockVertical * 3,
                                  horizontal: ScreenConfig.blockHorizontal * 3),
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(
                                  top: ScreenConfig.blockVertical * 1),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Nama',
                                    style: TextStyle(
                                        fontSize:
                                            ScreenConfig.blockHorizontal * 3),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "$nama",
                                    style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            ScreenConfig.blockHorizontal * 3,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    'No Telp',
                                    style: TextStyle(
                                        fontSize:
                                            ScreenConfig.blockHorizontal * 3),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "$noHp",
                                    style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            ScreenConfig.blockHorizontal * 3,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    'Alamat',
                                    style: TextStyle(
                                        fontSize:
                                            ScreenConfig.blockHorizontal * 3),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "$alamat",
                                    style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            ScreenConfig.blockHorizontal * 3,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    'Email',
                                    style: TextStyle(
                                        fontSize:
                                            ScreenConfig.blockHorizontal * 3),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "$email",
                                    style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            ScreenConfig.blockHorizontal * 3,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed('/UbahPasswordView');
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    color: Colors.deepOrange,
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                          horizontal:ScreenConfig.blockHorizontal/ 5,
                                          vertical:ScreenConfig.blockVertical * 2),
                                      // width: AppTheme.fullWidth(context) * .7,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.vpn_key,
                                            color: Colors.white,
                                          ),
                                          Padding(
                                              padding: EdgeInsets.all(10.0)),
                                          Text(
                                            'Ubah Kata Sandi',
                                            style: GoogleFonts.lato(
                                              // fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  ScreenConfig.blockHorizontal*4,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 16,
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top:ScreenConfig.screenHeight/800, bottom:ScreenConfig.screenHeight/80),
              margin: EdgeInsets.only(
                  top: ScreenConfig.screenHeight / 1.2,
                  left: ScreenConfig.blockHorizontal * 10,
                  right: ScreenConfig.blockHorizontal * 10),
              child: FlatButton(
                onPressed: () {
                  _callAlert();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Colors.orange,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenConfig.blockVertical /5),
                  // width: AppTheme.fullWidth(context) * .7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Keluar',
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
            ),
          ],
        ),
      ),
      // ),
    );
  }
}
