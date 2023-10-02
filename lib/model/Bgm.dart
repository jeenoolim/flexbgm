class Bgm {
  final String loginId;
  final String createdAt;
  final List<Media> playlist;
  Bgm({
    required this.loginId,
    required this.createdAt,
    required this.playlist,
  });

  factory Bgm.fromMap(Map<String, dynamic> map) {
    return Bgm(
      loginId: map['loginId'] as String,
      createdAt: map['createdAt'] as String,
      playlist: List<Media>.from(
        (map['playlist'] as List<dynamic>).map<Media>(
          (x) => Media.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}

enum SourceType {
  file('file', '파일'),
  url('url', '온라인');

  final String value;
  final String label;
  const SourceType(this.value, this.label);
}

class Media {
  final SourceType type;
  final String source;
  final String name;
  Media({
    required this.name,
    required this.type,
    required this.source,
  });

  factory Media.fromMap(Map<String, dynamic> map) {
    return Media(
        name: map['name'] as String,
        source: map['source'] as String,
        type: SourceType.values.firstWhere((e) => e.value == map['type']));
  }

  get value => null;
}
