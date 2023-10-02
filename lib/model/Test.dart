import 'dart:convert';

class Bgm {
  final List<Playlist> playlist;
  final String loginId;
  final String createdAt;
  Bgm({
    required this.playlist,
    required this.loginId,
    required this.createdAt,
  });

  Bgm copyWith({
    List<Playlist>? playlist,
    String? loginId,
    String? createdAt,
  }) {
    return Bgm(
      playlist: playlist ?? this.playlist,
      loginId: loginId ?? this.loginId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'playlist': playlist.map((x) => x.toMap()).toList(),
      'loginId': loginId,
      'createdAt': createdAt,
    };
  }

  factory Bgm.fromMap(Map<String, dynamic> map) {
    return Bgm(
      playlist: List<Playlist>.from((map['playlist'] as List<int>).map<Playlist>((x) => Playlist.fromMap(x as Map<String,dynamic>),),),
      loginId: map['loginId'] as String,
      createdAt: map['createdAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Bgm.fromJson(String source) => Bgm.fromMap(json.decode(source) as Map<String, dynamic>);

}

class Playlist {
  final String name;
  final String type;
  final String source;
  Playlist({
    required this.name,
    required this.type,
    required this.source,
  });

  Playlist copyWith({
    String? name,
    String? type,
    String? source,
  }) {
    return Playlist(
      name: name ?? this.name,
      type: type ?? this.type,
      source: source ?? this.source,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'type': type,
      'source': source,
    };
  }

  factory Playlist.fromMap(Map<String, dynamic> map) {
    return Playlist(
      name: map['name'] as String,
      type: map['type'] as String,
      source: map['source'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Playlist.fromJson(String source) => Playlist.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Playlist(name: $name, type: $type, source: $source)';

  @override
  bool operator ==(covariant Playlist other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.type == type &&
      other.source == source;
  }

  @override
  int get hashCode => name.hashCode ^ type.hashCode ^ source.hashCode;
}