import 'dart:convert';

class Bgm {
  final String? loginId;
  final List<Media> playlist;
  Bgm({
    required this.loginId,
    required this.playlist,
  });

  factory Bgm.fromMap(Map<String, dynamic> map) {
    Bgm bgm = Bgm(
      loginId: map['loginId'] as String,
      playlist: List<Media>.from(
        (map['playlist'] as List<dynamic>).map<Media>(
          (x) => Media.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
    return bgm;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'playlist': playlist.map((x) => x.toMap()).toList(),
      'loginId': loginId,
    };
  }

  String toJson() => json.encode(toMap());

  factory Bgm.fromJson(String source) =>
      Bgm.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Media {
  final String id;
  final String type;
  final String source;
  final String done;
  Media(
      {required this.id,
      required this.type,
      required this.source,
      required this.done});

  factory Media.fromMap(Map<String, dynamic> map) {
    return Media(
        id: map['id'] as String,
        source: map['source'] as String,
        done: map['done'] as String,
        type: map['type'] as String);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'source': source,
      'done': done,
      'type': type,
    };
  }

  get value => null;
}
