// import 'package:curved_navigation_bar/curved_navigation_bar.dart';


import 'package:bpbd/screen/pelapor_app/pages/Page_Profil/profile.dart';
import 'package:bpbd/screen/pelapor_app/pages/page_home/home.dart';
import 'package:bpbd/screen/pelapor_app/pages/page_tetang/tentang.dart';
import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';


class IndexPelaporView extends StatefulWidget {
  // static var routeName;
  static const String routeName= '/Index';

  @override
  _IndexPelaporViewState createState() => _IndexPelaporViewState();
}

class _IndexPelaporViewState extends State<IndexPelaporView> {

  int _selectedIndex = 0;

  selectView(){
    if(_selectedIndex==0){
      return Home();
    }else if(_selectedIndex==1){
      return Profile();
    }else if(_selectedIndex==2){
      return Tentang();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: selectView(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(Icons.add),
      //   backgroundColor: Colors.red,
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BubbleBottomBar(
        // hasNotch: true,
        // fabLocation: BubbleBottomBarFabLocation.end,
        opacity: .2,
        currentIndex:_selectedIndex,
        onTap: (int tekan) {
          setState(() {
            _selectedIndex = tekan;
          });
        },
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(
                16)), //border radius doesn't work when the notch is enabled.
        elevation: 4,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Colors.deepOrange,
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.home,
                color: Colors.deepOrange,
              ),
              title: Text("Home")),
          BubbleBottomBarItem(
              backgroundColor: Colors.deepOrange,
              icon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.person,
                color: Colors.deepOrange,
              ),
              title: Text("Profil")),
          BubbleBottomBarItem(
              backgroundColor: Colors.deepOrange,
              icon: Icon(
                Icons.info,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.info,
                color: Colors.deepOrange,
              ),
              title: Text("Tentang")),
        ],
      ),
    );
  }
}