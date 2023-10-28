import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../accounts/accounts.dart';
import 'routes.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GlobalKey<NavigatorState> navigatorKey(NavigatorKeyRef _) =>
    GlobalKey<NavigatorState>();

@riverpod
AppRouter appRouter(AppRouterRef ref) => AppRouter(ref);

class AppRouter {
  AppRouter(this.ref) {
    _setupRoutes();
  }

  final Ref ref;
  late final GoRouter _router;

  GoRouter get routerConfig => _router;

  void goBack() {
    _router.pop();
  }

  void _setupRoutes() {
    _router = GoRouter(
      debugLogDiagnostics: true,
      navigatorKey: ref.watch(navigatorKeyProvider),
      initialLocation: Routes.home.path,
      routes: [
        GoRoute(
          path: Routes.home.path,
          builder: (context, state) => const AccountsListScreen(),
        ),
      ],
    );
  }
}
