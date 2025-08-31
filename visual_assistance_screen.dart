import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/voice_control_widget.dart';
import '../services/ai_service.dart';
import '../services/image_recognition_service.dart';
import '../services/speech_service.dart';
import '../localization/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class VisualAssistanceScreen extends StatefulWidget {
  @override
  _VisualAssistanceScreenState createState() => _VisualAssistanceScreenState();
}

class _VisualAssistanceScreenState extends State<VisualAssistanceScreen> {
  final AIService _aiService = AIService();
  final ImageRecognitionService _imageService = ImageRecognitionService();
  final SpeechService _speechService = SpeechService();
  File? _selectedImage;
  String _description = '';
  bool _isLoading = false;
  String _currentLanguage = 'es';

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _isLoading = true;
      });

      // Procesar imagen con IA en el idioma actual
      final description = await _imageService.describeImage(_selectedImage!, _currentLanguage);
      setState(() {
        _description = description;
        _isLoading = false;
      });
      
      // Leer la descripción en voz alta
      _speechService.speakText(_description, _currentLanguage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    
    return Scaffold(
      appBar: CustomAppBar(title: localizations.translate('visual_assistance')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              localizations.translate('visual_description'),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            VoiceControlWidget(language: _currentLanguage),
            SizedBox(height: 30),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      localizations.translate('image_description'),
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    _selectedImage == null
                        ? Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(Icons.camera_alt, size: 50, color: Colors.grey),
                          )
                        : Image.file(_selectedImage!, height: 200),
                    SizedBox(height: 20),
                    _isLoading
                        ? CircularProgressIndicator()
                        : Text(
                            _description.isEmpty
                                ? localizations.translate('take_photo')
                                : _description,
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                    SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _pickImage,
                      icon: Icon(Icons.camera_alt),
                      label: Text(localizations.translate('take_photo')),
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
                      localizations.translate('voice_navigation'),
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Di "Ir a inicio", "Abrir navegador", "Leer mensaje", etc.',
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      textAlign: TextAlign.center,
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