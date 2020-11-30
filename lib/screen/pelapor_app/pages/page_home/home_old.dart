import 'package:bpbd/screen/pelapor_app/menu_view/info_bencana_view/v_info_bencana.dart';
import 'package:bpbd/screen/pelapor_app/menu_view/kontak_bpbd_view/v_kontakbpbd_view.dart';
import 'package:bpbd/screen/pelapor_app/menu_view/laporan_view/v_laporan.dart';

import 'package:bpbd/screen/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  // static var routeName;
  static const String routeName = '/Home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: 
      // SingleChildScrollView(
      //   physics: ClampingScrollPhysics(),
      //   child: 
      Container(
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
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
                height: ScreenConfig.screenHeight / 2.5,
                // MediaQuery.of(context).size.height * .40,
                // width: ScreenConfig.screenWidth,
                padding: EdgeInsets.symmetric(
                  vertical: ScreenConfig.blockVertical * 3,
                  horizontal: ScreenConfig.blockHorizontal * 3,
                ),
                child: Container(
                  width: ScreenConfig.screenWidth * 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                          backgroundImage: AssetImage(
                            "assets/bpbd.png",
                          ),
                          radius: ScreenConfig.blockHorizontal * 13
                          // 50,
                          ),
                      SizedBox(height: ScreenConfig.screenHeight / 50),
                      Text(
                        "Badan Penanggulangan Bencana Daerah",
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenConfig.blockHorizontal * 3.5,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Kabupaten Indramayu",
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenConfig.blockHorizontal * 3.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                // padding: EdgeInsets.symmetric(
                //   vertical: ScreenConfig.safeBlockVertical*150,
                //   horizontal: ScreenConfig.safeBlockHorizontal*5
                // ),
                // width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top:ScreenConfig.screenHeight/2.9),
                // symmetric(
                //     vertical: ScreenConfig.safeBlockVertical * 38,
                //     horizontal: ScreenConfig.safeBlockHorizontal * 3),
                height: ScreenConfig.screenHeight*2.5,
                // width: double.infinity,
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  primary: false,
                  // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //   crossAxisCount: 2,
                  //   childAspectRatio: MediaQuery.of(context).size.width /
                  //       (MediaQuery.of(context).size.height / 2.5),
                  // ),
                  crossAxisCount: 2,
                  // childAspectRatio: MediaQuery.of(context).size.width /
                  // (MediaQuery.of(context).size.height / ),
                  children: <Widget>[
                    MyMenu(
                        title: "Lapor Bencana",
                        icon: Icons.report_problem,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LaporanView()));
                        },
                        warna: Colors.red),
                    MyMenu(
                        title: "Tentang Bencana",
                        icon: Icons.collections_bookmark,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InfoBencanaView()));
                        },
                        warna: Colors.green),
                    // MyMenu(
                    //     title: "Riwayat Laporan",
                    //     icon: Icons.book,
                    //     onTap: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => RiwayatLaporanView()));
                    //     },
                    //     warna: Colors.blue),
                    MyMenu(
                        title: "Kontak Bpbd",
                        icon: Icons.phone,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => KontakBpbdView()));
                        },
                        warna: Colors.blueGrey),
                  ],
                ),
              ),
            ],
          ),
        ),
      // ),
    );
  }
}

class MyMenu extends StatelessWidget {
  MyMenu({this.title, this.icon, this.warna, this.onTap});

  final String title;
  final IconData icon;
  final MaterialColor warna;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(200.0),
        ),
        margin: EdgeInsets.symmetric(
            vertical: ScreenConfig.blockVertical * 4,
            horizontal: ScreenConfig.blockHorizontal * 8),
        child: InkWell(
          borderRadius: BorderRadius.circular(150.0),
          onTap: onTap,
          splashColor: Colors.deepOrange,
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: ScreenConfig.blockHorizontal * 20.5,
                color: warna,
              ),
              Text(
                title,
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenConfig.blockHorizontal *2.5,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}