import 'dart:async';
import 'package:bpbd/screen/login_page/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {

  _SplashScreen createState() => _SplashScreen();
      
} 

class _SplashScreen extends State<SplashScreen> {
  
  void initState(){
    super.initState();
    splashscreenStart();
  }

  getsession() async{
   SharedPreferences preferences = await SharedPreferences.getInstance();
   if(preferences.get('id')!= null)
   {
    if(preferences.get('level')=='pelapor'){
        Navigator.of(context).pushReplacementNamed('/IndexPelaporView');
    }else{
        Navigator.of(context).pushReplacementNamed('/IndexPetugasView');
    }
   }else{
     Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) {return LoginPage(); 
        }),
      );
   }
  }

  splashscreenStart() async{
    var duration = const Duration(seconds: 1);
    return Timer(duration, (){
      getsession();
    }); 
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
            backgroundImage: AssetImage(
            "assets/bpbd.png",
            ),
            radius: 50,
            ),
            // Text("BPBD",
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontWeight: FontWeight.bold,
            //     fontSize: 30.0
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
