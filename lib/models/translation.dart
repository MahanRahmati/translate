class Translation {
  Translation({
    required this.translation,
    required this.pronunciation,
  });

  factory Translation.fromJson({required Map<String, dynamic> json}) {
    Map<String, dynamic>? info;
    String? pronunciation;
    info = json['info'] as Map<String, dynamic>;
    if (json['info'] != null) {
      final Map<String, dynamic> pron =
          info['pronunciation'] as Map<String, dynamic>;
      if (pronunciation != null) {
        pronunciation = pron['translation'] as String;
      }
    }

    return Translation(
      translation: json['translation'] as String?,
      pronunciation: pronunciation,
    );
  }

  final String? translation;

  final String? pronunciation;
}
