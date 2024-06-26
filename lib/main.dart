import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:one_big_car/pages/booking/ride_list.dart';
import 'package:one_big_car/authentication/login_page.dart';
import 'package:one_big_car/pages/user/user_homepage.dart';
import 'package:one_big_car/pages/landing_page.dart';
import 'package:one_big_car/pages/booking/location.dart';
import 'package:one_big_car/authentication/register_page.dart';
import 'package:one_big_car/pages/user/user_profile.dart';
import 'package:one_big_car/pages/booking/single_booking.dart';
import 'package:one_big_car/pages/booking/ride_history.dart';
import 'package:one_big_car/pages/chat/chat_selection.dart';
import 'package:one_big_car/pages/chat/chat_page.dart';
import 'package:one_big_car/pages/passenger_list.dart';
import 'package:one_big_car/pages/booking/ride_search.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: 'one-big-car',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await dotenv.load();

  runApp(ChangeNotifierProvider(
    create: (context) => ApplicationState(),
    builder: ((context, child) => const MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'One Big Car!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Nunito',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Landing(),
        '/Homepage': (context) => const UserHomepage(),
        '/UserProfile': (context) => const UserProfile(),
        '/SingleBooking': (context) => const SingleBooking(),
        '/RideHistory': (context) => const RideHistory(),
        '/ChatSelection': (context) => const ChatSelection(),
        '/ChatPage': (context) => const ChatPage(),
        '/RideList': (context) => const RideList(),
        '/RideSearch': (context) => const RideSearch(),
        '/Location' : (context) => const Location(),
        '/Register': (context) => const Register(),
        '/LogIn': (context) => const LogIn(),
        '/PassengerList': (context) => const PassengerList(),
        /* ((context) {
          return SignInScreen(
            actions: [
              ForgotPasswordAction(((context, email) {
                Navigator.of(context)
                    .pushNamed('/forgot-password', arguments: {'email': email});
              })),
              AuthStateChangeAction(((context, state) {
                if (state is SignedIn || state is UserCreated) {
                  var authUser = (state is SignedIn)
                      ? state.user
                      : (state as UserCreated).credential.user;
                  if (authUser == null) {
                    return;
                  }
                  if (state is UserCreated) {
                    authUser.updateDisplayName(authUser.email!.split('@')[0]);
                  }
                  if (!authUser.emailVerified) {
                    authUser.sendEmailVerification();
                    const snackBar = SnackBar(
                        content: Text(
                            'Please check your email to verify your email address'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  Navigator.of(context).pushReplacementNamed('/');
                }
              })),
            ],
          );
        }),
        '/forgot-password': ((context) {
          final arguments = ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>?;

          return ForgotPasswordScreen(
            email: arguments?['email'] as String,
            headerMaxExtent: 200,
          );
        }), */
      },
    );
  }
}

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  Future<void> init() async {
    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
      } else {
        _loggedIn = false;
      }
      notifyListeners();
    });
  }
}
