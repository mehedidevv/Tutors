
import 'package:care_tutors/features/homeView/view/homeView.dart';
import 'package:go_router/go_router.dart';
import '../../features/authView/view/logInView.dart';
import '../../features/authView/view/signUpView.dart';
import '../../features/splashView/view/splashView.dart';

class AppRouter {
  static const String splash = '/';
  static const String login  = '/login';
  static const String signUp = '/sign-up';
  static const String home = '/homeView';

  /// Router Instance
  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [

      GoRoute(
        path: splash,
        name: splash,
        builder: (context, state) => const SplashView(),
      ),

      GoRoute(
        path: login,
        name: login,
        builder: (context, state) => const LogInView(),
      ),

      GoRoute(
        path: signUp,
        name: signUp,
        builder: (context, state) => const SignUpView(),
      ),

      GoRoute(
        path: home,
        name: home,
        builder: (context, state) => const HomeView(),
      ),

    ],
  );
}