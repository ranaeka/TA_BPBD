import 'package:bpbd/provider/p_berita.dart';
// ignore: unused_import
import 'package:bpbd/screen/detail_laporan.dart';
import 'package:bpbd/screen/detail_riwayat_laporan.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../api_service/api.dart';
import '../../widgets/widget.dart';

class VRiyawatPelapor extends StatefulWidget {
  @override
  _VRiyawatPelaporState createState() => _VRiyawatPelaporState();
}

class _VRiyawatPelaporState extends State<VRiyawatPelapor> {


  @override
  void initState() {
    Provider.of<ProviderBerita>(context,listen: false).getRiwayatLaporan(isMe: true);
    initializeDateFormatting("id-ID");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text("Riwayat Laporan"),
      ),
      body: MediaQuery.removePadding(context: context,removeTop: true,
      child:Consumer<ProviderBerita>(builder: (context,data,_){
        if(data.riwayatLaporan==null){
          return Center(
            child: CircularProgressIndicator(),
          );
        }else{
          if(data.riwayatLaporan.data.length==0){
            return Center(
              child: Text("Laporan Kosong",style: GoogleFonts.pTSansCaption(fontWeight: FontWeight.bold),),
            );
          }else{
            return  ListView.builder(
              shrinkWrap: true,
              itemCount: data.riwayatLaporan.data.length,
              itemBuilder: (c, i) {
                 return Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: InkWell(
                     onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>VDetailRiwayatLaporan(dataLaporan: data.riwayatLaporan.data[i],isRiyawat: true,))),
                     child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.only(bottom: 5, top: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10)),
                                child: CachedNetworkImage(
                                  imageUrl:
                                  "${ApiServer.rootfoto}/${data.riwayatLaporan.data[i].fotoLaporan}",
                                  fit: BoxFit.fitWidth,
                                  width:double.infinity,
                                  height: MediaQuery.of(context).size.height*0.3,
                                  placeholder: (c, s) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, s, o) =>
                                      Image.asset(
                                        'assets/sosial.jpg',
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 150,
                                      ),
                                ),
                              ),
                              Positioned(
                                right: -4,
                                top: 0,
                                child:  Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(14)),
                                      color: Colors.orange
                                  ),
                                  child: Text("${data.riwayatLaporan.data[i].detailJenisBencana.jenisBencana}",style: GoogleFonts.pTSans(color: Colors.white),),
                                ),
                              )
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left:8.0,right: 8,top: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${data.riwayatLaporan.data[i].detailJenisBencana.jenisBencana} | ${data.riwayatLaporan.data[i].detailBencana.namaBencana}",style: GoogleFonts.pTSansCaption(fontWeight: FontWeight.bold,fontSize: 16),),

                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:8.0,right: 8,bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${data.riwayatLaporan.data[i].garisLintang},${data.riwayatLaporan.data[i].garisBujur}, "+DateFormat("EEEE, dd MMMM yyyy","id-ID").format(data.riwayatLaporan.data[i].createdAt)+", ${data.riwayatLaporan.data[i].desa}",style: GoogleFonts.pTSansCaption(fontStyle: FontStyle.italic,fontSize: 12),),

                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 5.0, right: 5, top: 5,bottom: 10),
                            child: Container(
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
                                    Icon(Feather.clock,color: Colors.white,size: 10,),
                                    SizedBox(width: 5,),
                                    Text("${data.riwayatLaporan.data[i].statusLaporan}"
                                      ,
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 10),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),

                                  ],
                                )),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left:8.0,right: 8),
                            child: SelectableText(data.riwayatLaporan.data[i].keterangan,style: GoogleFonts.pTSansCaption(fontSize: 12),),
                          )
                        ],
                      ),
                ),
                   ),
                 );
              },
            );
          }
        }
      },),
      ),
    );
  }
}
