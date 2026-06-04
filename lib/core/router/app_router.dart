import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/add_card/presentation/screens/add_card_screen.dart';
import '../../features/collection/presentation/screens/card_detail_screen.dart';
import '../../features/collection/presentation/screens/collection_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/statistics/presentation/screens/statistics_screen.dart';
import '../../features/tags/presentation/screens/tags_manager_screen.dart';
import '../../features/wishlist/presentation/screens/wishlist_screen.dart';
import 'app_shell.dart';

final _rootKey = GlobalKey<NavigatorState>();

/// Central go_router configuration. Four branches power the bottom nav;
/// detail, add, and statistics are pushed on the root navigator.
final appRouter = GoRouter(
  navigatorKey: _rootKey,
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => AppShell(navigationShell: shell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (_, __) => const DashboardScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/collection',
              builder: (_, __) => const CollectionScreen(),
              routes: [
                GoRoute(
                  path: ':id',
                  parentNavigatorKey: _rootKey,
                  builder: (_, state) => CardDetailScreen(
                    cardId: int.parse(state.pathParameters['id']!),
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/wishlist',
              builder: (_, __) => const WishlistScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (_, __) => const SettingsScreen(),
              routes: [
                GoRoute(
                  path: 'tags',
                  parentNavigatorKey: _rootKey,
                  builder: (_, __) => const TagsManagerScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/add',
      parentNavigatorKey: _rootKey,
      builder: (_, state) => AddCardScreen(
        editId: state.uri.queryParameters['editId'] != null
            ? int.tryParse(state.uri.queryParameters['editId']!)
            : null,
      ),
    ),
    GoRoute(
      path: '/statistics',
      parentNavigatorKey: _rootKey,
      builder: (_, __) => const StatisticsScreen(),
    ),
  ],
);
