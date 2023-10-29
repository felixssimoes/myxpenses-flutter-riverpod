import 'package:flutter/material.dart';
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

  void openCreateAccount() {
    _router.goNamed(Routes.createAccount.name);
  }

  void _setupRoutes() {
    _router = GoRouter(
      debugLogDiagnostics: true,
      navigatorKey: ref.watch(navigatorKeyProvider),
      initialLocation: Routes.accountsList.path,
      redirect: (context, state) =>
          state.matchedLocation == '/' ? Routes.accountsList.path : null,
      routes: [
        GoRoute(
          path: Routes.accountsList.path,
          name: Routes.accountsList.name,
          builder: (context, state) => const AccountsListScreen(),
          routes: [
            GoRoute(
              path: Routes.createAccount.path,
              name: Routes.createAccount.name,
              pageBuilder: (context, state) => MaterialPage<void>(
                key: state.pageKey,
                fullscreenDialog: true,
                child: const CreateAccountScreen(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
