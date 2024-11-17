import 'package:events_presentation/data/constant.dart';
import 'package:events_presentation/data/localdb.dart';
import 'package:flutter/material.dart';
import 'package:events_presentation/assets/constants.dart' as constants;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import '../data/sp_helper.dart';
import 'event_form.dart';
import 'event_screen.dart';
class DashBoardScreen extends StatelessWidget {
  ///
  DashBoardScreen({super.key});
  final SPHelper helper = SPHelper();
  
  @override
  Widget build(BuildContext context) {
    String usuarioNombre="";
    Future<void> cerrarSesionGoogle() async {
      // Trigger the authentication flow
      try {
        await GoogleSignIn().signOut();
        await FirebaseAuth.instance.signOut();
      } on FirebaseAuthException catch (e) {
        throw e.message.toString();
      }
      catch (_) {
        throw _.toString();
      }
    }
    Future<void> checkUserLog() async
    {
      final FirebaseAuth auth = await FirebaseAuth.instance;
      final user = await auth.currentUser;
      if(user != null)
        {
          constant.name = (await LocalDataSaver.getName())!;
          constant.email = (await LocalDataSaver.getEmail())!;
        }
    }
    Future<void> getUserName() async {
      Map<String, String> settings = await helper.getSettings();
      usuarioNombre = settings['name'] ?? 'unknow';
    }
    checkUserLog();
    getUserName();
    return Scaffold(
        appBar: AppBar(
          title: Text("${constants.bienvenido} ${constant.name}",textAlign: TextAlign.justify),
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),

          child:  Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child:  ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const EventScreen()),
                            );
                          },
                          icon: Icon(Icons.list_alt_outlined),  //icon data for elevated button
                          label: Text(constants.verEventos), //label text
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrangeAccent,
                            foregroundColor: Colors.white,
                          )
                      )
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child:  ElevatedButton.icon(
                          onPressed: () async {
                            cerrarSesionGoogle();
                            Navigator.of(context).popUntil((route) => route.isFirst);
                          },
                          icon: Icon(Icons.logout),  //icon data for elevated button
                          label: Text(constants.cerrarSesion), //label text
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          )
                      )
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}