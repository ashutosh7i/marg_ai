import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/language_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageSelector extends StatelessWidget {
  final bool showLabel;

  const LanguageSelector({
    super.key,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<LanguageProvider>();
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showLabel) ...[
          Text(
            l10n.selectLanguage,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
        ],
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: languageProvider.currentLocale.languageCode,
              isExpanded: true,
              items: LanguageProvider.supportedLanguages
                  .map((language) => DropdownMenuItem(
                        value: language['code'],
                        child: Text(language['name']!),
                      ))
                  .toList(),
              onChanged: (String? languageCode) {
                if (languageCode != null) {
                  languageProvider.setLocale(languageCode);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
