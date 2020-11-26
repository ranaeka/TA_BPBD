import 'package:bpbd/screen/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KontakBpbdView extends StatefulWidget {
  @override
  // _CallCenterViewState createState() => _CallCenterViewState();
  _KontakBpbdViewState createState() => _KontakBpbdViewState();
}

class _KontakBpbdViewState extends State<KontakBpbdView> {
  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
              child: Text(
            'Kontak BPBD',
            style: GoogleFonts.lato(
            textStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: ScreenConfig.blockHorizontal * 5,
            ),
          ),
          )),
          backgroundColor: Colors.deepOrange,
        ),
        body: Container(
          decoration: BoxDecoration(color: Colors.grey[100]),
          child: Stack(children: <Widget>[
            Container(
              height: ScreenConfig.screenHeight/4,
              // padding: EdgeInsets.only(top: 0, left: 30, right: 30),
              width: ScreenConfig.screenWidth*3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage(
                      "assets/bpbd.png",
                    ),
                    radius: ScreenConfig.blockHorizontal*12,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Badan Penanggulangan Bencana Daerah",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenConfig.blockHorizontal*3.5,
                      ),
                    ),
                  ),
                  Text(
                    "Kabupaten Indramayu",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenConfig.blockHorizontal*3.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical:ScreenConfig.blockVertical*15, horizontal: ScreenConfig.blockHorizontal*3),
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 90),
              child: Column(
                children: <Widget>[
                  Container(
                     decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(1, 1),
                                blurRadius: 7,
                              )
                            ],
                          ),
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.home,
                                color: Colors.deepOrange,
                                size: ScreenConfig.blockHorizontal*10,
                              ),
                              Padding(
                                padding: EdgeInsets.all(5.0),
                              ),
                              Text(
                                'Jalan Pahlawan No. 62/A Indramayu',
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenConfig.blockHorizontal*3.5,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(1, 1),
                                blurRadius: 7,
                              )
                            ],
                          ),
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.phone,
                                color: Colors.deepOrange,
                                size: ScreenConfig.blockHorizontal*10,
                              ),
                              Padding(
                                padding: EdgeInsets.all(5.0),
                              ),
                              Text(
                                ' 0234-277721',
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenConfig.blockHorizontal*3.5,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(1, 1),
                                blurRadius: 7,
                              )
                            ],
                          ),
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.web,
                                color: Colors.deepOrange,
                                size: ScreenConfig.blockHorizontal*10,
                              ),
                              Padding(
                                padding: EdgeInsets.all(5.0),
                              ),
                              Text(
                                'bpbd.indramayukab.go.id',
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenConfig.blockHorizontal*3.5,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(1, 1),
                                blurRadius: 7,
                              )
                            ],
                          ),
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.email,
                                color: Colors.deepOrange,
                                size: ScreenConfig.blockHorizontal*10,
                              ),
                              Padding(
                                padding: EdgeInsets.all(5.0),
                              ),
                              Text(
                                'bpbd.indramayu@gmail.com',
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenConfig.blockHorizontal*3.5,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}
