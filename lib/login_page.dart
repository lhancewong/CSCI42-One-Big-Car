import 'package:flutter/material.dart';

class MyLoginPage extends StatelessWidget {
  const MyLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Get Started',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
            ),
            SizedBox(height: 25),
            TextField(
              style: TextStyle(
                fontSize:16
              ),
              decoration: InputDecoration(
                labelText: 'Username',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(33, 41, 239, 1),
                    width: 3.0,
                  ), 
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              obscureText: true,
              style: TextStyle(
                fontSize:16
              ),
              decoration: InputDecoration(
                labelText: 'Password',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(33, 41, 239, 1),
                    width: 3.0,
                  ), 
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: null,
                child: Text('Forgot your Password?'),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Color.fromRGBO(33, 41, 2, 1)),
                foregroundColor: MaterialStatePropertyAll<Color>(Colors.white)
              ),
              onPressed: null,
              child: Text(
                'Log in',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )
              ),
            ),
            TextButton(
              onPressed: null,
              child: Text('Create a new account'),
            )
          ]
        )
      )
    );
  }
}
