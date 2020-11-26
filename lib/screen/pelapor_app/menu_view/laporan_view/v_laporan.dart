// import 'package:bpbd/api_service/api.dart';
import 'dart:io';

import 'package:bpbd/api_service/api.dart';
import 'package:bpbd/screen/login_page/toast.dart';
import 'package:bpbd/screen/widgets/widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:ndialog/ndialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class LaporanView extends StatefulWidget {
  static const String routeName = '/LaporanView';

  @override
  _LaporanViewState createState() => _LaporanViewState();
}

class _LaporanViewState extends State<LaporanView> {
  File image;
  final picker = ImagePicker();

  String nama = '';
  String namaPelapor = '';
  String noHp = '';
  String kecamatan = '';
  String desa = '';
  String jenisBencana = '';
  String garisBujur = '';
  String garisLintang = '';
  String keterangan = '';

  TextEditingController _namaPelapor = TextEditingController();
  TextEditingController _noHp = TextEditingController();
  TextEditingController _kecamatan = TextEditingController();
  TextEditingController _desa = TextEditingController();
  TextEditingController _jenisBencana = TextEditingController();
  TextEditingController _keterangan = TextEditingController();
  TextEditingController _controllerlat = TextEditingController();
  TextEditingController _controllerlong = TextEditingController();
  var location = new Location();
  LatLng latLngDevice = new LatLng(0, 0);

  void getLocation() async {
    if (this.mounted) {
      location.onLocationChanged().listen((LocationData currentLocation) {
        try {
          // getNameLocation(currentLocation.latitude, currentLocation.longitude);
          // print(currentLocation.latitude);
          setState(() {
            latLngDevice =
                new LatLng(currentLocation.latitude, currentLocation.longitude);
            _controllerlat.text = currentLocation.latitude.toString();
            _controllerlong.text = currentLocation.longitude.toString();
            // mapController.animateCamera(CameraUpdate.newCameraPosition(
            //     CameraPosition(target: latLngDevice, zoom: 19.2)));
          });
        } catch (e) {}
      });
    }

    print(latLngDevice);
  }

  Future<File> testCompressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, targetPath,
        quality: 88, autoCorrectionAngle: true);

    print(file.lengthSync());
    print(result.lengthSync());

    setState(() {
      image = result;
    });

    return result;
  }

  @override
  void initState() {
    getLocation();
    getsesion();
    super.initState();
  }

  // Future getImage() async {
  //   // final pickedFile = await picker.getImage(source: ImageSource.camera);
  //   var pickedFile = await picker.getImage(source: ImageSource.camera);
  //   setState(() {
  //     _image = File(pickedFile.path);
  //   });
  // }

  getsesion() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _namaPelapor.text = preferences.get('nama');
    });
  }

  Future getImage(ImageSource imageSource) async {
    var image = await ImagePicker().getImage(source: imageSource);

    final dir = await getTemporaryDirectory();
    var id = DateFormat('ymdhis').format(DateTime.now());
    final targetPath = dir.absolute.path + "/$id.jpg";
    setState(() {
      File img = File(image.path);
      testCompressAndGetFile(img, targetPath);
      Navigator.pop(context);
    });
  }

  void showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 120,
          child: Column(
            children: <Widget>[
              ListTile(
                onTap: () {
                  getImage(ImageSource.camera);
                },
                leading: Icon(Icons.camera),
                title: Text("Ambil Gambar dari Kamera"),
              ),
              ListTile(
                onTap: () {
                  getImage(ImageSource.gallery);
                },
                leading: Icon(Icons.photo),
                title: Text("Ambil Gambar dari Galeri"),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<bool> laporan() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.get('id');
    Dio dio = new Dio();
    ProgressDialog pg = ProgressDialog(context, message: Text('loading'));
    pg.show();
    print(_namaPelapor.text);
    print(_noHp.text);
    print(_kecamatan.text);
    print(_desa.text);
    print(_jenisBencana.text);
    print(_controllerlong.text);
    print(_controllerlat.text);
    print(_keterangan.text);
    print(image.path);
    FormData formdata = FormData.fromMap({
      "id_pelapor": "${id.toString()}",
      "no_hp": "${_noHp.text}",
      "kecamatan": "${_kecamatan.text}",
      "desa": "${_desa.text}",
      "jenis_bencana": "${_jenisBencana.text}",
      "garis_bujur": "${_controllerlong.text}",
      "garis_lintang": "${_controllerlat.text}",
      "keterangan": "${_keterangan.text}",
      "foto": await MultipartFile.fromFile(image.path.toString(),
          filename: image.path.split('/').last)
    });
    Response response;
    response = await dio.post(ApiServer.buatLaporan, data: formdata);
    if (response.statusCode == 200) {
      ToastUtils.show("Laporan Anda Berhasil Terkirim");
      pg.dismiss();
      if (response.data['code'] == 200) {
        Navigator.pop(context);
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text('Form Laporan Bencana',
              style: GoogleFonts.lato(
                fontWeight: FontWeight.bold,
                fontSize: ScreenConfig.blockHorizontal*4,
              )),
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
        children: <Widget>[
          Center(
            child: Text(
              "! Silahkan isi form dibawah dengan benar kemudian klik tombol kirim",
              style: GoogleFonts.portLligatSans(
                fontSize: ScreenConfig.blockHorizontal*3.8,
                fontWeight: FontWeight.w700,
                color: Colors.redAccent,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: _namaPelapor,
            enabled: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              // icon: Icon(Icons.person, color: Colors.grey),
              labelText: "Nama",
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
            controller: _noHp,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              // icon: Icon(Icons.phone, color: Colors.grey),
              labelText: "No.Telp/Hp",
              labelStyle: GoogleFonts.lato(
                textStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
          TextField(
            controller: _jenisBencana,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              // icon: Icon(Icons.phone, color: Colors.grey),
              labelText: "Jenis Bencana",
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
            height: 20,
          ),
          Text('Lokasi Bencana'),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: _kecamatan,
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
            controller: _desa,
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
          SizedBox(
            height: 20,
          ),
          Text('Koordinat bencana'),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: _controllerlong,
            enabled: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Garis Bujur",
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
            controller: _controllerlat,
            enabled: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Garis Lintang",
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
            height: 20,
          ),
          Text("Foto Lokasi"),
          SizedBox(
            height: 10,
          ),
          image == null
              ? Text('No image selected.')
              : Image.file(
                  image,
                  height: 200,
                  width: 200,
                ),
          RaisedButton(
            onPressed: () {
              // getImage();
              showBottomSheet();
            },
            child: Icon(Icons.camera),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: _keterangan,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Keterangan",
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
            height: 20,
          ),
          RaisedButton(
            onPressed: () {
              laporan();
            },
            color: Colors.red,
            child: Text(
              'KIRIM LAPORAN',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

// import 'dart:io';

// import 'package:bpbd/api_service/api.dart';
// import 'package:bpbd/screen/login_page/toast.dart';
// import 'package:dio/dio.dart';

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// // import 'package:image_picker_modern/image_picker_modern.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:ndialog/ndialog.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LaporanView extends StatefulWidget {
//   // static var routeName;
//   static const String routeName = '/LaporanView';

//   @override
//   _LaporanViewState createState() => _LaporanViewState();
// }

// class _LaporanViewState extends State<LaporanView> {
//   File _image;
//   final picker = ImagePicker();

//   String nama = '';
//   String namaPelapor = '';
//   String noHp = '';
//   String kecamatan ='';
//   String desa ='';
//   String jenisBencana ='';
//   String garisBujur='';
//   String garisLintang='';
//   String keterangan ='';

//   TextEditingController _namaPelapor = TextEditingController();
//   TextEditingController _noHp = TextEditingController();
//   TextEditingController _kecamatan = TextEditingController();
//   TextEditingController _desa = TextEditingController();
//   TextEditingController _jenisBencana = TextEditingController();
//   TextEditingController _keterangan = TextEditingController();

//   Future<bool>buatLaporan()async{
//   Dio dio= new Dio();
//   SharedPreferences preferences= await SharedPreferences.getInstance();
//   var id = preferences.get('id');
//   ProgressDialog pg = new ProgressDialog(context, message: Text('loading'));
//   pg.show();

//   var formdata = FormData.fromMap({
//     "id_users": "$id",
//     "no_hp": "${_noHp.text}",
//     "kecamatan": "${_kecamatan.text}",
//     "desa": "${_desa.text}",
//     "jenis_bencana": "${_jenisBencana.text}",
//     "garis_bujur": "${_controllerlong.text}",
//     "garis_lintang":"${_controllerlat.text}",
//     "keterangan": "${_keterangan.text}",
//     "foto":await MultipartFile.fromFile(_image.path.toString(),filename: _image.path.split('/').last.toString()),
//   });
//   print(formdata);
//   Response response;
//   response = await dio.post(ApiServer.buatLaporan,data: formdata);
//   print(response.statusMessage);
//   print(response.data);
//   print(_image.path);
//   if(response.statusCode==200){
//     ToastUtils.show("Laporan Anda Berhasil Terkirim");
//     pg.dismiss();
//     print(response.data);
//     if(response.data['code']==200){
//     Navigator.pop(context);
//     }
//   }
//     return true;
//   }
//   getsesion()async{
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   setState(() {
//     nama = preferences.get('nama');
//     });
//   }

//   Future getImage()async {
//     // final pickedFile = await picker.getImage(source: ImageSource.camera);
//     var image = await ImagePicker.pickImage(source: ImageSource.camera);
//     setState(() {
//       _image = image;
//     });
//   }

//   TextEditingController _controllerlat = TextEditingController();
//   TextEditingController _controllerlong = TextEditingController();
//   var location = new Location();

//   LatLng latLngDevice = new LatLng(0, 0);

//   void getLocation() async {
//     if (this.mounted) {
//       location.onLocationChanged().listen((LocationData currentLocation) {
//         try {
//           // getNameLocation(currentLocation.latitude, currentLocation.longitude);
//           // print(currentLocation.latitude);
//           setState(() {
//             latLngDevice =
//                 new LatLng(currentLocation.latitude, currentLocation.longitude);
//             _controllerlat.text = currentLocation.latitude.toString();
//             _controllerlong.text = currentLocation.longitude.toString();
//             // mapController.animateCamera(CameraUpdate.newCameraPosition(
//             //     CameraPosition(target: latLngDevice, zoom: 19.2)));
//           });
//         } catch (e) {}
//       });
//     }

//     print(latLngDevice);
//   }

//   @override
//   void initState() {
//     getLocation();
//     // DateTime _currentdate = new DateTime.now();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Center(
//           child: Text('Laporan Bencana',
//               style: GoogleFonts.lato(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20,
//               )),
//         ),
//         backgroundColor: Colors.deepOrange,
//       ),
//       body: ListView(
//         padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
//         children: <Widget>[
//           Text(
//             "!Isi Data Dengan Benar",
//             style: TextStyle(
//                 fontWeight: FontWeight.bold, fontSize: 12, color: Colors.red),
//           ),
//           SizedBox(height: 20),
//           TextField(
//             controller: _namaPelapor,
//             keyboardType: TextInputType.text,
//             decoration: InputDecoration(
//                 // hintText: "Nama",
//                 labelText: 'Nama',
//                 border: new OutlineInputBorder(
//                     borderRadius: new BorderRadius.circular(20.0))),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           TextField(
//             controller: _noHp,
//             keyboardType: TextInputType.phone,
//             decoration: InputDecoration(
//                 labelText: 'No.Telp/Hp',
//                 border: new OutlineInputBorder(
//                     borderRadius: new BorderRadius.circular(20.0))),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           TextField(
//             controller: _kecamatan,
//             keyboardType: TextInputType.text,
//             decoration: InputDecoration(
//                 labelText: 'Kecamatan',
//                 border: new OutlineInputBorder(
//                     borderRadius: new BorderRadius.circular(20.0))),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           TextField(
//             controller: _desa,
//             keyboardType: TextInputType.text,
//             decoration: InputDecoration(
//                 labelText: 'Desa',
//                 border: new OutlineInputBorder(
//                     borderRadius: new BorderRadius.circular(20.0))),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           TextField(
//             controller: _jenisBencana,
//             keyboardType: TextInputType.text,
//             decoration: InputDecoration(
//                 labelText: 'Jenis Bencana',
//                 border: new OutlineInputBorder(
//                     borderRadius: new BorderRadius.circular(20.0))),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Text("Lokasi Bencana"),
//           SizedBox(
//             height: 10,
//           ),
//           TextField(
//             controller: _controllerlong,
//             enabled: false,
//             keyboardType: TextInputType.text,
//             decoration: InputDecoration(
//                 labelText: 'Garis Bujur',
//                 border: new OutlineInputBorder(
//                     borderRadius: new BorderRadius.circular(20.0))),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           TextField(
//             controller: _controllerlat,
//             enabled: false,
//             keyboardType: TextInputType.text,
//             decoration: InputDecoration(
//                 labelText: 'Garis Lintang',
//                 border: new OutlineInputBorder(
//                     borderRadius: new BorderRadius.circular(20.0))),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Text("Foto Lokasi"),
//           SizedBox(
//             height: 10,
//           ),
//           _image == null
//               ? Text('No image selected.')
//               : Image.file(
//                   _image,
//                   height: 200,
//                   width: 200,
//                 ),
//           RaisedButton(
//             onPressed: () {
//               getImage();
//             },
//             child: Icon(Icons.camera),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           TextField(
//             controller: _keterangan,
//             maxLines: 5,
//             keyboardType: TextInputType.text,
//             decoration: InputDecoration(
//                 labelText: 'Keterangan',
//                 border: new OutlineInputBorder(
//                     borderRadius: new BorderRadius.circular(20.0))),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           RaisedButton(
//             onPressed: () {
//               buatLaporan();
//             },
//             color: Colors.red,
//             child: Text(
//               'KIRIM LAPORAN',
//               style: TextStyle(color: Colors.white),
//             ),
//           )
//         ],
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () {
//       //     getImage();
//       //   },
//       //   child: Icon(Icons.camera),
//       // ),
//     );
//   }
// }
