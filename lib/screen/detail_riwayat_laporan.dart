import 'dart:async';

import 'package:bpbd/api_service/api.dart';
import 'package:bpbd/models/m_laporan.dart';
import 'package:bpbd/models/m_riyawat_laporan.dart';
import 'package:bpbd/provider/p_berita.dart';
import 'package:bpbd/screen/widgets/widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_dialog/awesome_dialog.dart';


class VDetailRiwayatLaporan extends StatefulWidget {
  final DataRiwayatLaporan dataLaporan;
  final bool isRiyawat;

  const VDetailRiwayatLaporan({Key key, this.dataLaporan, this.isRiyawat=false}) : super(key: key);
  @override
  _VDetailRiwayatLaporanState createState() => _VDetailRiwayatLaporanState();
}

class _VDetailRiwayatLaporanState extends State<VDetailRiwayatLaporan> {

  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  var location = new Location();
  LatLng latLngDevice = new LatLng(0, 0);
  var level;

//  static const LatLng _center = const LatLng(-6.4082937, 108.2797067);
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _controller.complete(controller);
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }
  Future<void> getMaps()async{
    setState(() {
      latLngDevice=new LatLng(double.parse(widget.dataLaporan.garisLintang), double.parse(widget.dataLaporan.garisBujur));
      _markers.add(Marker(
          markerId: MarkerId('SomeId'),
          position: latLngDevice,
          infoWindow: InfoWindow(
              title: widget.dataLaporan.kecamatan
          )
      ));
      mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: latLngDevice, zoom: 19.2)));
    });
  }


  void acceptLaporan() async {

    AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Laporan',
        dismissOnTouchOutside: false,
        desc: 'Apakah Ingin Menindak Lanjuti Laporan ini ?',
        btnCancelOnPress: () {

        },
        btnOkOnPress: () async {

        }).show();
  }

  void deleteLaporan({BuildContext context,String id}) async {

    AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Laporan',
        dismissOnTouchOutside: false,
        desc: 'Apakah Ingin Menghapus Laporan ?',
        btnCancelOnPress: () {
          // Navigator.pop(context);
        },
        btnOkOnPress: () async {
          Provider.of<ProviderBerita>(context,listen: false).deleteLaporan(context: context,id: id);
        }).show();
  }

  Future<void> getSession()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    setState(() {
      level=prefs.get("level");
    });
  }

  @override
  void initState() {
    getMaps();
    getSession();
    print(widget.dataLaporan.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text("Detail Laporan"),
        actions: [
         level=="Petugas" ?  IconButton(
           onPressed: acceptLaporan,
           icon: Icon(Icons.check_circle,color: Colors.white,),
         ) : Container(),
          widget.isRiyawat ?  IconButton(
            onPressed: ()=>deleteLaporan(context: context,id:widget.dataLaporan.id.toString()),
            icon: Icon(Feather.delete,color: Colors.white,),
          ) : Container()
        ],
      ),
      body: MediaQuery.removePadding(context: context,removeTop: true,
      child: ListView(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        children: [
          ClipRRect(
            child: CachedNetworkImage(
              imageUrl:
              "${ApiServer.rootfoto}/${widget.dataLaporan.fotoLaporan}",
              fit: BoxFit.fitWidth,
              width:double.infinity,
              height: 200,
              placeholder: (c, s) => Center(
                  child: CircularProgressIndicator()),
              errorWidget: (context, s, o) =>
                  Image.asset(
                    'assets/sosial.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                  ),
            ),
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
                  Text("Informasi Bencana",style: GoogleFonts.pTSansCaption(fontWeight: FontWeight.bold),),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Tanggal Pelaporan",style: GoogleFonts.pTSansCaption(fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: 5,
                            ),
                            Text(DateFormat("EEEE, dd MMMM yyyy","id-ID").format(widget.dataLaporan.createdAt),style: GoogleFonts.pTSansCaption(),),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Status Pelaporan",style: GoogleFonts.pTSansCaption(fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 2),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    color: Colors.green),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("${widget.dataLaporan.statusLaporan}"
                                      ,
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 10),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),


                                  ],
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                 SizedBox(height: 20,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Flexible(
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text("Nama Bencana",style: GoogleFonts.pTSansCaption(fontWeight: FontWeight.bold),),
                           SizedBox(
                             height: 5,
                           ),
                           Text(widget.dataLaporan.detailBencana.namaBencana,style: GoogleFonts.pTSansCaption(),),
                         ],
                       ),
                     ),
                     Flexible(
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.end,
                         crossAxisAlignment: CrossAxisAlignment.end,
                         children: [
                           Text("Jenis Bencana",style: GoogleFonts.pTSansCaption(fontWeight: FontWeight.bold),),
                           SizedBox(
                             height: 5,
                           ),
                           Text(widget.dataLaporan.detailJenisBencana.jenisBencana,style: GoogleFonts.pTSansCaption(),),
                         ],
                       ),
                     ),
                   ],
                 )
                ],
              ),
            ),
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
                  Text("Tindak Lanjut",style: GoogleFonts.pTSansCaption(fontWeight: FontWeight.bold),),
                  SizedBox(
                    height: 10,
                  ),
                  SelectableText("${widget.dataLaporan.tindakLanjut}",style: GoogleFonts.pTSansCaption(),),
                ],
              ),
            ),
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
                  Text("Lokasi Bencana",style: GoogleFonts.pTSansCaption(fontWeight: FontWeight.bold),),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Desa",style: GoogleFonts.pTSansCaption(fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: 5,
                            ),
                            Text(widget.dataLaporan.desa,style: GoogleFonts.pTSansCaption(),),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Kecamatan",style: GoogleFonts.pTSansCaption(fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: 5,
                            ),
                            Text(widget.dataLaporan.kecamatan,style: GoogleFonts.pTSansCaption(),),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Garis Lintang",style: GoogleFonts.pTSansCaption(fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: 5,
                            ),
                            Text(widget.dataLaporan.garisLintang,style: GoogleFonts.pTSansCaption(),),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Garis Bujur",style: GoogleFonts.pTSansCaption(fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: 5,
                            ),
                            Text(widget.dataLaporan.garisBujur,style: GoogleFonts.pTSansCaption(),),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Container(
                    height: 250,
                    width: double.infinity,
                  child:  GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: latLngDevice,
                      zoom: 30.0,
                    ),
                    mapType: MapType.normal,
                    markers: _markers,
                    onCameraMove: _onCameraMove,
                    myLocationEnabled: false,
                    mapToolbarEnabled: true,
                    zoomGesturesEnabled: true,
                    scrollGesturesEnabled: true,

                  ),
                  )
                ],
              ),
            ),
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
                  Text("Informasi Pelapor",style: GoogleFonts.pTSansCaption(fontWeight: FontWeight.bold),),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Nama Pelapor",style: GoogleFonts.pTSansCaption(fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: 5,
                            ),
                            Text(widget.dataLaporan.detailPelapor.nama,style: GoogleFonts.pTSansCaption(),),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("No Telephon",style: GoogleFonts.pTSansCaption(fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 2),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    color: Colors.green),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("${widget.dataLaporan.noHp}"
                                      ,
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 10),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),


                                  ],
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Email",style: GoogleFonts.pTSansCaption(fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: 5,
                            ),
                            Text(widget.dataLaporan.detailPelapor.email,style: GoogleFonts.pTSansCaption(),),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Alamat",style: GoogleFonts.pTSansCaption(fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: 5,
                            ),
                            Text(widget.dataLaporan.detailPelapor.alamat,style: GoogleFonts.pTSansCaption(),),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 5,),
         widget.dataLaporan.detailPetugas==null ? Container() :  Card(
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
                 Text("Informasi Petugas",style: GoogleFonts.pTSansCaption(fontWeight: FontWeight.bold),),
                 SizedBox(
                   height: 10,
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Flexible(
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text("Nama Petugas",style: GoogleFonts.pTSansCaption(fontWeight: FontWeight.bold),),
                           SizedBox(
                             height: 5,
                           ),
                           Text(widget.dataLaporan.detailPetugas.nama,style: GoogleFonts.pTSansCaption(),),
                         ],
                       ),
                     ),
                     Flexible(
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.end,
                         crossAxisAlignment: CrossAxisAlignment.end,
                         children: [
                           Text("No Telephon",style: GoogleFonts.pTSansCaption(fontWeight: FontWeight.bold),),
                           SizedBox(
                             height: 5,
                           ),
                           Container(
                               padding: EdgeInsets.symmetric(
                                   horizontal: 10, vertical: 2),
                               decoration: BoxDecoration(
                                   borderRadius:
                                   BorderRadius.circular(10),
                                   color: Colors.green),
                               child: Row(
                                 mainAxisSize: MainAxisSize.min,
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 children: [
                                   Text("${widget.dataLaporan.detailPetugas.noHp}"
                                     ,
                                     style: GoogleFonts.poppins(
                                         color: Colors.white,
                                         fontSize: 10),
                                     overflow: TextOverflow.ellipsis,
                                     maxLines: 2,
                                   ),


                                 ],
                               )),
                         ],
                       ),
                     ),
                   ],
                 ),
                 SizedBox(height: 20,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Flexible(
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text("NIK",style: GoogleFonts.pTSansCaption(fontWeight: FontWeight.bold),),
                           SizedBox(
                             height: 5,
                           ),
                           Text("${widget.dataLaporan.detailPetugas.nik}",style: GoogleFonts.pTSansCaption(),),
                         ],
                       ),
                     ),
                     Flexible(
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.end,
                         crossAxisAlignment: CrossAxisAlignment.end,
                         children: [
                           Text("Alamat",style: GoogleFonts.pTSansCaption(fontWeight: FontWeight.bold),),
                           SizedBox(
                             height: 5,
                           ),
                           Text(widget.dataLaporan.detailPetugas.alamat,style: GoogleFonts.pTSansCaption(),),
                         ],
                       ),
                     ),
                   ],
                 )
               ],
             ),
           ),
         ),
        ],
      ),),
    );
  }
}
