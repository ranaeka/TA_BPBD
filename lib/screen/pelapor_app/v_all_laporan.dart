import 'package:bpbd/models/m_berita.dart';
import 'package:bpbd/provider/p_berita.dart';
import 'package:bpbd/screen/detail_laporan.dart';
// ignore: unused_import
import 'package:bpbd/screen/widgets/card_bencana.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../api_service/api.dart';
import '../widgets/widget.dart';

class VAllLaporan extends StatefulWidget {
  @override
  _VAllLaporanState createState() => _VAllLaporanState();
}

class _VAllLaporanState extends State<VAllLaporan> {

  @override
  void initState() {
    @override
    // ignore: unused_element
    void initState() {
      Provider.of<ProviderBerita>(context,listen: false).getLaporan();
      initializeDateFormatting("id-ID");
      super.initState();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   ScreenConfig().init(context);
   return Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.deepOrange,
       title: Text("Laporan"),
     ),
     body: MediaQuery.removePadding(context: context,removeTop: true,
       child:Consumer<ProviderBerita>(builder: (context,data,_){
         if(data.modelLaporan==null){
           return Center(
             child: CircularProgressIndicator(),
           );
         }else{
           if(data.modelLaporan.data.length==0){
             return Center(
               child: Text("Laporan Kosong",style: GoogleFonts.pTSansCaption(fontWeight: FontWeight.bold),),
             );
           }else{
             return  ListView.builder(
               shrinkWrap: true,
               itemCount: data.modelLaporan.data.length,

               itemBuilder: (c, i) {
                 return Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Card(
                     elevation: 2,
                     shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(10)),
                     margin: const EdgeInsets.only(bottom: 5, top: 5),
                     child: InkWell(
                       onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>VDetailLaporan(dataLaporan: data.modelLaporan.data[i],))),
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
                                   "${ApiServer.rootfoto}/${data.modelLaporan.data[i].fotoLaporan}",
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
                                   child: Text("${data.modelLaporan.data[i].detailJenisBencana.jenisBencana}",style: GoogleFonts.pTSans(color: Colors.white),),
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
                                 Text("${data.modelLaporan.data[i].detailJenisBencana.jenisBencana} | ${data.modelLaporan.data[i].detailBencana.namaBencana}",style: GoogleFonts.pTSansCaption(fontWeight: FontWeight.bold,fontSize: 16),),

                               ],
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.only(left:8.0,right: 8,bottom: 8),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text("${data.modelLaporan.data[i].garisLintang},${data.modelLaporan.data[i].garisBujur}, "+DateFormat("EEEE, dd MMMM yyyy","id-ID").format(data.modelLaporan.data[i].createdAt)+", ${data.modelLaporan.data[i].desa}",style: GoogleFonts.pTSansCaption(fontStyle: FontStyle.italic,fontSize: 12),),

                               ],
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.only(
                                 left: 5.0, right: 5, top: 5,bottom: 3),
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
                                     Text("${data.modelLaporan.data[i].statusLaporan}"
                                       ,
                                       style: GoogleFonts.poppins(
                                           color: Colors.white,
                                           fontSize: 10),
                                       overflow: TextOverflow.ellipsis,
                                       maxLines: 2,
                                     ),
                                     SizedBox(width: 5,),
                                     Icon(Feather.user,color: Colors.white,size: 10,),
                                     SizedBox(width: 5,),
                                     Text(data.modelLaporan.data[i].detailPelapor!=null ?"${data.modelLaporan.data[i].detailPelapor.nama}" : "-"
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
                             child: SelectableText(data.modelLaporan.data[i].keterangan,style: GoogleFonts.pTSansCaption(fontSize: 12),),
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


  Future<Widget> detailBerita(BuildContext context,Article article) async {
    return showMaterialModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10))),
      elevation: 3,
//                                          barrierColor: Colors.red,

      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: MediaQuery.removePadding(context: context,
          removeTop: true,
          child: ListView(
            // controller: scrollController,
            physics: ClampingScrollPhysics(),
            children: [
              SizedBox(height: 5,),
              Center(
                child: Container(
                    width: 50,
                    height: 20,
                    child: Divider(thickness: 3,)),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  imageUrl:
                  "${article.urlToImage}",
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
                        height: 150,
                      ),
                ),
              ),
              SizedBox(height: 10,),
              Text(article.title,style: GoogleFonts.pTSansCaption(fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, right: 0, top: 0),
                child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(10),
                        color: Colors.green),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Feather.clock,color: Colors.white,size: 10,),
                        SizedBox(width: 5,),
                        Text(DateFormat("EEEE, dd MMMM yyyy","id-ID").format(article.publishedAt)
                          ,
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 10,
                          fontStyle: FontStyle.italic),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        SizedBox(width: 5,),
                        Icon(Feather.map_pin,color: Colors.white,size: 10,),
                        SizedBox(width: 5,),
                        Text(article.source.name
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
              SizedBox(height: 10,),
              SelectableText(article.content,style: GoogleFonts.poppins(fontSize: 12),),
              FlatButton(
                onPressed: (){
                  _launchURL(article.url);
                },
                child: Text("Baca Selengkapnya",style: GoogleFonts.poppins(color: Colors.blue),),
              )
            ],
          ),
        ),
      ),
    );
  }
  _launchURL(String url) async {

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
