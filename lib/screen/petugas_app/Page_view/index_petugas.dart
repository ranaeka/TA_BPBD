// import 'package:curved_navigation_bar/curved_navigation_bar.dart';


import 'package:bpbd/screen/petugas_app/Page_view/page_tentang/tentang.dart';
import 'package:bpbd/screen/petugas_app/Page_view/page_home_petugas/home_petugas.dart';
import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';

class IndexPetugasView extends StatefulWidget {
  // static var routeName;
  static const String routeName = '/IndexPetugasView';

  @override
  _IndexPetugasViewState createState() => _IndexPetugasViewState();
}

class _IndexPetugasViewState extends State<IndexPetugasView> {
  int _selectedIndex = 0;

  selectView() {
    if (_selectedIndex == 0) {
      return HomePetugas();
    } else if (_selectedIndex == 1) {
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
        currentIndex: _selectedIndex,
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

class ProfilePetugas {}
