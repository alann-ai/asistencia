import 'dart:io';
import 'dart:math';

class ImageRecognitionService {
  // Simulación de servicio de reconocimiento de imágenes multilingüe
  Future<String> describeImage(File image, String languageCode) async {
    // En una implementación real, esto conectaría con una API de reconocimiento de imágenes
    await Future.delayed(Duration(seconds: 2));
    
    // Descripciones de ejemplo en diferentes idiomas
    Map<String, List<String>> descriptions = {
      'es': [
        'Persona sonriendo en un parque soleado',
        'Perro jugando con una pelota roja',
        'Taza de café humeante sobre una mesa de madera',
        'Señal de tráfico indicando paso peatonal',
        'Libro abierto con texto en una página'
      ],
      'en': [
        'Person smiling in a sunny park',
        'Dog playing with a red ball',
        'Steaming cup of coffee on a wooden table',
        'Traffic sign indicating pedestrian crossing',
        'Open book with text on a page'
      ],
      'zh': [
        '阳光明媚的公园里微笑的人',
        '玩红球的狗',
        '木桌上的冒热气的咖啡杯',
        '指示人行横道的交通标志',
        '页面上有文字的打开的书'
      ],
      'ko': [
        '햇살 가득한 공원에서 미소 짓는 사람',
        '빨간 공으로 노는 강아지',
        '나무 테이블 위의 따뜻한 커피 컵',
        '보행자 횡단보도를 나타내는 교통 표지판',
        '페이지에 글씨가 있는 펼쳐진 책'
      ],
      'fr': [
        'Personne souriante dans un parc ensoleillé',
        'Chien jouant avec une balle rouge',
        'Tasse de café fumant sur une table en bois',
        'Panneau de signalisation indiquant un passage piéton',
        'Livre ouvert avec du texte sur une page'
      ]
    };
    
    List<String> langDescriptions = descriptions[languageCode] ?? descriptions['es']!;
    return langDescriptions[Random().nextInt(langDescriptions.length)];
  }
}