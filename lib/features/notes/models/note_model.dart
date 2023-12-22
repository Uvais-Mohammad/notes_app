import 'dart:ui';

final class Note  {
  final int? id;
  final String title;
  final String content;
  final Color color;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isSynced;
  final bool isTrashed;
  Note({
     this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.color,
    this.isSynced = false,
    this.isTrashed = false,
  });

  Note copyWith({
    int? id,
    String? title,
    String? content,
    Color? color,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isSynced,
    bool? isTrashed,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSynced: isSynced ?? this.isSynced,
      isTrashed: isTrashed ?? this.isTrashed,
    );
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      color: Color(json['color']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      isSynced: json['isSynced'] == 1,
      isTrashed: json['isTrashed'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'color': color.value,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isSynced': isSynced ? 1 : 0,
      'isTrashed': isTrashed ? 1 : 0,
    };
  }

  @override
  String toString() {
    return 'Note(id: $id, title: $title, content: $content, color: $color, createdAt: $createdAt, updatedAt: $updatedAt, isSynced: $isSynced, isTrashed: $isTrashed)';
  }
}
