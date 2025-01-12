import 'package:flutter/material.dart';
import 'app_router.dart';

void main() {
  runApp(
    RickAndMortyApp(appRouter: AppRouter()),
  );
}

class RickAndMortyApp extends StatelessWidget {
  // This widget is the root of your application.
  final AppRouter appRouter;
  const RickAndMortyApp({
    super.key,
    required this.appRouter,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
