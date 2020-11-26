import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DaftarLaporan extends StatefulWidget {
  @override
  _DaftarLaporanState createState() => _DaftarLaporanState();
}

class _DaftarLaporanState extends State<DaftarLaporan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
              child: Text(
            'Daftar Laporan',
            style: GoogleFonts.lato(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          )),
          backgroundColor: Colors.deepOrange,
        ),
        body: ListView(
          children: <Widget>[
            ListLaporan(
                foto:
                    "https://cdn.medcom.id/dynamic/content/2020/04/18/1134506/vlqu7HXhf6.jpg?w=480",
                nama: "banjir",
                keterangan: "zhgckjsdcjdahcjdcdcdsjkadkjsackjsd",
                ),
            ListLaporan(
                foto:
                    "https://cdn.medcom.id/dynamic/content/2020/04/18/1134506/vlqu7HXhf6.jpg?w=480",
                nama: "longsor",
                keterangan: "kjhkjhkjdhsjcdlkjvlksjdvcljsdlvl;sde",
                ),
          ],
        ));
  }
}

class ListLaporan extends StatelessWidget {
  const ListLaporan({Key key, this.foto, this.nama, this.keterangan})
      : super(key: key);

  final String foto;
  final String nama;
  final String keterangan;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey[100]),
        padding: EdgeInsets.all(10),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image(
                    image: NetworkImage(
                      foto,
                    ),
                    width: 100.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                    Text(
                    nama,
                    style: TextStyle(fontSize: 10.0),
                  ),
                  Text(
                    keterangan,
                    style: TextStyle(fontSize: 10.0),
                  ),
                    ],
                  ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
