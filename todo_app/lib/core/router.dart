import 'package:go_router/go_router.dart';
import 'package:todo_app/features/auth/presentation/screens/login_page.dart';
import 'package:todo_app/features/auth/presentation/screens/register_page.dart';
import 'package:todo_app/features/todo/presentation/screens/todo_page.dart';

class AppRouter {
  // Routes
  static const loginRoute = (name: 'login', path: '/login');
  static const registerRoute = (name: 'register', path: '/register');
  static const todoRoute = (name: 'todo', path: '/');

  static final router = GoRouter(
    initialLocation: loginRoute.path,
    routes: [
      GoRoute(
        path: loginRoute.path,
        name: loginRoute.name,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: registerRoute.path,
        name: registerRoute.name,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: todoRoute.path,
        name: todoRoute.name,
        builder: (context, state) => const TodoPage(),
      ),
    ],
  );
}
