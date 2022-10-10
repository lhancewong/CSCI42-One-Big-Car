import 'package:flutter/material.dart';

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

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 8),
          child: ElevatedButton(
            style: ButtonStyle(
              padding: const MaterialStatePropertyAll(
                  EdgeInsets.fromLTRB(90, 15, 90, 15)),
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
              !loggedIn
                  ? Navigator.of(context).pushNamed('/LogIn')
                  : signOut();
            },
          ),
        ),
        Visibility(
            visible: loggedIn,
            child: Padding(
              padding: const EdgeInsets.only(left: 24, bottom: 8),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/UserProfile');
                  },
                  child: const Text('Start')),
            ))
      ],
    );
  }
}
