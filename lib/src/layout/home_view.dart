import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.inbox_outlined),
          selectedIcon: Icon(Icons.inbox),
          label: 'Inbox',
        ),
        NavigationDestination(
          icon: Icon(Icons.inbox_outlined),
          selectedIcon: Icon(Icons.inbox),
          label: 'Inbox',
        ),
      ],
      body: (context) => Center(
        child: Column(
          children: [
            Row(
              children: [
                FilledButton(onPressed: () {}, child: const Text('Nuevo')),
                const SizedBox(width: 10),
                const Text("Productos"),
                const Spacer(),
                const Text(("1-3/3")),
                const SizedBox(width: 10),
                IconButton.outlined(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(
                                8))), // Color de fondo del botón
                  ),
                  icon: const Icon(Icons.chevron_left), // Icono del botón
                ),
                IconButton.outlined(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8))),
                  ),
                  icon: const Icon(Icons.chevron_right), // Icono del botón
                ),
                const SizedBox(width: 10),
                IconButton.filledTonal(
                  onPressed: () {},
                  icon: const Icon(Icons.view_kanban),
                ),
                const SizedBox(width: 10),
                IconButton.filledTonal(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    // Navigate to the settings page. If the user leaves and returns
                    // to the app after it has been killed while running in the
                    // background, the navigation stack is restored.
                    Navigator.restorablePushNamed(
                        context, "/settings");
                  },
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {}, child: const Text('Elevated Button')),
            const Card(
              child: Text("Omlam"),
            ),
            FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.primary,
              onPressed: () {},
              child: const Icon(Icons.ac_unit),
            )
          ],
        ),
      ),
    );
  }
}
