import 'package:bpbd/models/m_berita.dart';
import 'package:bpbd/provider/p_berita.dart';
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

class VAllBerita extends StatefulWidget {
  @override
  _VAllBeritaState createState() => _VAllBeritaState();
}

class _VAllBeritaState extends State<VAllBerita> {

  @override
  void initState() {
    @override
    // ignore: unused_element
    void initState() {
      Provider.of<ProviderBerita>(context,listen: false).getBerita();
      initializeDateFormatting("id-ID");
      super.initState();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text("Berita"),

      ),
      body: Consumer<ProviderBerita>(builder: (context,data,_){
        if(data.modelBerita==null){
          return Center(
            child: CircularProgressIndicator(),
          );
        }else{
          if(data.modelBerita.totalResults==0){
            return Center(
              child: Text("Berita Kosong",style: GoogleFonts.pTSansCaption(fontWeight: FontWeight.bold),),
            );
          }else{
            return  ListView.builder(
              shrinkWrap: true,
              itemCount: data.modelBerita.articles.length,

              itemBuilder: (c, i) {
                return CardBencana(
                  onPressed: (){
                    detailBerita(context,data.modelBerita.articles[i]);
                  },
                  urlImage: data.modelBerita.articles[i].urlToImage,
                  newBencana: false,
                  title: data.modelBerita.articles[i].title,
                  status: DateFormat("EEEE, dd MMMM yyyy","id-ID").format(data.modelBerita.articles[i].publishedAt),
                  lokasi: data.modelBerita.articles[i].source.name,
                  subtitle: data.modelBerita.articles[i].description,
                );
              },
            );
          }
        }
      },),
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
