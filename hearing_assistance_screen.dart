import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/voice_control_widget.dart';
import '../services/translation_service.dart';
import '../services/speech_service.dart';
import '../localization/app_localizations.dart';
import 'package:audioplayers/audioplayers.dart';

class HearingAssistanceScreen extends StatefulWidget {
  @override
  _HearingAssistanceScreenState createState() => _HearingAssistanceScreenState();
}

class _HearingAssistanceScreenState extends State<HearingAssistanceScreen> {
  final TranslationService _translationService = TranslationService();
  final SpeechService _speechService = SpeechService();
  String _translatedText = '';
  String _inputText = '';
  bool _isListening = false;
  String _sourceLanguage = 'es';
  String _targetLanguage = 'en';
  final AudioPlayer _audioPlayer = AudioPlayer();

  void _startListening() {
    setState(() {
      _isListening = true;
    });
    // Simular escucha de audio en el idioma fuente
    Future.delayed(Duration(seconds: 3), () async {
      final recognizedText = await _speechService.listenAndRecognize(_sourceLanguage);
      final translatedText = await _translationService.translateText(
        recognizedText, _sourceLanguage, _targetLanguage);
      
      setState(() {
        _translatedText = translatedText;
        _isListening = false;
      });
      
      // Leer la traducción en voz alta
      _speechService.speakText(_translatedText, _targetLanguage);
    });
  }

  void _translateText() async {
    if (_inputText.isEmpty) return;
    
    final detectedLang = await _translationService.detectLanguage(_inputText);
    final translated = await _translationService.translateText(
      _inputText, detectedLang, _targetLanguage);
    
    setState(() {
      _translatedText = translated;
    });
    
    // Leer la traducción en voz alta
    _speechService.speakText(_translatedText, _targetLanguage);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    
    return Scaffold(
      appBar: CustomAppBar(title: localizations.translate('hearing_assistance')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              localizations.translate('hearing_description'),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            VoiceControlWidget(language: _sourceLanguage),
            SizedBox(height: 30),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      localizations.translate('audio_to_text'),
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    _isListening
                        ? Column(
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 10),
                              Text(localizations.translate('listening'), 
                                   style: TextStyle(fontSize: 16)),
                            ],
                          )
                        : Container(),
                    SizedBox(height: 20),
                    Text(
                      _translatedText.isEmpty
                          ? localizations.translate('start_listening')
                          : _translatedText,
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _startListening,
                      icon: Icon(_isListening ? Icons.stop : Icons.hearing),
                      label: Text(_isListening 
                          ? localizations.translate('stop_listening') 
                          : localizations.translate('start_listening')),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      localizations.translate('text_translator'),
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Texto a traducir',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                      onChanged: (value) => _inputText = value,
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButton<String>(
                            value: _sourceLanguage,
                            items: [
                              DropdownMenuItem(value: 'es', child: Text('Español')),
                              DropdownMenuItem(value: 'en', child: Text('English')),
                              DropdownMenuItem(value: 'zh', child: Text('中文')),
                              DropdownMenuItem(value: 'ko', child: Text('한국어')),
                              DropdownMenuItem(value: 'fr', child: Text('Français')),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _sourceLanguage = value!;
                              });
                            },
                          ),
                        ),
                        Icon(Icons.arrow_forward),
                        Expanded(
                          child: DropdownButton<String>(
                            value: _targetLanguage,
                            items: [
                              DropdownMenuItem(value: 'en', child: Text('English')),
                              DropdownMenuItem(value: 'es', child: Text('Español')),
                              DropdownMenuItem(value: 'zh', child: Text('中文')),
                              DropdownMenuItem(value: 'ko', child: Text('한국어')),
                              DropdownMenuItem(value: 'fr', child: Text('Français')),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _targetLanguage = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: _translateText,
                      child: Text(localizations.translate('translate')),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}