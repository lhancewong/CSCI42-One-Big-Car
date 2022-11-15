import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthFunc extends StatelessWidget {
  const AuthFunc({
    super.key,
    required this.loggedIn,
    required this.signOut,
  });

  final bool loggedIn;
  final void Function() signOut;

  @override
  Widget build(BuildContext context) {
    Color obcGrey = const Color.fromRGBO(243, 243, 243, 1);

    return Column(
      children: [
        ElevatedButton(
          style: ButtonStyle(
            padding: const MaterialStatePropertyAll(
                EdgeInsets.fromLTRB(80, 15, 80, 15)),
            backgroundColor: MaterialStatePropertyAll<Color>(obcGrey),
            foregroundColor:
                const MaterialStatePropertyAll<Color>(Colors.black),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                    side: BorderSide(color: obcGrey))),
          ),
          child: Text(!loggedIn ? 'Log-in' : 'Sign-out',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                fontFamily: 'Nunito',
              )),
          onPressed: () {
            !loggedIn ? Navigator.of(context).pushNamed('/LogIn') : signOut();
          },
        ),
        Visibility(
          visible: !loggedIn,
          child: TextButton(
            onPressed: () async {
              try {
                final userCredential =
                    await FirebaseAuth.instance.signInAnonymously();
                print("Signed in with temporary account.");
                Navigator.of(context).pushNamed('/UserProfile');
              } on FirebaseAuthException catch (e) {
                switch (e.code) {
                  case "operation-not-allowed":
                    print(
                        "Anonymous auth hasn't been enabled for this project.");
                    break;
                  default:
                    print("Unknown error.");
                }
              }
            },
            child: const Text('Login anonymously'),
          ),
        ),
        const SizedBox(height: 10),
        Visibility(
          visible: loggedIn,
          child: ElevatedButton(
              style: ButtonStyle(
                padding: const MaterialStatePropertyAll(
                    EdgeInsets.fromLTRB(100, 15, 100, 15)),
                backgroundColor: MaterialStatePropertyAll<Color>(obcGrey),
                foregroundColor:
                    const MaterialStatePropertyAll<Color>(Colors.black),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                        side: BorderSide(color: obcGrey))),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/UserProfile');
              },
              child: const Text('Start',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    fontFamily: 'Nunito',
                  ))),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(obcGrey),
            foregroundColor:
                const MaterialStatePropertyAll<Color>(Colors.black),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                    side: BorderSide(color: obcGrey))),
          ),
          child: const Text('Create/Edit User',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Nunito',
              )),
          onPressed: () {
            Navigator.of(context).pushNamed('/UserCreate');
          },
        ),
      ],
    );
  }
}
