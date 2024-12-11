import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/accessibility_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccessibilityScreen extends StatelessWidget {
  const AccessibilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AccessibilityProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Accessibility'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Visual Settings
          const Text(
            'Visual Settings',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // High Contrast Mode
          SwitchListTile(
            title: const Text('High Contrast Mode'),
            subtitle: const Text('Increases contrast for better visibility'),
            value: provider.highContrastMode,
            onChanged: (value) => provider.toggleHighContrast(),
          ),

          // Large Text Mode
          SwitchListTile(
            title: const Text('Large Text Mode'),
            subtitle: const Text('Makes text larger throughout the app'),
            value: provider.largeTextMode,
            onChanged: (value) => provider.toggleLargeText(),
          ),

          // Text Size Slider
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Text Size',
                  style: TextStyle(fontWeight: FontWeight.bold),
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
                  style: TextStyle(fontSize: 16 * provider.textScaleFactor),
                ),
              ],
            ),
          ),

          const Divider(),

          // Color Blindness Settings
          const Text(
            'Color Blindness Support',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Color Blindness Type Selection
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select Color Blindness Type:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<ColorBlindnessType>(
                  value: provider.colorBlindnessType,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  items: ColorBlindnessType.values.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type.name.toUpperCase()),
                    );
                  }).toList(),
                  onChanged: (type) {
                    if (type != null) {
                      provider.setColorBlindnessType(type);
                    }
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'Color Preview:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _ColorPreview(
                      color: provider.adaptColorForColorBlindness(Colors.red),
                      label: 'Red',
                    ),
                    _ColorPreview(
                      color: provider.adaptColorForColorBlindness(Colors.green),
                      label: 'Green',
                    ),
                    _ColorPreview(
                      color: provider.adaptColorForColorBlindness(Colors.blue),
                      label: 'Blue',
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Divider(),

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
