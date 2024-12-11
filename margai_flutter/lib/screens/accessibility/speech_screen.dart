import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/services.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({super.key});

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  String _selectedLanguage = 'en_US';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      localeId: _selectedLanguage,
    );
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Speech to Text'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Language selector
            DropdownButton<String>(
              value: _selectedLanguage,
              items: const [
                DropdownMenuItem(value: 'en_US', child: Text('English')),
                DropdownMenuItem(value: 'hi_IN', child: Text('हिंदी')),
              ],
              onChanged: (String? value) {
                setState(() {
                  _selectedLanguage = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            // Mic button
            Container(
              padding: const EdgeInsets.all(16),
              child: IconButton(
                onPressed: _speechEnabled
                    ? (_speechToText.isListening
                        ? _stopListening
                        : _startListening)
                    : null,
                icon: Icon(
                  _speechToText.isListening ? Icons.mic : Icons.mic_none,
                  size: 48,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Status text
            Text(
              _speechToText.isListening
                  ? 'Listening...'
                  : _speechEnabled
                      ? 'Tap to speak'
                      : 'Speech not available',
            ),
            const SizedBox(height: 20),
            // Recognized text
            if (_lastWords.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text(_lastWords),
                    IconButton(
                      onPressed: () async {
                        await Clipboard.setData(ClipboardData(text: _lastWords));
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Text copied to clipboard'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.copy),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
} 