import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/widget.dart';

class VDetailBencana extends StatefulWidget {
  @override
  _VDetailBencanaState createState() => _VDetailBencanaState();
}

class _VDetailBencanaState extends State<VDetailBencana> {
  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        actions: [
          // IconButton(
          //   icon: Icon(Feather.check_circle,size: 25,color: Colors.white,),
          // )
        ],
        title: Text("Detail Bencana"),
      ),
      body: MediaQuery.removePadding(context: context,removeTop: true,
      child: ListView(
        children: [
          Stack(
            children: [
              ClipRRect(
                // borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                child: Image.asset(
                  "assets/banjir.jpg",
                  height: MediaQuery.of(context).size.height * 0.4,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ],
          ),
          SizedBox(height: 5,),
          Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)
            ),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5)
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Lokasi Bencana',style: GoogleFonts.pTSansCaption(fontWeight: FontWeight.bold),),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(

                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      //  icon: Icon(Icons.home, color: Colors.grey),
                      labelText: "Kecamatan",
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

                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      // icon: Icon(Icons.home, color: Colors.grey),
                      labelText: "Desa",
                      labelStyle: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),)
      ,
    );
  }
}
