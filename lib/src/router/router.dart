import 'package:go_router/go_router.dart';
import 'package:todoapp/src/constant/RouteName.dart';
import 'package:todoapp/src/views/LoginScreen.dart';
import 'package:todoapp/src/views/NavigationScreen.dart';
import 'package:todoapp/src/views/SignUpScreen.dart';
import '../views/AuthCheckScreen.dart';
import '../views/SplashScreen.dart';

final GoRouter goRouter = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const SplashScreen(),
    name: RouteName.SplashScreenRoute,
  ),
  GoRoute(
    path: '/authCheck',
    builder: (context, state) => const AuthCheck(),
    name: RouteName.AuthCheckRoute,
  ),
  GoRoute(
    path: '/navScreen',
    builder: (context, state) => const NaviagationScreen(),
    name: RouteName.NavigationScreenRoute,
  ),
  GoRoute(
    path: '/login',
    builder: (context, state) => const SigninScreen(),
    name: RouteName.LoginScreenRoute,
  ),
  GoRoute(
    path: '/signUp',
    builder: (context, state) => const SignupScreen(),
    name: RouteName.SignupScreenRoute,
  ),
]);
