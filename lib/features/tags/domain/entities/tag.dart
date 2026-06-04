/// Pure domain entity for a user-defined tag.
class TagEntity {
  const TagEntity({
    this.id,
    required this.name,
    this.color,
    this.cardCount = 0,
  });

  final int? id;
  final String name;

  /// Hex color string, e.g. `#FF5722`.
  final String? color;

  /// Number of cards carrying this tag (read path; 0 on write).
  final int cardCount;

  TagEntity copyWith({int? id, String? name, String? color, int? cardCount}) {
    return TagEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      cardCount: cardCount ?? this.cardCount,
    );
  }
}
