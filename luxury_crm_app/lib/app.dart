import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/auth/bloc/auth_bloc.dart';
import 'features/auth/services/auth_service.dart';
import 'config/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(AuthService())..add(AppStarted()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Luxury CRM Enterprise',
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
        theme: _buildTheme(),
      ),
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF1A1A2E),
        primary: const Color(0xFF1A1A2E),
        secondary: const Color(0xFFE94560),
        tertiary: const Color(0xFF0F3460),
      ),
      fontFamily: 'Tajawal',
    );
  }
}
