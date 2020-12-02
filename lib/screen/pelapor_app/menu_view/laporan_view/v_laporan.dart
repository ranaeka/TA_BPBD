// import 'package:bpbd/api_service/api.dart';
import 'dart:async';
import 'dart:io';

import 'package:bpbd/api_service/api.dart';
import 'package:bpbd/provider/p_berita.dart';
import 'package:bpbd/screen/login_page/toast.dart';
import 'package:bpbd/screen/widgets/widget.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:ndialog/ndialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
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

  List<File> files = [];

//  List<PlatformFile> _paths;

  Future<void> getFile() async {
    if(files.isEmpty){
      var file = await picker.getImage(
        source: ImageSource.camera,
        imageQuality: 30,
      );

      files.add(File(file.path));


      if (files != null) {
        setState(() {
          // files = result.paths.map((path) => File(path)).toList();
        });
      } else {
        // User canceled the picker
      }
    }else{
      var file = await picker.getImage(
          source: ImageSource.camera
      );
      files.clear();
      files.add(File(file.path));
    }
  }

  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;

//  static const LatLng _center = const LatLng(-6.4082937, 108.2797067);
  final Set<Marker> _markers = {};
  // ignore: unused_field
  LatLng _lastMapPosition;

  String nama = '';
  String namaPelapor = '';
  String noHp = '';
  String kecamatan = '';
  String desa = '';
  String jenisBencana = '';
  String garisBujur = '';
  String garisLintang = '';
  String keterangan = '';
  var idJenisBencana="";
  var selectedJenisBencana="Bencana alam";
  var idBencana="";
  var selectedBencana="";


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
          getNameLocation(currentLocation.latitude, currentLocation.longitude);
          // print(currentLocation.latitude);
          setState(() {
            latLngDevice =
                new LatLng(currentLocation.latitude, currentLocation.longitude);
            _controllerlat.text = currentLocation.latitude.toString();
            _controllerlong.text = currentLocation.longitude.toString();
            _markers.add(Marker(
                markerId: MarkerId('SomeId'),
                position: latLngDevice,
                infoWindow: InfoWindow(
                    title: _kecamatan.toString()
                )
            ));
            mapController.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(target: latLngDevice, zoom: 19.2)));
          });
        } catch (e) {}
      });
    }

    print(latLngDevice);
  }

  void getNameLocation(double lat, double long) async {
    if(this.mounted){
      final coordinates = new Coordinates(lat, long);
      try {
        // ignore: unused_local_variable
        var addresses = await Geocoder.local
            .findAddressesFromCoordinates(coordinates)
            .then((address) {
          setState(() {
            // ignore: unused_local_variable
            var first = address.first.locality;
            print("Sub area "+address.first.subAdminArea);
            _desa.text=address.first.subLocality;
            _kecamatan.text=address.first.locality;
            print(address.first.locality);
            print(address.first.subLocality);

          });
        });
      // ignore: unused_catch_clause
      } on PlatformException catch (e) {}
    }
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


  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _controller.complete(controller);
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
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
                 getFile();
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
    print(idJenisBencana);
    print(idBencana);
    print(_keterangan.text);
    // print(image.path);
    FormData formdata = FormData.fromMap({
      "id_pelapor": "${id.toString()}",
      "no_hp": "${_noHp.text}",
      "kecamatan": "${_kecamatan.text}",
      "desa": "${_desa.text}",
      "id_jenis_bencana": "$idJenisBencana",
      "id_bencana" : "$idBencana",
      "garis_bujur": "${_controllerlong.text}",
      "garis_lintang": "${_controllerlat.text}",
      "keterangan": "${_keterangan.text}",
      "foto": await MultipartFile.fromFile(files[0].path.toString(),
          filename: files[0].path.split('/').last)
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
  void initState() {
    getLocation();
    getsesion();
    Provider.of<ProviderBerita>(context,listen: false).getJenisBencana().then((value) {
      setState(() {
        selectedJenisBencana=value.data[0].jenisBencana;
        idJenisBencana=value.data[0].idJenisBencana.toString();
        Provider.of<ProviderBerita>(context,listen: false).getBencana(context: context,id: value.data[0].idJenisBencana.toString()).then((value) {
          setState(() {
            selectedBencana=value.data[0].namaBencana;
            idBencana=value.data[0].idBencana.toString();


          });
        });

      });
    });
    super.initState();
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
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        children: <Widget>[
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.only(left: 10,top: 4,right: 10,bottom: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.deepOrange
              ),
              child: Text(
                "!Silahkan isi form dibawah dengan benar kemudian klik tombol kirim",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: ScreenConfig.blockHorizontal*3.2,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
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
                  Text('Informasi Bencana',style: GoogleFonts.pTSansCaption(fontWeight: FontWeight.bold),),
                  TextField(
                    controller: _namaPelapor,
                    enabled: false,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      // icon: Icon(Icons.person, color: Colors.grey),
                      labelText: "Nama Pelapor",
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
                  //
                 Consumer<ProviderBerita>(builder: (context,data,_){
                   if(data.jenisBencana!=null){
                    if(data.jenisBencana.data.length!=null){
                      return  Container(
                        width: double.infinity,
                        child: DropdownButton(
                          isExpanded: true,
                          hint: Text("Pilih Jenis Bencana"),
                          value: selectedJenisBencana!=null ?selectedJenisBencana : null,
                          items: data.jenisBencana.data.length==0 ? [] : data.jenisBencana.data.map((item) {
                            return DropdownMenuItem(
                              child: Text(item.jenisBencana),
                              value: item.jenisBencana.toString(),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedJenisBencana = value;
                              // ignore: unused_local_variable
                              var id;
                              data.jenisBencana.data.forEach((element) {
                                if(element.jenisBencana.toLowerCase()==value.toString().toLowerCase()){
                                  idJenisBencana=element.idJenisBencana.toString();
                                  Provider.of<ProviderBerita>(context,listen: false).getBencana(context: context,id: idJenisBencana).then((value) {
                                    setState(() {
                                      selectedBencana=value.data[0].namaBencana;
                                      idBencana=value.data[0].idBencana.toString();


                                    });
                                  });
                                }
                              });

                            });
                          },
                        ),
                      );
                    }else{
                      return Container();
                    }
                   }else{
                     return Container();
                   }
                 }),
                  Consumer<ProviderBerita>(builder: (context,data,_){
                    if(data.bencana!=null){
                      if(data.bencana.data.length!=null){
                        return  Container(
                          width: double.infinity,
                          child: DropdownButton(
                            isExpanded: true,
                            hint: Text("Pilih Jenis Bencana"),
                            value: selectedBencana!=null ?selectedBencana : null,
                            items: data.bencana.data.length==0 ? [] : data.bencana.data.map((item) {
                              return DropdownMenuItem(
                                child: Text(item.namaBencana),
                                value: item.namaBencana.toString(),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedBencana = value;
                                data.bencana.data.forEach((element) {
                                  if(element.namaBencana.toLowerCase()==value.toString().toLowerCase()){
                                    idBencana=element.idBencana.toString();
                                  }
                                });
                              });
                            },
                          ),
                        );
                      }else{
                        return Container();
                      }
                    }else{
                      return Container();
                    }
                  }),
                  TextField(
                    controller: _keterangan,
                    keyboardType: TextInputType.multiline,
                    maxLength: 255,
                    minLines: 1,
                    maxLines: 5,
                    textInputAction: TextInputAction.newline,
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
                ],
              ),
            ),
          ),


          SizedBox(
            height: 10,
          ),
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
                    controller: _kecamatan,
                    enabled: false,
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
                    enabled: false,
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


          SizedBox(
            height: 10,
          ),
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
                  Text('Foto Lokasi Bencana',style: GoogleFonts.pTSansCaption(fontWeight: FontWeight.bold),),
                  files.length == 0
                      ? InkWell(
                    onTap: getFile,
                    child: Row(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          margin: EdgeInsets.all(4),
                          child: DottedBorder(
                            color: Colors.black,
                            strokeWidth: 1,
                            borderType: BorderType.RRect,
                            child: Container(
                                height: 100,
                                width: 100,
                                padding: EdgeInsets.all(8),
                                alignment: Alignment.center,
                                child: Icon(Icons.camera_enhance)),
                          ),
                        ),
                      ],
                    ),
                  )
                      : GridView.builder(
                      itemCount: files.length + 1,
                      shrinkWrap: true,
                      gridDelegate:
                      new SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4),
                      itemBuilder: (BuildContext context, int index) {
                        if ((index + 1) == (files.length + 1)) {
                          return InkWell(
                            onTap: getFile,
                            child: Container(
                              margin: EdgeInsets.all(4),
                              child: DottedBorder(
                                color: Colors.black,
                                strokeWidth: 1,
                                borderType: BorderType.RRect,
                                child: Container(
                                    height: 100,
                                    width: 100,
                                    padding: EdgeInsets.all(8),
                                    alignment: Alignment.center,
                                    child: Icon(Icons.camera_enhance)),
                              ),
                            ),
                          );
                        }
                        return InkWell(
                          onLongPress: ()async{
                            await showDialog(
                              context: context,
                              child:new AlertDialog(
                                content: Text("Delete From List ?"
                                ),
                                actions: [
                                  FlatButton(
                                    onPressed: (){
                                      setState(() {
                                        files.removeAt(index);
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Text("Yes"),
                                  ),
                                  FlatButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                    child: Text("No"),
                                  )
                                ],
                              ),
                            );
                          },
                          child: Container(
                              height: 100,
                              width: 100,
//                        decoration: BoxDecoration(
//                          borderRadius: BorderRadius.circular(4)
//                        ),
                              margin: EdgeInsets.all(4),
//                        color: Colors.redAccent,
                              child: Image.file(File(files[index].path),fit: BoxFit.cover,)),
                        );
                      }),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
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
                  Text('Koordinat Bencana',style: GoogleFonts.pTSansCaption(fontWeight: FontWeight.bold),),
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

                  Container(
                    height: 200,
                    width: double.infinity,
                    child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: latLngDevice,
                        zoom: 30.0,
                      ),
                      mapType: MapType.normal,
                      markers: _markers,
                      onCameraMove: _onCameraMove,
                      myLocationEnabled: true,
                      mapToolbarEnabled: false,
                      zoomGesturesEnabled: false,
                      scrollGesturesEnabled: false,
                    ),
                  )
                ],
              ),
            ),
          ),

          SizedBox(
            height: 20,
          ),





          Container(
            height: 45,
            child: RaisedButton(
              onPressed: () {
                laporan();
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              color: Colors.red,
              child: Text(
                'KIRIM LAPORAN',
                style: TextStyle(color: Colors.white),
              ),
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
