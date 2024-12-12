import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/accessibility_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccessibilityScreen extends StatelessWidget {
  const AccessibilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AccessibilityProvider>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Accessibility'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Visual Settings
          Text(
            'Visual Settings',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),

          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: Text('High Contrast Mode', 
                    style: theme.textTheme.titleMedium,
                  ),
                  subtitle: Text('Increases contrast for better visibility',
                    style: theme.textTheme.bodyMedium,
                  ),
                  value: provider.highContrastMode,
                  onChanged: (value) => provider.toggleHighContrast(),
                ),

                SwitchListTile(
                  title: Text('Large Text Mode',
                    style: theme.textTheme.titleMedium,
                  ),
                  subtitle: Text('Makes text larger throughout the app',
                    style: theme.textTheme.bodyMedium,
                  ),
                  value: provider.largeTextMode,
                  onChanged: (value) => provider.toggleLargeText(),
                ),
              ],
            ),
          ),

          // Text Size Slider
          Card(
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Text Size',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Slider(
                    value: provider.textScaleFactor,
                    min: 0.8,
                    max: 2.0,
                    divisions: 12,
                    label: '${(provider.textScaleFactor * 100).round()}%',
                    onChanged: (value) => provider.setTextScale(value),
                  ),
                  Text(
                    'Preview Text Size',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontSize: 16 * provider.textScaleFactor,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Color Blindness Settings
          Text(
            'Color Blindness Support',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Color Blindness Type:',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<ColorBlindnessType>(
                    value: provider.colorBlindnessType,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: provider.inputFillColor,
                    ),
                    dropdownColor: provider.surfaceColor,
                    style: theme.textTheme.bodyLarge,
                    items: ColorBlindnessType.values.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(
                          type.name.toUpperCase(),
                          style: theme.textTheme.bodyLarge,
                        ),
                      );
                    }).toList(),
                    onChanged: (type) {
                      if (type != null) {
                        provider.setColorBlindnessType(type);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),

          // Motion Settings
          const Text(
            'Motion Settings',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Reduced Motion
          SwitchListTile(
            title: const Text('Reduced Motion'),
            subtitle: const Text('Reduces or eliminates animations'),
            value: provider.reducedMotion,
            onChanged: (value) => provider.toggleReducedMotion(),
          ),

          const Divider(),

          // Screen Reader Support
          const Text(
            'Screen Reader Support',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'This app supports screen readers. To use:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                    '• On Android: Enable TalkBack in Settings > Accessibility'),
                Text('• On iOS: Enable VoiceOver in Settings > Accessibility'),
                SizedBox(height: 8),
                Text(
                  'All elements in the app have appropriate labels and '
                  'descriptions for screen readers.',
                ),
              ],
            ),
          ),

          const Divider(),

          // Keyboard Navigation
          const Text(
            'Keyboard Navigation',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Keyboard shortcuts:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('• Tab: Navigate between elements'),
                Text('• Enter/Space: Activate buttons and controls'),
                Text('• Arrow keys: Navigate within components'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ColorPreview extends StatelessWidget {
  final Color color;
  final String label;

  const _ColorPreview({
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}
