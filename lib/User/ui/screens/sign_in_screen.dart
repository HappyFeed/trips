import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trips_app/widgets/gradient_back.dart';
import 'package:trips_app/widgets/button_green.dart';
import 'package:trips_app/User/bloc/bloc_user.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:trips_app/User/model/user.dart' as userModel;
import 'package:trips_app/trips_cupertino.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SignInScreen();
  }
}

class _SignInScreen extends State<SignInScreen> {
  late UserBloc userBloc;
  late double screenWidht;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    userBloc = BlocProvider.of(context);
    screenWidht = MediaQuery.of(context).size.width;
    return _handleCurrentSession();
  }

  Widget _handleCurrentSession() {
    return StreamBuilder(
        stream: userBloc
            .authStatus, //Solicitamos conocer el estatus de la sesion de Firebase
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //snapshot contiene nuestro objeto User de Firebase
          if (!snapshot.hasData || snapshot.hasError) {
            return signInGoogleUI(); //Si no hay datos en User pide que se autentique
          } else {
            return TripsCupertino(); //Si hay datos de Usuario autenticado pasa a la pantalla principal de la app de viajes
          }
        });
  }

  Widget signInGoogleUI() {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          GradientBack(
            height: null,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                  child: Container(
                width: screenWidht,
                child: Text(
                  "Welcome \n This is your travel App",
                  style: TextStyle(
                      fontFamily: "Lato",
                      fontSize: 37.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              )),
              ButtonGreen(
                text: "Login with Gmail",
                onPressed: () {
                  userBloc.signOut();
                  userBloc.signIn().then((UserCredential? user) {
                    userBloc.updateUserData(userModel.UserModel(
                      uid: (user?.user!.uid).toString(),
                      name: (user?.user!.displayName).toString(),
                      email: (user?.user!.email).toString(),
                      photoUrl: (user?.user!.photoURL).toString(),
                    ));
                  });
                },
                width: 300.0,
                height: 50.0,
              )
            ],
          )
        ],
      ),
    );
  }
}
