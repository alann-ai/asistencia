import 'package:flutter/material.dart';
import '../services/speech_service.dart';
import '../localization/app_localizations.dart';

class VoiceControlWidget extends StatefulWidget {
  final String language;
  
  VoiceControlWidget({this.language = 'es'});

  @override
  _VoiceControlWidgetState createState() => _VoiceControlWidgetState();
}

class _VoiceControlWidgetState extends State<VoiceControlWidget> {
  bool _isListening = false;
  final SpeechService _speechService = SpeechService();

  void _toggleListening() {
    setState(() {
      _isListening = !_isListening;
    });
    
    if (_isListening) {
      // Iniciar escucha en el idioma especificado
      _speechService.listenAndRecognize(widget.language).then((recognizedText) {
        // Procesar el texto reconocido
        print('Texto reconocido: $recognizedText');
        
        // Actualizar UI
        setState(() {
          _isListening = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            localizations.translate('voice_control'),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          SizedBox(height: 15),
          GestureDetector(
            onTap: _toggleListening,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: _isListening ? Colors.red : Colors.blue,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Icon(
                _isListening ? Icons.mic : Icons.mic_none,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 15),
          Text(
            _isListening 
                ? localizations.translate('listening') 
                : localizations.translate('tap_mic'),
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}