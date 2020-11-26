import 'package:bpbd/screen/login_page/forget_password.dart';
import 'package:bpbd/screen/login_page/loginPage.dart';
import 'package:bpbd/screen/login_page/register.dart';
import 'package:bpbd/screen/login_page/splashscreen.dart';
import 'package:bpbd/screen/pelapor_app/menu_view/info_bencana_view/v_info_bencana.dart';
import 'package:bpbd/screen/pelapor_app/menu_view/laporan_view/v_laporan.dart';
import 'package:bpbd/screen/pelapor_app/pages/Page_Profil/foto_profil.dart';
import 'package:bpbd/screen/pelapor_app/pages/Page_Profil/profile.dart';
import 'package:bpbd/screen/pelapor_app/pages/Page_Profil/ubah_password.dart';
import 'package:bpbd/screen/pelapor_app/pages/index_pelapor.dart';
import 'package:bpbd/screen/pelapor_app/pages/page_home/home.dart';
import 'package:bpbd/screen/pelapor_app/pages/page_tetang/tentang.dart';
import 'package:bpbd/screen/petugas_app/Page_view/index_petugas.dart';
import 'package:bpbd/screen/petugas_app/menu_view/profil_petugas/ubah_password_petugas.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' ;

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/LoginPage' : (BuildContext context) => new LoginPage(),
        '/RegisterPage' : (BuildContext context) => new RegisterPage(),
        '/ForgetPasswordPage' : (BuildContext context) => new ForgetPasswordPage(),
        '/IndexPelaporView' : (BuildContext context) => new IndexPelaporView(),
        '/Home' : (BuildContext context) => new Home(),
        '/Profile' : (BuildContext context) => new Profile(),
        '/FotoProfilView' : (BuildContext context) => new FotoProfilView(),
        '/Tentang' : (BuildContext context) => new Tentang(),
        '/LaporanView' : (BuildContext context) => new LaporanView(),
        '/InfoBencanaView' : (BuildContext context) => new InfoBencanaView(),
        '/IndexPetugasView' : (BuildContext context) => new IndexPetugasView(),
        '/UbahPasswordView' : (BuildContext context) => new UbahPasswordView(),
        '/UbahPasswordPetugasView' : (BuildContext context) => new UbahPasswordPetugasView(),
      },
    );
  }
}
