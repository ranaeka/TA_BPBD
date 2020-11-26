// import 'dart:ffi';

import 'package:bpbd/screen/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoBencanaView extends StatefulWidget {
  // static var routeName;
      static const String routeName= '/InfoBencanaView';

  @override
  _InfoBencanaViewState createState() => _InfoBencanaViewState();
}

class _InfoBencanaViewState extends State<InfoBencanaView> {
  List<Container> daftarBencana = new List();

  var bencana = [
    {
      "nama": "Bencana Alam",
      "gambar": "banjir.jpg",
      "keterangan":
          "Bencana alam adalah bencana yang diakibatkan oleh peristiwa atau serangkaian peristiwa oleh alam. Pada umumnya bencana alam terjadi karena adanya perubahan pada kondisi alam baik secara perlahan maupun secara ekstrem. Selain itu, bencana alam dapat terjadi karena ada faktor campur tangan manusia yang tidak bertanggungjawab, misalnya penebangan pohon berlebihan yang menyebabkan tanah longsor, banjir, abrasi dan sebagainya."
    },
    {
      "nama": "Bencana Non Alam",
      "gambar": "wabah.jpg",
      "keterangan":
          "Bencana nonalam adalah bencana yang diakibatkan oleh peristiwa atau rangkaian peristiwa nonalam yang antara lain berupa gagal teknologi, gagal modernisasi, epidemi, dan wabah penyakit."
    },
    {
      "nama": "Bencana Sosial",
      "gambar": "tawuran.jpg",
      "keterangan":
          "Bencana sosial adalah bencana yang diakibatkan oleh peristiwa atau serangkaian peristiwa yang diakibatkan oleh manusia yang meliputi konflik sosial antarkelompok atau antarkomunitas masyarakat, dan teror."
    },
  ];

  _buatlist() async {
    for (var i = 0; i < bencana.length; i++) {
      final bencananya = bencana[i];
      final String gambar = bencananya["gambar"];
      final keterangan = bencananya["keterangan"];

      daftarBencana.add(
        new Container(
          child: new Card(
            child: new Column(
              children: <Widget>[
                new Hero(
                  tag: bencananya['nama'],
                  child: new Material(
                    child: new InkWell(
                      onTap: () =>
                          Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new Detail(
                            nama: bencananya['nama'],
                            gambar: gambar,
                            keterangan: keterangan),
                      )),
                      child: new Image.asset(
                        "assets/$gambar",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // new Image.asset("assets/$gambar", fit: BoxFit.cover,),
                new Padding(padding: new EdgeInsets.all(50.0)),
                new Text(
                  bencananya['nama'],
                  style: new TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    _buatlist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
            child: Text(
          'Informasi Bencana',
          style: GoogleFonts.lato(
            fontWeight: FontWeight.bold,
            fontSize: ScreenConfig.blockHorizontal*5,
          ),
        )),
        backgroundColor: Colors.deepOrange,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        scrollDirection: Axis.vertical,
        itemCount: 3,
        itemBuilder: (c, i) {
          return new Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0.0, 4.0),
                  blurRadius: 6.0,
                )
              ],
            ),
            margin: EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            // padding: EdgeInsets.symmetric(horizontal: 10.0, vertical:1.0),
            child: new Card(
              // color: Colors.,
              child: new Column(
                children: <Widget>[
                  new Hero(
                    tag: bencana[i]['nama'],
                    child: new Material(
                      child: new InkWell(
                        onTap: () =>
                            Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => new Detail(
                              nama: bencana[i]['nama'],
                              gambar: bencana[i]['gambar'],
                              keterangan: bencana[i]['keterangan']),
                        )),
                        child: new Image.asset(
                          "assets/${bencana[i]['gambar']}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  // new Image.asset("assets/$gambar", fit: BoxFit.cover,),
                  new Padding(padding: new EdgeInsets.all(10.0)),
                  new Text(
                    bencana[i]['nama'],
                    style: new TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Detail extends StatelessWidget {
  Detail({this.nama, this.gambar, this.keterangan});
  final String nama;
  final String gambar;
  final keterangan;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView(
        children: <Widget>[
          new Container(
            height: 250.0,
            child: new Hero(
              tag: nama,
              child: new Material(
                child: new InkWell(
                  child: new Image.asset("assets/$gambar", fit: BoxFit.cover),
                ),
              ),
            ),
            // child: new Image.asset("assets/$gambar"),
          ),
          SizedBox(
            height: 10,
          ),
          new BagianNama(nama: nama),
          new BagianKeterangan(
            keterangan: keterangan,
          ),
        ],
      ),
    );
  }
}

class BagianNama extends StatelessWidget {
  BagianNama({this.nama});
  final String nama;

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                nama,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BagianKeterangan extends StatelessWidget {
  BagianKeterangan({this.keterangan});
  final keterangan;

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.all(10.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            keterangan,
            style: TextStyle(fontSize: 16.0),
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }
}
