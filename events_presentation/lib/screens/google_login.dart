
import 'package:flutter/material.dart';
import 'package:events_presentation/assets/constants.dart' as constants;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import '../data/sp_helper.dart';
import 'dashboard_screen.dart';
import 'event_screen.dart';
// #enddocregion Initialize


class Login extends StatelessWidget {
  ///
  Login({super.key});
  final SPHelper helper = SPHelper();

  @override
  Widget build(BuildContext context) {
    String name="";
    String email="";
    Future<bool> saveUserName() async {
      return await helper.setSettings(name, email);
    }
    Future<UserCredential> iniciaSesionGoogle() async {
      // Trigger the authentication flow
      try{
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        // Obtain the auth details from the request
        final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        name = googleUser!.displayName.toString();
        email = googleUser!.email.toString();
        saveUserName();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DashBoardScreen()),
        );
        // Once signed in, return the UserCredential
        return await FirebaseAuth.instance.signInWithCredential(credential);

      }on FirebaseAuthException catch(e){
        throw e.message.toString();
      }
      catch(_){
        throw _.toString();
      }
    }
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
    return Scaffold(
        appBar: AppBar(
          title: const Text(constants.presentacionEventos,textAlign: TextAlign.justify),
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child:  Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                        Expanded(
                            child:   Lottie.network(
                                constants.urlAnimation),
                        ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child:  ElevatedButton.icon(
                          onPressed: () async {
                            await iniciaSesionGoogle();
                          },
                          icon: Icon(Icons.login),  //icon data for elevated button
                          label: Text(constants.loginGoogle), //label text
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrangeAccent,
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
