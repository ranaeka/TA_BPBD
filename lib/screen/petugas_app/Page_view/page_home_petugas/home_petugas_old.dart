//
// import 'package:bpbd/screen/petugas_app/menu_view/daftar_laporan/v_daftar_laporan.dart';
// import 'package:bpbd/screen/petugas_app/menu_view/info_bencana/info_bencana_petugas.dart';
// import 'package:bpbd/screen/petugas_app/menu_view/kontak_bpbd/kontak_bpbd_petugas.dart';
// import 'package:bpbd/screen/petugas_app/menu_view/profil_petugas/profil_petugas.dart';
// import 'package:bpbd/screen/widgets/widget.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class HomePetugas extends StatefulWidget {
//   // static var routeName;
//   static const String routeName= '/HomePetugas';
//
//   @override
//   _HomePetugasState createState() => _HomePetugasState();
// }
//
// class _HomePetugasState extends State<HomePetugas> {
//   @override
//   Widget build(BuildContext context) {
//     ScreenConfig().init(context);
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body:
//       // SingleChildScrollView(
//       //   physics: ClampingScrollPhysics(),
//       //   child:
//         Container(
//           child: Stack(
//             children: <Widget>[
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(20.0),
//                     bottomRight: Radius.circular(20.0),
//                   ),
//                   gradient: LinearGradient(
//                     begin: Alignment.centerLeft,
//                     end: Alignment.centerRight,
//                     // Add one stop for each color. Stops should increase from 0 to 1
//                     stops: [0.2, 0.7],
//                     colors: [
//                       Colors.orange[800],
//                       Colors.deepOrange,
//                     ],
//                     // stops: [0.0, 0.1],
//                   ),
//                 ),
//                height: ScreenConfig.screenHeight / 2.5,
//                 // MediaQuery.of(context).size.height * .40,
//                 // width: ScreenConfig.screenWidth,
//                 padding: EdgeInsets.symmetric(
//                   vertical: ScreenConfig.blockVertical * 3,
//                   horizontal: ScreenConfig.blockHorizontal * 3,
//                 ),
//                 child: Container(
//                   width: ScreenConfig.screenWidth * 3,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       CircleAvatar(
//                         backgroundImage: AssetImage(
//                           "assets/bpbd.png",
//                         ),
//                         radius: ScreenConfig.blockHorizontal * 13,
//                         // 50,
//                       ),
//                       SizedBox(height: ScreenConfig.screenHeight / 50),
//                       Text(
//                         "Badan Penanggulangan Bencana Daerah",
//                         style: GoogleFonts.lato(
//                           fontWeight: FontWeight.bold,
//                           fontSize: ScreenConfig.blockHorizontal * 3.5,
//                         ),
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         "Kabupaten Indramayu",
//                         style: GoogleFonts.lato(
//                           fontWeight: FontWeight.bold,
//                           fontSize: ScreenConfig.blockHorizontal * 3.5,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 // padding: EdgeInsets.only(top: 10, ),
//                 // width: MediaQuery.of(context).size.width,
//                 // margin: EdgeInsets.only(top: 300, bottom: 10),
//                 // height: 430,
//                 // width: double.infinity,
//                 margin: EdgeInsets.only(top:ScreenConfig.screenHeight/2.9),
//                 height: ScreenConfig.screenHeight*2.5,
//                 child: GridView.count(
//                   physics: NeverScrollableScrollPhysics(),
//                   primary: false,
//                   // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   //   crossAxisCount: 2,
//                   //   childAspectRatio: MediaQuery.of(context).size.width /
//                   //       (MediaQuery.of(context).size.height / 2.5),
//                   // ),
//                   crossAxisCount: 2,
//                   // childAspectRatio: MediaQuery.of(context).size.width /
//                   // (MediaQuery.of(context).size.height / ),
//                   children: <Widget>[
//                     MyMenu(
//                         title: "Daftar Laporan",
//                         icon: Icons.collections_bookmark,
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => DaftarLaporan()));
//                         },
//                         warna: Colors.red),
//                     MyMenu(
//                         title: "Tentang Bencana",
//                         icon: Icons.collections_bookmark,
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => InfoBencanaPetugasView()));
//                         },
//                         warna: Colors.green),
//                     MyMenu(
//                         title: "Kontak Bpbd",
//                         icon: Icons.phone,
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => KontakBpbdPetugasView()));
//                         },
//                         warna: Colors.blueGrey),
//                      MyMenu(
//                         title: "Profil",
//                         icon: Icons.person_outline,
//                         onTap: () {
//                            Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => ProfilPetugasView()));
//                         },
//                         warna: Colors.blue),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//     );
//   }
// }
//
// class MyMenu extends StatelessWidget {
//   MyMenu({this.title, this.icon, this.warna, this.onTap});
//
//   final String title;
//   final IconData icon;
//   final MaterialColor warna;
//   final Function onTap;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(100.0),
//         ),
//         // margin: EdgeInsets.all(30.0),
//          margin: EdgeInsets.symmetric(
//             vertical: ScreenConfig.blockVertical * 4,
//             horizontal: ScreenConfig.blockHorizontal * 8),
//         child: InkWell(
//           borderRadius: BorderRadius.circular(100.0),
//           onTap: onTap,
//           splashColor: Colors.deepOrange,
//           child: Column(
//             // mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Icon(
//                 icon,
//                 size: ScreenConfig.blockHorizontal * 20.5,
//                 color: warna,
//               ),
//               Text(
//                 title,
//                 style: GoogleFonts.roboto(
//                   textStyle: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: ScreenConfig.blockHorizontal *2.5,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
