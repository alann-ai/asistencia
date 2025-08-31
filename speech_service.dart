import 'dart:math';

class SpeechService {
  // Simulación de servicio de reconocimiento de voz multilingüe
  Future<String> listenAndRecognize(String languageCode) async {
    // En una implementación real, esto conectaría con una API de reconocimiento de voz
    await Future.delayed(Duration(seconds: 3));
    
    // Comandos de ejemplo en diferentes idiomas
    Map<String, List<String>> commands = {
      'es': [
        'Abrir navegador',
        'Enviar mensaje a Juan',
        'Hacer llamada a María',
        'Reproducir música clásica',
        'Leer notificaciones'
      ],
      'en': [
        'Open browser',
        'Send message to John',
        'Make call to Mary',
        'Play classical music',
        'Read notifications'
      ],
      'zh': [
        '打开浏览器',
        '给约翰发消息',
        '打电话给玛丽',
        '播放古典音乐',
        '阅读通知'
      ],
      'ko': [
        '브라우저 열기',
        '존에게 메시지 보내기',
        '메리에게 전화 걸기',
        '고전 음악 재생',
        '알림 읽기'
      ],
      'fr': [
        'Ouvrir le navigateur',
        'Envoyer un message à Jean',
        'Passer un appel à Marie',
        'Jouer de la musique classique',
        'Lire les notifications'
      ]
    };
    
    List<String> langCommands = commands[languageCode] ?? commands['es']!;
    return langCommands[Random().nextInt(langCommands.length)];
  }
  
  void speakText(String text, String languageCode) {
    // En una implementación real, esto usaría un servicio de texto a voz multilingüe
    print('Diciendo en $languageCode: $text');
  }
  
  // Método para obtener voces disponibles por idioma
  List<String> getVoicesForLanguage(String languageCode) {
    Map<String, List<String>> voices = {
      'es': ['es-ES', 'es-MX', 'es-AR'],
      'en': ['en-US', 'en-GB', 'en-AU'],
      'zh': ['zh-CN', 'zh-TW'],
      'ko': ['ko-KR'],
      'fr': ['fr-FR', 'fr-CA'],
      'de': ['de-DE'],
      'ja': ['ja-JP'],
      'pt': ['pt-BR', 'pt-PT'],
      'ru': ['ru-RU'],
      'ar': ['ar-SA', 'ar-EG']
    };
    
    return voices[languageCode] ?? ['default'];
  }
}