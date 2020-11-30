import 'package:bpbd/models/m_berita.dart';
import 'package:bpbd/provider/p_berita.dart';
import 'package:bpbd/screen/detail_laporan.dart';
import 'package:bpbd/screen/detatil_bencana.dart';
import 'package:bpbd/screen/pelapor_app/menu_view/info_bencana_view/v_info_bencana.dart';
import 'package:bpbd/screen/pelapor_app/menu_view/kontak_bpbd_view/v_kontakbpbd_view.dart';
import 'package:bpbd/screen/pelapor_app/menu_view/laporan_view/v_laporan.dart';

import 'package:bpbd/screen/pelapor_app/v_all_berita.dart';
import 'package:bpbd/screen/pelapor_app/v_all_laporan.dart';
import 'package:bpbd/screen/petugas_app/Page_view/index_petugas.dart';
import 'package:bpbd/screen/petugas_app/menu_view/profil_petugas/profil_petugas.dart';
import 'package:bpbd/screen/widgets/button_home.dart';
import 'package:bpbd/screen/widgets/card_bencana.dart';
import 'package:bpbd/screen/widgets/widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../api_service/api.dart';

class HomePetugas extends StatefulWidget {
  // static var routeName;
  static const String routeName = '/HomePetugas';

  @override
  _HomePetugasState createState() => _HomePetugasState();
}

class _HomePetugasState extends State<HomePetugas> {


  @override
  void initState() {
    Provider.of<ProviderBerita>(context,listen: false).getBerita();
    Provider.of<ProviderBerita>(context,listen: false).getLaporan(isMe: false);
    initializeDateFormatting("id-ID");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 170,
                padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
                decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              elevation: 2,
                              color: Colors.white.withOpacity(1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    "assets/bpbd.png",
                                    height: 35,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Badan Penanggulangan Bencana Daerah",
                                  style: GoogleFonts.pTSansCaption(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textScaleFactor: 1.1,
                                ),
                                Text(
                                  "Kabupaten Indramayu",
                                  style: GoogleFonts.pTSansCaption(
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic),
                                  textScaleFactor: 1,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ButtonHome(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilPetugasView()));
                          },
                          title: "Profile",
                          iconData: Icons.account_circle,
                        ),
                        ButtonHome(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InfoBencanaView()));
                          },
                          title: "Tentang Bencana",
                          iconData: Icons.collections_bookmark,
                        ),
                        ButtonHome(
                          onPressed: () {
                            contactBpbd(context);
                          },
                          title: "Kontak BPBD",
                          iconData: Icons.phone_android,
                        ),

                      ],
                    )
                  ],
                ),
              )),
          Positioned(
              top: 176,
              left: 10,
              right: 10,
              bottom: 10,
              child: MediaQuery.removePadding(context: context,
                removeTop: true,
                child: ListView(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Laporan Terbaru",
                            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                          ),
                          FlatButton(
                              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>VAllLaporan())),
                              child: Text(
                                "Lihat Semua",
                                style: GoogleFonts.poppins(),
                              )),
                        ],
                      ),
                    ),
                    Container(
                        height: 300,
                        width: 280,
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
                                itemCount: 5,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (c, i) {
                                  return CardBencana(
                                    newBencana: true,
                                    visibelDate: true,
                                    onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>VDetailLaporan(dataLaporan: data.modelLaporan.data[i],))),
                                    date: "${data.modelLaporan.data[i].garisLintang},${data.modelLaporan.data[i].garisBujur}, "+DateFormat("EEEE, dd MMMM yyyy","id-ID").format(data.modelLaporan.data[i].createdAt),
                                    urlImage: "${ApiServer.rootfoto}/${data.modelLaporan.data[i].fotoLaporan}",
                                    title: "${data.modelLaporan.data[i].detailJenisBencana.jenisBencana} | ${data.modelLaporan.data[i].detailBencana.namaBencana}",
                                    status: data.modelLaporan.data[i].statusLaporan,
                                    lokasi: data.modelLaporan.data[i].desa+"-" + data.modelLaporan.data[i].kecamatan,
                                    subtitle: data.modelLaporan.data[i].keterangan,

                                  );
                                },
                              );
                            }
                          }
                        },),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(left:2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Berita Terbaru",
                            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                          ),
                          FlatButton(
                              onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (context)=>VAllBerita())),
                              child: Text(
                                "Lihat Semua",
                                style: GoogleFonts.poppins(),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      height: 300,
                      width: 280,
                      child: Consumer<ProviderBerita>(builder: (context,data,_){
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
                              itemCount: 10,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (c, i) {
                                return CardBencana(
                                  onPressed: (){
                                    detailBerita(context, data.modelBerita.articles[i]);
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
                    ),
                  ],
                ),
              ),
              )
        ],
      ),
    );
  }


  _launchURL({String url}) async {
    if(url.isEmpty){
      url = 'https://bpbd.indramayukab.go.id/';
    }

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
                  _launchURL(url:article.url);
                },
                child: Text("Baca Selengkapnya",style: GoogleFonts.poppins(color: Colors.blue),),
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<Widget> contactBpbd(BuildContext context) async {
    return showMaterialModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10))),
      elevation: 3,
//                                          barrierColor: Colors.red,

      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          // controller: scrollController,
          physics: ClampingScrollPhysics(),
          children: [
            Image.asset(
              "assets/bpbd.png",
              height: 80,
              width: 80,
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "Badan Penanggulangan Bencana Daerah",
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenConfig.blockHorizontal * 3.5,
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                "Kabupaten Indramayu",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenConfig.blockHorizontal * 3.5,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ListTile(
              leading: Icon(
                Feather.home,
                size: 45,
                color: Colors.deepOrange,
              ),
              title: Text("Alamat Kantor"),
              subtitle: SelectableText(
                'Jalan Pahlawan No. 62/A Indramayu',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenConfig.blockHorizontal * 3.5,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(
                thickness: 2,
              ),
            ),
            ListTile(
              leading: Icon(
                Feather.phone_call,
                size: 45,
                color: Colors.deepOrange,
              ),
              title: Text("Telephon Kantor"),
              subtitle: SelectableText(
                '0234-277721',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenConfig.blockHorizontal * 3.5,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(
                thickness: 2,
              ),
            ),
            ListTile(
              leading: Icon(
                Feather.chrome,
                size: 45,
                color: Colors.deepOrange,
              ),
              title: Text("Website"),
              subtitle: InkWell(
                onTap: _launchURL,
                child: SelectableText(
                  'bpbd.indramayukab.go.id',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenConfig.blockHorizontal * 3.5,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(
                thickness: 2,
              ),
            ),
            ListTile(
              leading: Icon(
                Feather.mail,
                size: 45,
                color: Colors.deepOrange,
              ),
              title: Text("Email"),
              subtitle: SelectableText(
                'bpbd.indramayu@gmail.com',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenConfig.blockHorizontal * 3.5,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(
                thickness: 2,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<Widget> aboutBencana(BuildContext context) async {
    return showMaterialModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10))),
      elevation: 3,
//                                          barrierColor: Colors.red,

      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          // controller: scrollController,
          physics: ClampingScrollPhysics(),
          children: [
            Image.asset(
              "assets/bpbd.png",
              height: 80,
              width: 80,
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "Badan Penanggulangan Bencana Daerah",
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenConfig.blockHorizontal * 3.5,
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                "Kabupaten Indramayu",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenConfig.blockHorizontal * 3.5,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ListTile(
              leading: Icon(
                Feather.home,
                size: 45,
                color: Colors.deepOrange,
              ),
              title: Text("Alamat Kantor"),
              subtitle: SelectableText(
                'Jalan Pahlawan No. 62/A Indramayu',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenConfig.blockHorizontal * 3.5,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(
                thickness: 2,
              ),
            ),
            ListTile(
              leading: Icon(
                Feather.phone_call,
                size: 45,
                color: Colors.deepOrange,
              ),
              title: Text("Telephon Kantor"),
              subtitle: SelectableText(
                '0234-277721',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenConfig.blockHorizontal * 3.5,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(
                thickness: 2,
              ),
            ),
            ListTile(
              leading: Icon(
                Feather.chrome,
                size: 45,
                color: Colors.deepOrange,
              ),
              title: Text("Website"),
              subtitle: SelectableText(
                'bpbd.indramayukab.go.id',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenConfig.blockHorizontal * 3.5,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(
                thickness: 2,
              ),
            ),
            ListTile(
              leading: Icon(
                Feather.mail,
                size: 45,
                color: Colors.deepOrange,
              ),
              title: Text("Email"),
              subtitle: SelectableText(
                'bpbd.indramayu@gmail.com',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenConfig.blockHorizontal * 3.5,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(
                thickness: 2,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyMenu extends StatelessWidget {
  MyMenu({this.title, this.icon, this.warna, this.onTap});

  final String title;
  final IconData icon;
  final MaterialColor warna;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(200.0),
        ),
        margin: EdgeInsets.symmetric(
            vertical: ScreenConfig.blockVertical * 4,
            horizontal: ScreenConfig.blockHorizontal * 8),
        child: InkWell(
          borderRadius: BorderRadius.circular(150.0),
          onTap: onTap,
          splashColor: Colors.deepOrange,
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: ScreenConfig.blockHorizontal * 20.5,
                color: warna,
              ),
              Text(
                title,
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenConfig.blockHorizontal * 2.5,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
