import 'package:bpbd/screen/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Tentang extends StatefulWidget {
  // static var routeName;
  static const String routeName = '/Tentang';
  @override
  _TentangState createState() => _TentangState();
}

class _TentangState extends State<Tentang> {
  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
        // margin: EdgeInsets.all(ScreenConfig.blockVertical),
        decoration: BoxDecoration(color: Colors.grey[100]),
        child: Column(
          children: <Widget>[
            Container(
              height: ScreenConfig.screenHeight / 4,
              // padding: EdgeInsets.symmetric(horizontal:ScreenConfig.blockHorizontal*3),
              width: ScreenConfig.screenWidth * 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage(
                      "assets/bpbd.png",
                    ),
                    radius: 30,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Aplikasi Pelaporan Dan Penaggulangan Bencana",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenConfig.blockHorizontal * 2.5,
                      ),
                    ),
                  ),
                  Text(
                    "Badan Penanggulangan Bencana Daerah Kabupaten Indramayu",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenConfig.blockHorizontal * 2.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(
                    top: ScreenConfig.screenHeight /100,
                    left: ScreenConfig.blockHorizontal * 3,
                    right: ScreenConfig.blockHorizontal * 3),
                // width: ScreenConfig.screenWidth*3,
                // height: ScreenConfig.screenHeight*100,
                // margin: EdgeInsets.symmetric(vertical:ScreenConfig.blockSizeVertical*25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Tentang Aplikasi',
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenConfig.blockHorizontal * 3.5,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Aplikasi Pelaporan Dan Penanggulangan Bencana Pada Badan Penanggulangan Benca Daerah Kabupaten Indramayu adalah aplikasi yang dibuat untuk membantu masyarakat dalam hal melaporkan kejadian bencana dan membantu badan penanggulangan bencana daerah (BPBD) Kabupaten Indramayu. Pembuatan aplikasi ini berdasarkan pada data hasil survei terhadap keadaan Kabupaten Indramayu yang sering terkena bencana dan membutuhkan bantuan BPBD Kabupaten Indramayu. Aplikasi yang akan digunakan yaitu berbasis mobile. Yang digunakan oleh masyarakat untuk masyarakat untuk melaporkan bencana.',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: ScreenConfig.blockHorizontal * 3.5,
                        ),
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: ScreenConfig.screenHeight/35,
                    ),
                    Text(
                      'Fitur-fitur Pada Aplikasi:',
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenConfig.blockHorizontal * 3.5,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenConfig.screenHeight/50,
                    ),
                    Text(
                      'Location',
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenConfig.blockHorizontal * 3,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Pada Aplikasi ini dapat memberikan lokasi bencana yang akurat sehingga dapat membantu petugas BPBD dalam hal mengetahui lokasi terjadi nya bencana dan menanggulangi bencana yang telah dilaporankan oleh masyarakat.',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: ScreenConfig.blockHorizontal * 3.5,
                        ),
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Take picture',
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenConfig.blockHorizontal * 3,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Fitur ini terdapat pada menu pelaporan, fitur ini dapat membantu petugas untuk mengetahui gambaran bencana yang dilaporakan oleh masyarakat.',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: ScreenConfig.blockHorizontal * 3.5,
                        ),
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Kontak Developer',
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenConfig.blockHorizontal * 3.5,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenConfig.screenHeight/50,
                    ),
                    Text(
                      '1. Rana Eka Millenio',
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: ScreenConfig.blockHorizontal * 3.5,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: 0,
                        left: 10,
                      ),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'No.Hp: +628312114666',
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenConfig.blockHorizontal *3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: 0,
                        left: 10,
                      ),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Email: ranaekam69@gmail.com',
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenConfig.blockHorizontal * 3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '2. Rana Eka Millenio',
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: ScreenConfig.blockHorizontal * 3.5,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: 0,
                        left: 10,
                      ),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'No.Hp: +628312114666',
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenConfig.blockHorizontal * 3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: 0,
                        left: 10,
                      ),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Email: ranaekam69@gmail.com',
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenConfig.blockHorizontal * 3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),
      )),
    );
  }
}
