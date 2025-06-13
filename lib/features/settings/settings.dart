import 'package:aetherium_movil/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Settings extends ConsumerWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(themeModeProvider);
    final themeNotifier = ref.read(themeModeProvider.notifier);

    final bool isDark =
        currentThemeMode == ThemeMode.dark ||
        (currentThemeMode == ThemeMode.system &&
            WidgetsBinding.instance.platformDispatcher.platformBrightness ==
                Brightness.dark);

    return Scaffold(
      appBar: AppBar(title: const Text('Configuración')),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Ajustes de Tema',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          SwitchListTile(
            title: const Text('Modo Oscuro'),
            subtitle: const Text('Activa o desactiva el tema oscuro'),
            value: isDark,
            onChanged: (bool value) {
              themeNotifier.setThemeMode(
                value ? ThemeMode.dark : ThemeMode.light,
              );
            },
            secondary: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
          ),
          RadioListTile<ThemeMode>(
            title: const Text('Tema del Sistema'),
            value: ThemeMode.system,
            groupValue: currentThemeMode,
            onChanged: (ThemeMode? mode) {
              if (mode != null) {
                themeNotifier.setThemeMode(mode);
              }
            },
          ),
          RadioListTile<ThemeMode>(
            title: const Text('Tema Claro'),
            value: ThemeMode.light,
            groupValue: currentThemeMode,
            onChanged: (ThemeMode? mode) {
              if (mode != null) {
                themeNotifier.setThemeMode(mode);
              }
            },
          ),
          RadioListTile<ThemeMode>(
            title: const Text('Tema Oscuro'),
            value: ThemeMode.dark,
            groupValue: currentThemeMode,
            onChanged: (ThemeMode? mode) {
              if (mode != null) {
                themeNotifier.setThemeMode(mode);
              }
            },
          ),
        ],
      ),
    );
  }
}
