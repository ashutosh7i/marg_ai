import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';  // Add this import for TimeoutException
import 'package:provider/provider.dart';
import '../../providers/accessibility_provider.dart';

const int _apiTimeout = 30; // timeout in seconds

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marg AI Chatbot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const ChatbotModal(),
          );
        },
        child: const Icon(Icons.chat),
      ),
      body: const Center(
        child: Text('Your main app content here'),
      ),
    );
  }
}

class ChatbotModal extends StatefulWidget {
  const ChatbotModal({Key? key}) : super(key: key);

  @override
  _ChatbotModalState createState() => _ChatbotModalState();
}

class _ChatbotModalState extends State<ChatbotModal> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final SpeechToText _speechToText = SpeechToText();
  final FlutterTts _flutterTts = FlutterTts();
  bool _isListening = false;
  bool _isSending = false;
  Timer? _autoSendTimer;  // Add this timer

  @override
  void initState() {
    super.initState();
    _initializeSpeech();
    _addBotMessage("Hi. Welcome to Marg AI. How may i help you?");
    
    // Add listener for auto-send
    _textController.addListener(() {
      if (_textController.text.isNotEmpty) {
        _resetAutoSendTimer();
      }
    });
  }

  void _resetAutoSendTimer() {
    _autoSendTimer?.cancel();
    _autoSendTimer = Timer(Duration(seconds: 2), () {
      if (_textController.text.isNotEmpty && !_isSending) {
        _sendMessage(_textController.text);
      }
    });
  }

  void _initializeSpeech() async {
    await _speechToText.initialize();
    setState(() {});
  }

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isUser: true,
      ));
      _isSending = true;
    });

    _textController.clear();

    try {
      final response = await http.post(
        Uri.parse('https://himmaannsshhuu-langflow.hf.space/api/v1/run/6c8a1aac-2ba5-4ce3-b4f9-8babbcfc5283'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'input_value': text,
          'output_type': 'chat',
          'input_type': 'chat',
          'tweaks': {
            'ChatInput-51b9e': {},
            'ChatOutput-gJBME': {},
            'OpenAIModel-0ZW1e': {},
            'Memory-a6o8Y': {},
            'Prompt-8TXFr': {}
          }
        }),
      ).timeout(Duration(seconds: _apiTimeout));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final botMessage = responseData['outputs'][0]['outputs'][0]['results']['message']['text'];
        _addBotMessage(botMessage);
      } else {
        _addBotMessage("Sorry, I'm having trouble connecting. Please try again later.");
        print('API Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      _addBotMessage("Sorry, something went wrong. Please try again.");
      print('Error sending message: $e');
    } finally {
      setState(() {
        _isSending = false;
      });
    }
  }

  void _addBotMessage(String text) {
    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isUser: false,
      ));
    });
    _flutterTts.speak(text);
  }

  void _startListening() async {
    if (!_isListening) {
      bool available = await _speechToText.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speechToText.listen(
          onResult: (result) {
            setState(() {
              _textController.text = result.recognizedWords;
            });
          },
        );
      }
    } else {
      setState(() => _isListening = false);
      _speechToText.stop();
    }
  }

  @override
  void dispose() {
    _autoSendTimer?.cancel();
    _textController.dispose();
    _speechToText.cancel();
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<AccessibilityProvider>();

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: provider.backgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Chat header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: provider.surfaceColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: provider.borderColor.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                ),
              ],
            ),
            child: Row(
              children: [
                Text(
                  'Marg AI Assistant',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: provider.primaryTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(Icons.close, color: provider.primaryTextColor),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          // Chat messages
          Expanded(
            child: Container(
              color: provider.backgroundColor,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _messages[index];
                },
              ),
            ),
          ),

          // Input area
          Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              left: 16,
              right: 16,
              top: 16,
            ),
            decoration: BoxDecoration(
              color: provider.surfaceColor,
              boxShadow: [
                BoxShadow(
                  color: provider.borderColor.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: provider.inputFillColor,
                  ),
                  child: IconButton(
                    icon: Icon(
                      _isListening ? Icons.mic : Icons.mic_none,
                      color: _isListening ? theme.colorScheme.primary : provider.secondaryTextColor,
                    ),
                    onPressed: _startListening,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _textController,
                    style: TextStyle(color: provider.primaryTextColor),
                    decoration: InputDecoration(
                      hintText: 'Send a Message',
                      hintStyle: TextStyle(color: provider.secondaryTextColor),
                      border: InputBorder.none,
                      fillColor: provider.inputFillColor,
                      filled: true,
                    ),
                    onSubmitted: _sendMessage,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _isSending
                      ? null
                      : () => _sendMessage(_textController.text),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(_isSending ? 'Sending...' : 'Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatMessage({
    Key? key,
    required this.text,
    required this.isUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AccessibilityProvider>();
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) ...[
            CircleAvatar(
              backgroundColor: theme.colorScheme.primary,
              child: Icon(
                Icons.smart_toy,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: isUser ? provider.inputFillColor : theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: provider.borderColor,
                  width: 1,
                ),
              ),
              child: Text(
                text,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: isUser ? provider.primaryTextColor : Colors.white,
                ),
              ),
            ),
          ),
          if (isUser) const SizedBox(width: 8),
        ],
      ),
    );
  }
}
