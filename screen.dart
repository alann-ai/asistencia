import 'package:flutter/material.dart';
import 'visual_assistance_screen.dart';
import 'hearing_assistance_screen.dart';
import 'motor_assistance_screen.dart';
import 'cognitive_assistance_screen.dart';
import 'settings_screen.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/accessibility_button.dart';
import '../localization/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    
    return Scaffold(
      appBar: CustomAppBar(title: localizations.translate('app_name')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              localizations.translate('welcome_message'),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            AccessibilityButton(
              icon: Icons.visibility,
              label: localizations.translate('visual_assistance'),
              color: Colors.blue,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VisualAssistanceScreen()),
              ),
            ),
            SizedBox(height: 20),
            AccessibilityButton(
              icon: Icons.hearing,
              label: localizations.translate('hearing_assistance'),
              color: Colors.green,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HearingAssistanceScreen()),
              ),
            ),
            SizedBox(height: 20),
            AccessibilityButton(
              icon: Icons.accessibility_new,
              label: localizations.translate('motor_assistance'),
              color: Colors.orange,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MotorAssistanceScreen()),
              ),
            ),
            SizedBox(height: 20),
            AccessibilityButton(
              icon: Icons.psychology,
              label: localizations.translate('cognitive_assistance'),
              color: Colors.purple,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CognitiveAssistanceScreen()),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              ),
              icon: Icon(Icons.settings),
              label: Text(localizations.translate('settings')),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}