/// The five supported trading-card franchises.
///
/// [code] is the stable string persisted in the `games` table.
enum GameType {
  pokemon('pokemon', 'Pokémon'),
  onePiece('onepiece', 'One Piece'),
  yugioh('yugioh', 'Yu-Gi-Oh!'),
  mtg('mtg', 'Magic: The Gathering'),
  sports('sports', 'Sports Cards');

  const GameType(this.code, this.label);

  final String code;
  final String label;

  static GameType fromCode(String code) =>
      GameType.values.firstWhere((g) => g.code == code, orElse: () => pokemon);
}

/// Physical condition grading (stored as the enum [code]).
enum CardCondition {
  mint('M', 'Mint'),
  nearMint('NM', 'Near Mint'),
  lightlyPlayed('LP', 'Lightly Played'),
  moderatelyPlayed('MP', 'Moderately Played'),
  heavilyPlayed('HP', 'Heavily Played'),
  damaged('DMG', 'Damaged');

  const CardCondition(this.code, this.label);

  final String code;
  final String label;

  static CardCondition fromCode(String code) => CardCondition.values
      .firstWhere((c) => c.code == code, orElse: () => nearMint);
}

/// Whether a card is owned or merely wished for.
enum CardStatus {
  owned('owned'),
  wishlist('wishlist');

  const CardStatus(this.code);

  final String code;

  static CardStatus fromCode(String code) =>
      CardStatus.values.firstWhere((s) => s.code == code, orElse: () => owned);
}
