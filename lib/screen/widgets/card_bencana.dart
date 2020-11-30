
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widget.dart';

class CardBencana extends StatelessWidget {
  final String urlImage;
  final String title;
  final String status;
  final String subtitle;
  final String lokasi;
  final String date;

  final Function onPressed;
  final bool newBencana;
  final bool visibelDate;



  const CardBencana({Key key, this.urlImage, this.title, this.status,  this.onPressed, this.subtitle, this.newBencana=false, this.lokasi, this.date, this.visibelDate=false}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(right:3.0),
      child: Card(
        color: Colors.white,
        elevation: 5,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          onTap: onPressed,
          child: Container(
            height: 300,
            width: 280,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10)),
                        child: CachedNetworkImage(
                          imageUrl:
                          "$urlImage",
                          fit: BoxFit.fitWidth,
                          width:double.infinity,
                          height: 150,
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
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 5.0, right: 5),
                        child: Text(
                          "$title",
                          style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      Visibility(
                        visible: visibelDate,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 5.0, right: 5),
                          child: Text(
                            "$date",
                            style: GoogleFonts.poppins(fontSize: 12,fontStyle: FontStyle.italic),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            left: 5.0, right: 5, top: 5),
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
                                Flexible(child: Icon(Feather.clock,color: Colors.white,size: 10,)),
                                SizedBox(width: 5,),
                                Flexible(
                                  flex: 5,
                                  child: Text("$status"
                                    ,
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 10),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Flexible(child: Icon(Feather.map_pin,color: Colors.white,size: 10,)),
                                SizedBox(width: 5,),
                                Flexible(
                                  flex: 5,
                                  child: Text("$lokasi"
                                    ,
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 10),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 5, top: 5),
                        child: Text(
                          "$subtitle",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                              fontSize: 12),

                          maxLines: 5,
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: newBencana,
                  child: Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100),topRight: Radius.circular(10),bottomRight: Radius.circular(10))
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left:14,top: 8,right: 8,bottom: 8),
                      child: Center(child: Text("Baru",style: GoogleFonts.poppins(color: Colors.white),)),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

}
