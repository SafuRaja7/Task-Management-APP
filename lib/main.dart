import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:task_management/app_routes.dart';
import 'package:task_management/bloc/notifications/cubit.dart';
import 'package:task_management/bloc/tasks/task_cubit.dart';
import 'package:task_management/screeens/home/home.dart';
import 'package:task_management/screeens/login/login.dart';
import 'package:task_management/screeens/signup/signup.dart';
import 'bloc/auth/cubit.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => TaskCubit()),
        BlocProvider(create: (context) => NotificationsCubit()),
      ],
      child: MaterialApp(
        title: 'Task management',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        initialRoute: AppRoutes.login,
        routes: {
          AppRoutes.login: (context) => const Login(),
          AppRoutes.signup: (context) => const SignUp(),
          AppRoutes.home: (context) => const Home(),
        },
      ),
    );
  }
}
