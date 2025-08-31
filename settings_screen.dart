import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../localization/app_localizations.dart';
import '../localization/languages.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _voiceControl = true;
  bool _highContrast = false;
  bool _largeText = false;
  double _fontSize = 16.0;
  String _language = 'es';
  List<String> _selectedDisabilities = [];

  void _toggleDisability(String disability) {
    setState(() {
      if (_selectedDisabilities.contains(disability)) {
        _selectedDisabilities.remove(disability);
      } else {
        _selectedDisabilities.add(disability);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    
    return Scaffold(
      appBar: CustomAppBar(title: localizations.translate('settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizations.translate('accessibility'),
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 15),
                    SwitchListTile(
                      title: Text(localizations.translate('voice_control_setting')),
                      value: _voiceControl,
                      onChanged: (bool value) {
                        setState(() {
                          _voiceControl = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      title: Text(localizations.translate('high_contrast')),
                      value: _highContrast,
                      onChanged: (bool value) {
                        setState(() {
                          _highContrast = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      title: Text(localizations.translate('large_text')),
                      value: _largeText,
                      onChanged: (bool value) {
                        setState(() {
                          _largeText = value;
                        });
                      },
                    ),
                    SizedBox(height: 15),
                    Text(localizations.translate('text_size') + ':'),
                    Slider(
                      value: _fontSize,
                      min: 12.0,
                      max: 24.0,
                      divisions: 6,
                      label: _fontSize.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _fontSize = value;
                        });
                      },
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizations.translate('language'),
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 15),
                    DropdownButtonFormField<String>(
                      value: _language,
                      decoration: InputDecoration(
                        labelText: localizations.translate('select_language'),
                        border: OutlineInputBorder(),
                      ),
                      items: AppLanguages.supportedLanguages
                          .map<DropdownMenuItem<String>>((lang) {
                        return DropdownMenuItem<String>(
                          value: lang['code'],
                          child: Text(lang['name']!),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _language = newValue!;
                        });
                      },
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizations.translate('disability_profile'),
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 15),
                    Text(localizations.translate('visual_description')),
                    SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        FilterChip(
                          label: Text(localizations.translate('visual_assistance')),
                          selected: _selectedDisabilities.contains('visual'),
                          onSelected: (bool selected) {
                            _toggleDisability('visual');
                          },
                        ),
                        FilterChip(
                          label: Text(localizations.translate('hearing_assistance')),
                          selected: _selectedDisabilities.contains('hearing'),
                          onSelected: (bool selected) {
                            _toggleDisability('hearing');
                          },
                        ),
                        FilterChip(
                          label: Text(localizations.translate('motor_assistance')),
                          selected: _selectedDisabilities.contains('motor'),
                          onSelected: (bool selected) {
                            _toggleDisability('motor');
                          },
                        ),
                        FilterChip(
                          label: Text(localizations.translate('cognitive_assistance')),
                          selected: _selectedDisabilities.contains('cognitive'),
                          onSelected: (bool selected) {
                            _toggleDisability('cognitive');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Guardar configuración
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(localizations.translate('settings_saved'))),
                  );
                },
                child: Text(localizations.translate('save_settings')),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}