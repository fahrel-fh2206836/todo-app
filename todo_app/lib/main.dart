import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/core/app_theme.dart';
import 'package:todo_app/core/router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todo_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:todo_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:todo_app/features/todo/data/repositories/todo_repository.dart';
import 'package:todo_app/features/todo/presentation/cubit/todo_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Supabase.initialize(
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    url: dotenv.env['SUPABASE_URL']!,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit(AuthRepositoryImpl())),
        BlocProvider(create: (_) => TodoCubit(TodoRepositoryImpl())),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        title: 'Todo App',
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
