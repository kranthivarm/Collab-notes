import 'package:bloc_sm/features/auth/data/node_auth_repository.dart';
import 'package:bloc_sm/features/auth/domain/repositories/auth_repository.dart';
import 'package:bloc_sm/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:bloc_sm/features/auth/presentation/cubits/auth_state.dart';
import 'package:bloc_sm/features/auth/presentation/pages/auth_page.dart';
import 'package:bloc_sm/features/home/presentation/pages/home_page.dart';
import 'package:bloc_sm/features/notes/data/node_note_repository.dart';
import 'package:bloc_sm/features/notes/domain/repositories/note_repository.dart';
import 'package:bloc_sm/themes/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AuthRepository authRepository = NodeAuthRepository();
  final NoteRepository noteRepository = NodeNoteRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(authRepository)..checkAuth(),
        ),
        BlocProvider(
          create: (context) => ThemeCubit()..checkTheme(),
        )
      ],
      child: BlocConsumer<ThemeCubit, ThemeData>(
        builder:(context, themeState) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeState,
          home: BlocConsumer<AuthCubit, AuthState>(
            builder: (context, authState) {
              if((authState is Unauthenticated || (authState is AuthError))) {
                return const AuthPage();
              }
              else if((authState is AuthLoading) || (authState is AuthInitial)) {
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                );
              }
              return const HomePage();
            },
            listener: (context, authState) {
              if(authState is AuthSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(authState.message)));
              }
              else if(authState is AuthSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(authState.message)));
              }
            },
          ),
        ),
        listener: (context, themeState) {},
      ),
    );
  }
}
