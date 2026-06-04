// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $GamesTable extends Games with TableInfo<$GamesTable, GameRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GamesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconAssetMeta =
      const VerificationMeta('iconAsset');
  @override
  late final GeneratedColumn<String> iconAsset = GeneratedColumn<String>(
      'icon_asset', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [id, code, name, iconAsset, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'games';
  @override
  VerificationContext validateIntegrity(Insertable<GameRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon_asset')) {
      context.handle(_iconAssetMeta,
          iconAsset.isAcceptableOrUnknown(data['icon_asset']!, _iconAssetMeta));
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GameRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GameRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      iconAsset: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon_asset']),
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
    );
  }

  @override
  $GamesTable createAlias(String alias) {
    return $GamesTable(attachedDatabase, alias);
  }
}

class GameRow extends DataClass implements Insertable<GameRow> {
  final int id;
  final String code;
  final String name;
  final String? iconAsset;
  final int sortOrder;
  const GameRow(
      {required this.id,
      required this.code,
      required this.name,
      this.iconAsset,
      required this.sortOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || iconAsset != null) {
      map['icon_asset'] = Variable<String>(iconAsset);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  GamesCompanion toCompanion(bool nullToAbsent) {
    return GamesCompanion(
      id: Value(id),
      code: Value(code),
      name: Value(name),
      iconAsset: iconAsset == null && nullToAbsent
          ? const Value.absent()
          : Value(iconAsset),
      sortOrder: Value(sortOrder),
    );
  }

  factory GameRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GameRow(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      iconAsset: serializer.fromJson<String?>(json['iconAsset']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'iconAsset': serializer.toJson<String?>(iconAsset),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  GameRow copyWith(
          {int? id,
          String? code,
          String? name,
          Value<String?> iconAsset = const Value.absent(),
          int? sortOrder}) =>
      GameRow(
        id: id ?? this.id,
        code: code ?? this.code,
        name: name ?? this.name,
        iconAsset: iconAsset.present ? iconAsset.value : this.iconAsset,
        sortOrder: sortOrder ?? this.sortOrder,
      );
  GameRow copyWithCompanion(GamesCompanion data) {
    return GameRow(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      iconAsset: data.iconAsset.present ? data.iconAsset.value : this.iconAsset,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GameRow(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('iconAsset: $iconAsset, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, code, name, iconAsset, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GameRow &&
          other.id == this.id &&
          other.code == this.code &&
          other.name == this.name &&
          other.iconAsset == this.iconAsset &&
          other.sortOrder == this.sortOrder);
}

class GamesCompanion extends UpdateCompanion<GameRow> {
  final Value<int> id;
  final Value<String> code;
  final Value<String> name;
  final Value<String?> iconAsset;
  final Value<int> sortOrder;
  const GamesCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.iconAsset = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  GamesCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required String name,
    this.iconAsset = const Value.absent(),
    this.sortOrder = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<GameRow> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? name,
    Expression<String>? iconAsset,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (iconAsset != null) 'icon_asset': iconAsset,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  GamesCompanion copyWith(
      {Value<int>? id,
      Value<String>? code,
      Value<String>? name,
      Value<String?>? iconAsset,
      Value<int>? sortOrder}) {
    return GamesCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      iconAsset: iconAsset ?? this.iconAsset,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (iconAsset.present) {
      map['icon_asset'] = Variable<String>(iconAsset.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GamesCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('iconAsset: $iconAsset, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $CardSetsTable extends CardSets with TableInfo<$CardSetsTable, SetRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CardSetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _gameIdMeta = const VerificationMeta('gameId');
  @override
  late final GeneratedColumn<int> gameId = GeneratedColumn<int>(
      'game_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES games (id)'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _releaseYearMeta =
      const VerificationMeta('releaseYear');
  @override
  late final GeneratedColumn<int> releaseYear = GeneratedColumn<int>(
      'release_year', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _totalCardsMeta =
      const VerificationMeta('totalCards');
  @override
  late final GeneratedColumn<int> totalCards = GeneratedColumn<int>(
      'total_cards', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, gameId, name, code, releaseYear, totalCards];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'card_sets';
  @override
  VerificationContext validateIntegrity(Insertable<SetRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('game_id')) {
      context.handle(_gameIdMeta,
          gameId.isAcceptableOrUnknown(data['game_id']!, _gameIdMeta));
    } else if (isInserting) {
      context.missing(_gameIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    }
    if (data.containsKey('release_year')) {
      context.handle(
          _releaseYearMeta,
          releaseYear.isAcceptableOrUnknown(
              data['release_year']!, _releaseYearMeta));
    }
    if (data.containsKey('total_cards')) {
      context.handle(
          _totalCardsMeta,
          totalCards.isAcceptableOrUnknown(
              data['total_cards']!, _totalCardsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SetRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SetRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      gameId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}game_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code']),
      releaseYear: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}release_year']),
      totalCards: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_cards']),
    );
  }

  @override
  $CardSetsTable createAlias(String alias) {
    return $CardSetsTable(attachedDatabase, alias);
  }
}

class SetRow extends DataClass implements Insertable<SetRow> {
  final int id;
  final int gameId;
  final String name;
  final String? code;
  final int? releaseYear;
  final int? totalCards;
  const SetRow(
      {required this.id,
      required this.gameId,
      required this.name,
      this.code,
      this.releaseYear,
      this.totalCards});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['game_id'] = Variable<int>(gameId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    if (!nullToAbsent || releaseYear != null) {
      map['release_year'] = Variable<int>(releaseYear);
    }
    if (!nullToAbsent || totalCards != null) {
      map['total_cards'] = Variable<int>(totalCards);
    }
    return map;
  }

  CardSetsCompanion toCompanion(bool nullToAbsent) {
    return CardSetsCompanion(
      id: Value(id),
      gameId: Value(gameId),
      name: Value(name),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      releaseYear: releaseYear == null && nullToAbsent
          ? const Value.absent()
          : Value(releaseYear),
      totalCards: totalCards == null && nullToAbsent
          ? const Value.absent()
          : Value(totalCards),
    );
  }

  factory SetRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SetRow(
      id: serializer.fromJson<int>(json['id']),
      gameId: serializer.fromJson<int>(json['gameId']),
      name: serializer.fromJson<String>(json['name']),
      code: serializer.fromJson<String?>(json['code']),
      releaseYear: serializer.fromJson<int?>(json['releaseYear']),
      totalCards: serializer.fromJson<int?>(json['totalCards']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'gameId': serializer.toJson<int>(gameId),
      'name': serializer.toJson<String>(name),
      'code': serializer.toJson<String?>(code),
      'releaseYear': serializer.toJson<int?>(releaseYear),
      'totalCards': serializer.toJson<int?>(totalCards),
    };
  }

  SetRow copyWith(
          {int? id,
          int? gameId,
          String? name,
          Value<String?> code = const Value.absent(),
          Value<int?> releaseYear = const Value.absent(),
          Value<int?> totalCards = const Value.absent()}) =>
      SetRow(
        id: id ?? this.id,
        gameId: gameId ?? this.gameId,
        name: name ?? this.name,
        code: code.present ? code.value : this.code,
        releaseYear: releaseYear.present ? releaseYear.value : this.releaseYear,
        totalCards: totalCards.present ? totalCards.value : this.totalCards,
      );
  SetRow copyWithCompanion(CardSetsCompanion data) {
    return SetRow(
      id: data.id.present ? data.id.value : this.id,
      gameId: data.gameId.present ? data.gameId.value : this.gameId,
      name: data.name.present ? data.name.value : this.name,
      code: data.code.present ? data.code.value : this.code,
      releaseYear:
          data.releaseYear.present ? data.releaseYear.value : this.releaseYear,
      totalCards:
          data.totalCards.present ? data.totalCards.value : this.totalCards,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SetRow(')
          ..write('id: $id, ')
          ..write('gameId: $gameId, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('releaseYear: $releaseYear, ')
          ..write('totalCards: $totalCards')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, gameId, name, code, releaseYear, totalCards);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SetRow &&
          other.id == this.id &&
          other.gameId == this.gameId &&
          other.name == this.name &&
          other.code == this.code &&
          other.releaseYear == this.releaseYear &&
          other.totalCards == this.totalCards);
}

class CardSetsCompanion extends UpdateCompanion<SetRow> {
  final Value<int> id;
  final Value<int> gameId;
  final Value<String> name;
  final Value<String?> code;
  final Value<int?> releaseYear;
  final Value<int?> totalCards;
  const CardSetsCompanion({
    this.id = const Value.absent(),
    this.gameId = const Value.absent(),
    this.name = const Value.absent(),
    this.code = const Value.absent(),
    this.releaseYear = const Value.absent(),
    this.totalCards = const Value.absent(),
  });
  CardSetsCompanion.insert({
    this.id = const Value.absent(),
    required int gameId,
    required String name,
    this.code = const Value.absent(),
    this.releaseYear = const Value.absent(),
    this.totalCards = const Value.absent(),
  })  : gameId = Value(gameId),
        name = Value(name);
  static Insertable<SetRow> custom({
    Expression<int>? id,
    Expression<int>? gameId,
    Expression<String>? name,
    Expression<String>? code,
    Expression<int>? releaseYear,
    Expression<int>? totalCards,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gameId != null) 'game_id': gameId,
      if (name != null) 'name': name,
      if (code != null) 'code': code,
      if (releaseYear != null) 'release_year': releaseYear,
      if (totalCards != null) 'total_cards': totalCards,
    });
  }

  CardSetsCompanion copyWith(
      {Value<int>? id,
      Value<int>? gameId,
      Value<String>? name,
      Value<String?>? code,
      Value<int?>? releaseYear,
      Value<int?>? totalCards}) {
    return CardSetsCompanion(
      id: id ?? this.id,
      gameId: gameId ?? this.gameId,
      name: name ?? this.name,
      code: code ?? this.code,
      releaseYear: releaseYear ?? this.releaseYear,
      totalCards: totalCards ?? this.totalCards,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (gameId.present) {
      map['game_id'] = Variable<int>(gameId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (releaseYear.present) {
      map['release_year'] = Variable<int>(releaseYear.value);
    }
    if (totalCards.present) {
      map['total_cards'] = Variable<int>(totalCards.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CardSetsCompanion(')
          ..write('id: $id, ')
          ..write('gameId: $gameId, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('releaseYear: $releaseYear, ')
          ..write('totalCards: $totalCards')
          ..write(')'))
        .toString();
  }
}

class $CardRowsTable extends CardRows with TableInfo<$CardRowsTable, CardRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CardRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _gameIdMeta = const VerificationMeta('gameId');
  @override
  late final GeneratedColumn<int> gameId = GeneratedColumn<int>(
      'game_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES games (id)'));
  static const VerificationMeta _setIdMeta = const VerificationMeta('setId');
  @override
  late final GeneratedColumn<int> setId = GeneratedColumn<int>(
      'set_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES card_sets (id)'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _cardNumberMeta =
      const VerificationMeta('cardNumber');
  @override
  late final GeneratedColumn<String> cardNumber = GeneratedColumn<String>(
      'card_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _rarityMeta = const VerificationMeta('rarity');
  @override
  late final GeneratedColumn<String> rarity = GeneratedColumn<String>(
      'rarity', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _conditionMeta =
      const VerificationMeta('condition');
  @override
  late final GeneratedColumn<String> condition = GeneratedColumn<String>(
      'condition', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('NM'));
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      check: () => ComparableExpr(quantity).isBiggerOrEqualValue(0),
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('owned'));
  static const VerificationMeta _isFavoriteMeta =
      const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
      'is_favorite', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_favorite" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _purchasePriceMeta =
      const VerificationMeta('purchasePrice');
  @override
  late final GeneratedColumn<double> purchasePrice = GeneratedColumn<double>(
      'purchase_price', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _currentValueMeta =
      const VerificationMeta('currentValue');
  @override
  late final GeneratedColumn<double> currentValue = GeneratedColumn<double>(
      'current_value', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _currencyMeta =
      const VerificationMeta('currency');
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
      'currency', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('USD'));
  static const VerificationMeta _wishlistPriorityMeta =
      const VerificationMeta('wishlistPriority');
  @override
  late final GeneratedColumn<int> wishlistPriority = GeneratedColumn<int>(
      'wishlist_priority', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _wishlistTargetPriceMeta =
      const VerificationMeta('wishlistTargetPrice');
  @override
  late final GeneratedColumn<double> wishlistTargetPrice =
      GeneratedColumn<double>('wishlist_target_price', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _languageMeta =
      const VerificationMeta('language');
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
      'language', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isGradedMeta =
      const VerificationMeta('isGraded');
  @override
  late final GeneratedColumn<bool> isGraded = GeneratedColumn<bool>(
      'is_graded', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_graded" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _gradeMeta = const VerificationMeta('grade');
  @override
  late final GeneratedColumn<String> grade = GeneratedColumn<String>(
      'grade', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        gameId,
        setId,
        name,
        cardNumber,
        rarity,
        condition,
        quantity,
        status,
        isFavorite,
        purchasePrice,
        currentValue,
        currency,
        wishlistPriority,
        wishlistTargetPrice,
        language,
        isGraded,
        grade,
        notes,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'card_rows';
  @override
  VerificationContext validateIntegrity(Insertable<CardRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('game_id')) {
      context.handle(_gameIdMeta,
          gameId.isAcceptableOrUnknown(data['game_id']!, _gameIdMeta));
    } else if (isInserting) {
      context.missing(_gameIdMeta);
    }
    if (data.containsKey('set_id')) {
      context.handle(
          _setIdMeta, setId.isAcceptableOrUnknown(data['set_id']!, _setIdMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('card_number')) {
      context.handle(
          _cardNumberMeta,
          cardNumber.isAcceptableOrUnknown(
              data['card_number']!, _cardNumberMeta));
    }
    if (data.containsKey('rarity')) {
      context.handle(_rarityMeta,
          rarity.isAcceptableOrUnknown(data['rarity']!, _rarityMeta));
    }
    if (data.containsKey('condition')) {
      context.handle(_conditionMeta,
          condition.isAcceptableOrUnknown(data['condition']!, _conditionMeta));
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite']!, _isFavoriteMeta));
    }
    if (data.containsKey('purchase_price')) {
      context.handle(
          _purchasePriceMeta,
          purchasePrice.isAcceptableOrUnknown(
              data['purchase_price']!, _purchasePriceMeta));
    }
    if (data.containsKey('current_value')) {
      context.handle(
          _currentValueMeta,
          currentValue.isAcceptableOrUnknown(
              data['current_value']!, _currentValueMeta));
    }
    if (data.containsKey('currency')) {
      context.handle(_currencyMeta,
          currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta));
    }
    if (data.containsKey('wishlist_priority')) {
      context.handle(
          _wishlistPriorityMeta,
          wishlistPriority.isAcceptableOrUnknown(
              data['wishlist_priority']!, _wishlistPriorityMeta));
    }
    if (data.containsKey('wishlist_target_price')) {
      context.handle(
          _wishlistTargetPriceMeta,
          wishlistTargetPrice.isAcceptableOrUnknown(
              data['wishlist_target_price']!, _wishlistTargetPriceMeta));
    }
    if (data.containsKey('language')) {
      context.handle(_languageMeta,
          language.isAcceptableOrUnknown(data['language']!, _languageMeta));
    }
    if (data.containsKey('is_graded')) {
      context.handle(_isGradedMeta,
          isGraded.isAcceptableOrUnknown(data['is_graded']!, _isGradedMeta));
    }
    if (data.containsKey('grade')) {
      context.handle(
          _gradeMeta, grade.isAcceptableOrUnknown(data['grade']!, _gradeMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CardRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CardRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      gameId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}game_id'])!,
      setId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}set_id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      cardNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}card_number']),
      rarity: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}rarity']),
      condition: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}condition'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      isFavorite: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!,
      purchasePrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}purchase_price']),
      currentValue: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}current_value']),
      currency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency'])!,
      wishlistPriority: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}wishlist_priority']),
      wishlistTargetPrice: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}wishlist_target_price']),
      language: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language']),
      isGraded: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_graded'])!,
      grade: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}grade']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $CardRowsTable createAlias(String alias) {
    return $CardRowsTable(attachedDatabase, alias);
  }
}

class CardRow extends DataClass implements Insertable<CardRow> {
  final int id;
  final int gameId;
  final int? setId;
  final String name;
  final String? cardNumber;
  final String? rarity;
  final String condition;
  final int quantity;
  final String status;
  final bool isFavorite;
  final double? purchasePrice;
  final double? currentValue;
  final String currency;
  final int? wishlistPriority;
  final double? wishlistTargetPrice;
  final String? language;
  final bool isGraded;
  final String? grade;
  final String? notes;
  final int createdAt;
  final int updatedAt;
  const CardRow(
      {required this.id,
      required this.gameId,
      this.setId,
      required this.name,
      this.cardNumber,
      this.rarity,
      required this.condition,
      required this.quantity,
      required this.status,
      required this.isFavorite,
      this.purchasePrice,
      this.currentValue,
      required this.currency,
      this.wishlistPriority,
      this.wishlistTargetPrice,
      this.language,
      required this.isGraded,
      this.grade,
      this.notes,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['game_id'] = Variable<int>(gameId);
    if (!nullToAbsent || setId != null) {
      map['set_id'] = Variable<int>(setId);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || cardNumber != null) {
      map['card_number'] = Variable<String>(cardNumber);
    }
    if (!nullToAbsent || rarity != null) {
      map['rarity'] = Variable<String>(rarity);
    }
    map['condition'] = Variable<String>(condition);
    map['quantity'] = Variable<int>(quantity);
    map['status'] = Variable<String>(status);
    map['is_favorite'] = Variable<bool>(isFavorite);
    if (!nullToAbsent || purchasePrice != null) {
      map['purchase_price'] = Variable<double>(purchasePrice);
    }
    if (!nullToAbsent || currentValue != null) {
      map['current_value'] = Variable<double>(currentValue);
    }
    map['currency'] = Variable<String>(currency);
    if (!nullToAbsent || wishlistPriority != null) {
      map['wishlist_priority'] = Variable<int>(wishlistPriority);
    }
    if (!nullToAbsent || wishlistTargetPrice != null) {
      map['wishlist_target_price'] = Variable<double>(wishlistTargetPrice);
    }
    if (!nullToAbsent || language != null) {
      map['language'] = Variable<String>(language);
    }
    map['is_graded'] = Variable<bool>(isGraded);
    if (!nullToAbsent || grade != null) {
      map['grade'] = Variable<String>(grade);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  CardRowsCompanion toCompanion(bool nullToAbsent) {
    return CardRowsCompanion(
      id: Value(id),
      gameId: Value(gameId),
      setId:
          setId == null && nullToAbsent ? const Value.absent() : Value(setId),
      name: Value(name),
      cardNumber: cardNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(cardNumber),
      rarity:
          rarity == null && nullToAbsent ? const Value.absent() : Value(rarity),
      condition: Value(condition),
      quantity: Value(quantity),
      status: Value(status),
      isFavorite: Value(isFavorite),
      purchasePrice: purchasePrice == null && nullToAbsent
          ? const Value.absent()
          : Value(purchasePrice),
      currentValue: currentValue == null && nullToAbsent
          ? const Value.absent()
          : Value(currentValue),
      currency: Value(currency),
      wishlistPriority: wishlistPriority == null && nullToAbsent
          ? const Value.absent()
          : Value(wishlistPriority),
      wishlistTargetPrice: wishlistTargetPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(wishlistTargetPrice),
      language: language == null && nullToAbsent
          ? const Value.absent()
          : Value(language),
      isGraded: Value(isGraded),
      grade:
          grade == null && nullToAbsent ? const Value.absent() : Value(grade),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CardRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CardRow(
      id: serializer.fromJson<int>(json['id']),
      gameId: serializer.fromJson<int>(json['gameId']),
      setId: serializer.fromJson<int?>(json['setId']),
      name: serializer.fromJson<String>(json['name']),
      cardNumber: serializer.fromJson<String?>(json['cardNumber']),
      rarity: serializer.fromJson<String?>(json['rarity']),
      condition: serializer.fromJson<String>(json['condition']),
      quantity: serializer.fromJson<int>(json['quantity']),
      status: serializer.fromJson<String>(json['status']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      purchasePrice: serializer.fromJson<double?>(json['purchasePrice']),
      currentValue: serializer.fromJson<double?>(json['currentValue']),
      currency: serializer.fromJson<String>(json['currency']),
      wishlistPriority: serializer.fromJson<int?>(json['wishlistPriority']),
      wishlistTargetPrice:
          serializer.fromJson<double?>(json['wishlistTargetPrice']),
      language: serializer.fromJson<String?>(json['language']),
      isGraded: serializer.fromJson<bool>(json['isGraded']),
      grade: serializer.fromJson<String?>(json['grade']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'gameId': serializer.toJson<int>(gameId),
      'setId': serializer.toJson<int?>(setId),
      'name': serializer.toJson<String>(name),
      'cardNumber': serializer.toJson<String?>(cardNumber),
      'rarity': serializer.toJson<String?>(rarity),
      'condition': serializer.toJson<String>(condition),
      'quantity': serializer.toJson<int>(quantity),
      'status': serializer.toJson<String>(status),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'purchasePrice': serializer.toJson<double?>(purchasePrice),
      'currentValue': serializer.toJson<double?>(currentValue),
      'currency': serializer.toJson<String>(currency),
      'wishlistPriority': serializer.toJson<int?>(wishlistPriority),
      'wishlistTargetPrice': serializer.toJson<double?>(wishlistTargetPrice),
      'language': serializer.toJson<String?>(language),
      'isGraded': serializer.toJson<bool>(isGraded),
      'grade': serializer.toJson<String?>(grade),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  CardRow copyWith(
          {int? id,
          int? gameId,
          Value<int?> setId = const Value.absent(),
          String? name,
          Value<String?> cardNumber = const Value.absent(),
          Value<String?> rarity = const Value.absent(),
          String? condition,
          int? quantity,
          String? status,
          bool? isFavorite,
          Value<double?> purchasePrice = const Value.absent(),
          Value<double?> currentValue = const Value.absent(),
          String? currency,
          Value<int?> wishlistPriority = const Value.absent(),
          Value<double?> wishlistTargetPrice = const Value.absent(),
          Value<String?> language = const Value.absent(),
          bool? isGraded,
          Value<String?> grade = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          int? createdAt,
          int? updatedAt}) =>
      CardRow(
        id: id ?? this.id,
        gameId: gameId ?? this.gameId,
        setId: setId.present ? setId.value : this.setId,
        name: name ?? this.name,
        cardNumber: cardNumber.present ? cardNumber.value : this.cardNumber,
        rarity: rarity.present ? rarity.value : this.rarity,
        condition: condition ?? this.condition,
        quantity: quantity ?? this.quantity,
        status: status ?? this.status,
        isFavorite: isFavorite ?? this.isFavorite,
        purchasePrice:
            purchasePrice.present ? purchasePrice.value : this.purchasePrice,
        currentValue:
            currentValue.present ? currentValue.value : this.currentValue,
        currency: currency ?? this.currency,
        wishlistPriority: wishlistPriority.present
            ? wishlistPriority.value
            : this.wishlistPriority,
        wishlistTargetPrice: wishlistTargetPrice.present
            ? wishlistTargetPrice.value
            : this.wishlistTargetPrice,
        language: language.present ? language.value : this.language,
        isGraded: isGraded ?? this.isGraded,
        grade: grade.present ? grade.value : this.grade,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  CardRow copyWithCompanion(CardRowsCompanion data) {
    return CardRow(
      id: data.id.present ? data.id.value : this.id,
      gameId: data.gameId.present ? data.gameId.value : this.gameId,
      setId: data.setId.present ? data.setId.value : this.setId,
      name: data.name.present ? data.name.value : this.name,
      cardNumber:
          data.cardNumber.present ? data.cardNumber.value : this.cardNumber,
      rarity: data.rarity.present ? data.rarity.value : this.rarity,
      condition: data.condition.present ? data.condition.value : this.condition,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      status: data.status.present ? data.status.value : this.status,
      isFavorite:
          data.isFavorite.present ? data.isFavorite.value : this.isFavorite,
      purchasePrice: data.purchasePrice.present
          ? data.purchasePrice.value
          : this.purchasePrice,
      currentValue: data.currentValue.present
          ? data.currentValue.value
          : this.currentValue,
      currency: data.currency.present ? data.currency.value : this.currency,
      wishlistPriority: data.wishlistPriority.present
          ? data.wishlistPriority.value
          : this.wishlistPriority,
      wishlistTargetPrice: data.wishlistTargetPrice.present
          ? data.wishlistTargetPrice.value
          : this.wishlistTargetPrice,
      language: data.language.present ? data.language.value : this.language,
      isGraded: data.isGraded.present ? data.isGraded.value : this.isGraded,
      grade: data.grade.present ? data.grade.value : this.grade,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CardRow(')
          ..write('id: $id, ')
          ..write('gameId: $gameId, ')
          ..write('setId: $setId, ')
          ..write('name: $name, ')
          ..write('cardNumber: $cardNumber, ')
          ..write('rarity: $rarity, ')
          ..write('condition: $condition, ')
          ..write('quantity: $quantity, ')
          ..write('status: $status, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('currentValue: $currentValue, ')
          ..write('currency: $currency, ')
          ..write('wishlistPriority: $wishlistPriority, ')
          ..write('wishlistTargetPrice: $wishlistTargetPrice, ')
          ..write('language: $language, ')
          ..write('isGraded: $isGraded, ')
          ..write('grade: $grade, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        gameId,
        setId,
        name,
        cardNumber,
        rarity,
        condition,
        quantity,
        status,
        isFavorite,
        purchasePrice,
        currentValue,
        currency,
        wishlistPriority,
        wishlistTargetPrice,
        language,
        isGraded,
        grade,
        notes,
        createdAt,
        updatedAt
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CardRow &&
          other.id == this.id &&
          other.gameId == this.gameId &&
          other.setId == this.setId &&
          other.name == this.name &&
          other.cardNumber == this.cardNumber &&
          other.rarity == this.rarity &&
          other.condition == this.condition &&
          other.quantity == this.quantity &&
          other.status == this.status &&
          other.isFavorite == this.isFavorite &&
          other.purchasePrice == this.purchasePrice &&
          other.currentValue == this.currentValue &&
          other.currency == this.currency &&
          other.wishlistPriority == this.wishlistPriority &&
          other.wishlistTargetPrice == this.wishlistTargetPrice &&
          other.language == this.language &&
          other.isGraded == this.isGraded &&
          other.grade == this.grade &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CardRowsCompanion extends UpdateCompanion<CardRow> {
  final Value<int> id;
  final Value<int> gameId;
  final Value<int?> setId;
  final Value<String> name;
  final Value<String?> cardNumber;
  final Value<String?> rarity;
  final Value<String> condition;
  final Value<int> quantity;
  final Value<String> status;
  final Value<bool> isFavorite;
  final Value<double?> purchasePrice;
  final Value<double?> currentValue;
  final Value<String> currency;
  final Value<int?> wishlistPriority;
  final Value<double?> wishlistTargetPrice;
  final Value<String?> language;
  final Value<bool> isGraded;
  final Value<String?> grade;
  final Value<String?> notes;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  const CardRowsCompanion({
    this.id = const Value.absent(),
    this.gameId = const Value.absent(),
    this.setId = const Value.absent(),
    this.name = const Value.absent(),
    this.cardNumber = const Value.absent(),
    this.rarity = const Value.absent(),
    this.condition = const Value.absent(),
    this.quantity = const Value.absent(),
    this.status = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.purchasePrice = const Value.absent(),
    this.currentValue = const Value.absent(),
    this.currency = const Value.absent(),
    this.wishlistPriority = const Value.absent(),
    this.wishlistTargetPrice = const Value.absent(),
    this.language = const Value.absent(),
    this.isGraded = const Value.absent(),
    this.grade = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CardRowsCompanion.insert({
    this.id = const Value.absent(),
    required int gameId,
    this.setId = const Value.absent(),
    required String name,
    this.cardNumber = const Value.absent(),
    this.rarity = const Value.absent(),
    this.condition = const Value.absent(),
    this.quantity = const Value.absent(),
    this.status = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.purchasePrice = const Value.absent(),
    this.currentValue = const Value.absent(),
    this.currency = const Value.absent(),
    this.wishlistPriority = const Value.absent(),
    this.wishlistTargetPrice = const Value.absent(),
    this.language = const Value.absent(),
    this.isGraded = const Value.absent(),
    this.grade = const Value.absent(),
    this.notes = const Value.absent(),
    required int createdAt,
    required int updatedAt,
  })  : gameId = Value(gameId),
        name = Value(name),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<CardRow> custom({
    Expression<int>? id,
    Expression<int>? gameId,
    Expression<int>? setId,
    Expression<String>? name,
    Expression<String>? cardNumber,
    Expression<String>? rarity,
    Expression<String>? condition,
    Expression<int>? quantity,
    Expression<String>? status,
    Expression<bool>? isFavorite,
    Expression<double>? purchasePrice,
    Expression<double>? currentValue,
    Expression<String>? currency,
    Expression<int>? wishlistPriority,
    Expression<double>? wishlistTargetPrice,
    Expression<String>? language,
    Expression<bool>? isGraded,
    Expression<String>? grade,
    Expression<String>? notes,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gameId != null) 'game_id': gameId,
      if (setId != null) 'set_id': setId,
      if (name != null) 'name': name,
      if (cardNumber != null) 'card_number': cardNumber,
      if (rarity != null) 'rarity': rarity,
      if (condition != null) 'condition': condition,
      if (quantity != null) 'quantity': quantity,
      if (status != null) 'status': status,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (purchasePrice != null) 'purchase_price': purchasePrice,
      if (currentValue != null) 'current_value': currentValue,
      if (currency != null) 'currency': currency,
      if (wishlistPriority != null) 'wishlist_priority': wishlistPriority,
      if (wishlistTargetPrice != null)
        'wishlist_target_price': wishlistTargetPrice,
      if (language != null) 'language': language,
      if (isGraded != null) 'is_graded': isGraded,
      if (grade != null) 'grade': grade,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CardRowsCompanion copyWith(
      {Value<int>? id,
      Value<int>? gameId,
      Value<int?>? setId,
      Value<String>? name,
      Value<String?>? cardNumber,
      Value<String?>? rarity,
      Value<String>? condition,
      Value<int>? quantity,
      Value<String>? status,
      Value<bool>? isFavorite,
      Value<double?>? purchasePrice,
      Value<double?>? currentValue,
      Value<String>? currency,
      Value<int?>? wishlistPriority,
      Value<double?>? wishlistTargetPrice,
      Value<String?>? language,
      Value<bool>? isGraded,
      Value<String?>? grade,
      Value<String?>? notes,
      Value<int>? createdAt,
      Value<int>? updatedAt}) {
    return CardRowsCompanion(
      id: id ?? this.id,
      gameId: gameId ?? this.gameId,
      setId: setId ?? this.setId,
      name: name ?? this.name,
      cardNumber: cardNumber ?? this.cardNumber,
      rarity: rarity ?? this.rarity,
      condition: condition ?? this.condition,
      quantity: quantity ?? this.quantity,
      status: status ?? this.status,
      isFavorite: isFavorite ?? this.isFavorite,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      currentValue: currentValue ?? this.currentValue,
      currency: currency ?? this.currency,
      wishlistPriority: wishlistPriority ?? this.wishlistPriority,
      wishlistTargetPrice: wishlistTargetPrice ?? this.wishlistTargetPrice,
      language: language ?? this.language,
      isGraded: isGraded ?? this.isGraded,
      grade: grade ?? this.grade,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (gameId.present) {
      map['game_id'] = Variable<int>(gameId.value);
    }
    if (setId.present) {
      map['set_id'] = Variable<int>(setId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (cardNumber.present) {
      map['card_number'] = Variable<String>(cardNumber.value);
    }
    if (rarity.present) {
      map['rarity'] = Variable<String>(rarity.value);
    }
    if (condition.present) {
      map['condition'] = Variable<String>(condition.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (purchasePrice.present) {
      map['purchase_price'] = Variable<double>(purchasePrice.value);
    }
    if (currentValue.present) {
      map['current_value'] = Variable<double>(currentValue.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (wishlistPriority.present) {
      map['wishlist_priority'] = Variable<int>(wishlistPriority.value);
    }
    if (wishlistTargetPrice.present) {
      map['wishlist_target_price'] =
          Variable<double>(wishlistTargetPrice.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (isGraded.present) {
      map['is_graded'] = Variable<bool>(isGraded.value);
    }
    if (grade.present) {
      map['grade'] = Variable<String>(grade.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CardRowsCompanion(')
          ..write('id: $id, ')
          ..write('gameId: $gameId, ')
          ..write('setId: $setId, ')
          ..write('name: $name, ')
          ..write('cardNumber: $cardNumber, ')
          ..write('rarity: $rarity, ')
          ..write('condition: $condition, ')
          ..write('quantity: $quantity, ')
          ..write('status: $status, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('currentValue: $currentValue, ')
          ..write('currency: $currency, ')
          ..write('wishlistPriority: $wishlistPriority, ')
          ..write('wishlistTargetPrice: $wishlistTargetPrice, ')
          ..write('language: $language, ')
          ..write('isGraded: $isGraded, ')
          ..write('grade: $grade, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CardImagesTable extends CardImages
    with TableInfo<$CardImagesTable, CardImageRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CardImagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<int> cardId = GeneratedColumn<int>(
      'card_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES card_rows (id) ON DELETE CASCADE'));
  static const VerificationMeta _filePathMeta =
      const VerificationMeta('filePath');
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
      'file_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _thumbPathMeta =
      const VerificationMeta('thumbPath');
  @override
  late final GeneratedColumn<String> thumbPath = GeneratedColumn<String>(
      'thumb_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isPrimaryMeta =
      const VerificationMeta('isPrimary');
  @override
  late final GeneratedColumn<bool> isPrimary = GeneratedColumn<bool>(
      'is_primary', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_primary" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _sideMeta = const VerificationMeta('side');
  @override
  late final GeneratedColumn<String> side = GeneratedColumn<String>(
      'side', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('front'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, cardId, filePath, thumbPath, isPrimary, side, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'card_images';
  @override
  VerificationContext validateIntegrity(Insertable<CardImageRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('card_id')) {
      context.handle(_cardIdMeta,
          cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta));
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    if (data.containsKey('file_path')) {
      context.handle(_filePathMeta,
          filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta));
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('thumb_path')) {
      context.handle(_thumbPathMeta,
          thumbPath.isAcceptableOrUnknown(data['thumb_path']!, _thumbPathMeta));
    }
    if (data.containsKey('is_primary')) {
      context.handle(_isPrimaryMeta,
          isPrimary.isAcceptableOrUnknown(data['is_primary']!, _isPrimaryMeta));
    }
    if (data.containsKey('side')) {
      context.handle(
          _sideMeta, side.isAcceptableOrUnknown(data['side']!, _sideMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CardImageRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CardImageRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      cardId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}card_id'])!,
      filePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_path'])!,
      thumbPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}thumb_path']),
      isPrimary: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_primary'])!,
      side: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}side'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $CardImagesTable createAlias(String alias) {
    return $CardImagesTable(attachedDatabase, alias);
  }
}

class CardImageRow extends DataClass implements Insertable<CardImageRow> {
  final int id;
  final int cardId;
  final String filePath;
  final String? thumbPath;
  final bool isPrimary;
  final String side;
  final int createdAt;
  const CardImageRow(
      {required this.id,
      required this.cardId,
      required this.filePath,
      this.thumbPath,
      required this.isPrimary,
      required this.side,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['card_id'] = Variable<int>(cardId);
    map['file_path'] = Variable<String>(filePath);
    if (!nullToAbsent || thumbPath != null) {
      map['thumb_path'] = Variable<String>(thumbPath);
    }
    map['is_primary'] = Variable<bool>(isPrimary);
    map['side'] = Variable<String>(side);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  CardImagesCompanion toCompanion(bool nullToAbsent) {
    return CardImagesCompanion(
      id: Value(id),
      cardId: Value(cardId),
      filePath: Value(filePath),
      thumbPath: thumbPath == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbPath),
      isPrimary: Value(isPrimary),
      side: Value(side),
      createdAt: Value(createdAt),
    );
  }

  factory CardImageRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CardImageRow(
      id: serializer.fromJson<int>(json['id']),
      cardId: serializer.fromJson<int>(json['cardId']),
      filePath: serializer.fromJson<String>(json['filePath']),
      thumbPath: serializer.fromJson<String?>(json['thumbPath']),
      isPrimary: serializer.fromJson<bool>(json['isPrimary']),
      side: serializer.fromJson<String>(json['side']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cardId': serializer.toJson<int>(cardId),
      'filePath': serializer.toJson<String>(filePath),
      'thumbPath': serializer.toJson<String?>(thumbPath),
      'isPrimary': serializer.toJson<bool>(isPrimary),
      'side': serializer.toJson<String>(side),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  CardImageRow copyWith(
          {int? id,
          int? cardId,
          String? filePath,
          Value<String?> thumbPath = const Value.absent(),
          bool? isPrimary,
          String? side,
          int? createdAt}) =>
      CardImageRow(
        id: id ?? this.id,
        cardId: cardId ?? this.cardId,
        filePath: filePath ?? this.filePath,
        thumbPath: thumbPath.present ? thumbPath.value : this.thumbPath,
        isPrimary: isPrimary ?? this.isPrimary,
        side: side ?? this.side,
        createdAt: createdAt ?? this.createdAt,
      );
  CardImageRow copyWithCompanion(CardImagesCompanion data) {
    return CardImageRow(
      id: data.id.present ? data.id.value : this.id,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      thumbPath: data.thumbPath.present ? data.thumbPath.value : this.thumbPath,
      isPrimary: data.isPrimary.present ? data.isPrimary.value : this.isPrimary,
      side: data.side.present ? data.side.value : this.side,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CardImageRow(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('filePath: $filePath, ')
          ..write('thumbPath: $thumbPath, ')
          ..write('isPrimary: $isPrimary, ')
          ..write('side: $side, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, cardId, filePath, thumbPath, isPrimary, side, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CardImageRow &&
          other.id == this.id &&
          other.cardId == this.cardId &&
          other.filePath == this.filePath &&
          other.thumbPath == this.thumbPath &&
          other.isPrimary == this.isPrimary &&
          other.side == this.side &&
          other.createdAt == this.createdAt);
}

class CardImagesCompanion extends UpdateCompanion<CardImageRow> {
  final Value<int> id;
  final Value<int> cardId;
  final Value<String> filePath;
  final Value<String?> thumbPath;
  final Value<bool> isPrimary;
  final Value<String> side;
  final Value<int> createdAt;
  const CardImagesCompanion({
    this.id = const Value.absent(),
    this.cardId = const Value.absent(),
    this.filePath = const Value.absent(),
    this.thumbPath = const Value.absent(),
    this.isPrimary = const Value.absent(),
    this.side = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CardImagesCompanion.insert({
    this.id = const Value.absent(),
    required int cardId,
    required String filePath,
    this.thumbPath = const Value.absent(),
    this.isPrimary = const Value.absent(),
    this.side = const Value.absent(),
    required int createdAt,
  })  : cardId = Value(cardId),
        filePath = Value(filePath),
        createdAt = Value(createdAt);
  static Insertable<CardImageRow> custom({
    Expression<int>? id,
    Expression<int>? cardId,
    Expression<String>? filePath,
    Expression<String>? thumbPath,
    Expression<bool>? isPrimary,
    Expression<String>? side,
    Expression<int>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cardId != null) 'card_id': cardId,
      if (filePath != null) 'file_path': filePath,
      if (thumbPath != null) 'thumb_path': thumbPath,
      if (isPrimary != null) 'is_primary': isPrimary,
      if (side != null) 'side': side,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CardImagesCompanion copyWith(
      {Value<int>? id,
      Value<int>? cardId,
      Value<String>? filePath,
      Value<String?>? thumbPath,
      Value<bool>? isPrimary,
      Value<String>? side,
      Value<int>? createdAt}) {
    return CardImagesCompanion(
      id: id ?? this.id,
      cardId: cardId ?? this.cardId,
      filePath: filePath ?? this.filePath,
      thumbPath: thumbPath ?? this.thumbPath,
      isPrimary: isPrimary ?? this.isPrimary,
      side: side ?? this.side,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cardId.present) {
      map['card_id'] = Variable<int>(cardId.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (thumbPath.present) {
      map['thumb_path'] = Variable<String>(thumbPath.value);
    }
    if (isPrimary.present) {
      map['is_primary'] = Variable<bool>(isPrimary.value);
    }
    if (side.present) {
      map['side'] = Variable<String>(side.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CardImagesCompanion(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('filePath: $filePath, ')
          ..write('thumbPath: $thumbPath, ')
          ..write('isPrimary: $isPrimary, ')
          ..write('side: $side, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, TagRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
      'color', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, color, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tags';
  @override
  VerificationContext validateIntegrity(Insertable<TagRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TagRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TagRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(attachedDatabase, alias);
  }
}

class TagRow extends DataClass implements Insertable<TagRow> {
  final int id;
  final String name;
  final String? color;
  final int createdAt;
  const TagRow(
      {required this.id,
      required this.name,
      this.color,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: Value(id),
      name: Value(name),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      createdAt: Value(createdAt),
    );
  }

  factory TagRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TagRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      color: serializer.fromJson<String?>(json['color']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<String?>(color),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  TagRow copyWith(
          {int? id,
          String? name,
          Value<String?> color = const Value.absent(),
          int? createdAt}) =>
      TagRow(
        id: id ?? this.id,
        name: name ?? this.name,
        color: color.present ? color.value : this.color,
        createdAt: createdAt ?? this.createdAt,
      );
  TagRow copyWithCompanion(TagsCompanion data) {
    return TagRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      color: data.color.present ? data.color.value : this.color,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TagRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, color, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TagRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.color == this.color &&
          other.createdAt == this.createdAt);
}

class TagsCompanion extends UpdateCompanion<TagRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> color;
  final Value<int> createdAt;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.color = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TagsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.color = const Value.absent(),
    required int createdAt,
  })  : name = Value(name),
        createdAt = Value(createdAt);
  static Insertable<TagRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? color,
    Expression<int>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (color != null) 'color': color,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TagsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? color,
      Value<int>? createdAt}) {
    return TagsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CardTagsTable extends CardTags
    with TableInfo<$CardTagsTable, CardTagRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CardTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<int> cardId = GeneratedColumn<int>(
      'card_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES card_rows (id) ON DELETE CASCADE'));
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<int> tagId = GeneratedColumn<int>(
      'tag_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES tags (id) ON DELETE CASCADE'));
  @override
  List<GeneratedColumn> get $columns => [cardId, tagId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'card_tags';
  @override
  VerificationContext validateIntegrity(Insertable<CardTagRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('card_id')) {
      context.handle(_cardIdMeta,
          cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta));
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
          _tagIdMeta, tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta));
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {cardId, tagId};
  @override
  CardTagRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CardTagRow(
      cardId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}card_id'])!,
      tagId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tag_id'])!,
    );
  }

  @override
  $CardTagsTable createAlias(String alias) {
    return $CardTagsTable(attachedDatabase, alias);
  }
}

class CardTagRow extends DataClass implements Insertable<CardTagRow> {
  final int cardId;
  final int tagId;
  const CardTagRow({required this.cardId, required this.tagId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['card_id'] = Variable<int>(cardId);
    map['tag_id'] = Variable<int>(tagId);
    return map;
  }

  CardTagsCompanion toCompanion(bool nullToAbsent) {
    return CardTagsCompanion(
      cardId: Value(cardId),
      tagId: Value(tagId),
    );
  }

  factory CardTagRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CardTagRow(
      cardId: serializer.fromJson<int>(json['cardId']),
      tagId: serializer.fromJson<int>(json['tagId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'cardId': serializer.toJson<int>(cardId),
      'tagId': serializer.toJson<int>(tagId),
    };
  }

  CardTagRow copyWith({int? cardId, int? tagId}) => CardTagRow(
        cardId: cardId ?? this.cardId,
        tagId: tagId ?? this.tagId,
      );
  CardTagRow copyWithCompanion(CardTagsCompanion data) {
    return CardTagRow(
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CardTagRow(')
          ..write('cardId: $cardId, ')
          ..write('tagId: $tagId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(cardId, tagId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CardTagRow &&
          other.cardId == this.cardId &&
          other.tagId == this.tagId);
}

class CardTagsCompanion extends UpdateCompanion<CardTagRow> {
  final Value<int> cardId;
  final Value<int> tagId;
  final Value<int> rowid;
  const CardTagsCompanion({
    this.cardId = const Value.absent(),
    this.tagId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CardTagsCompanion.insert({
    required int cardId,
    required int tagId,
    this.rowid = const Value.absent(),
  })  : cardId = Value(cardId),
        tagId = Value(tagId);
  static Insertable<CardTagRow> custom({
    Expression<int>? cardId,
    Expression<int>? tagId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (cardId != null) 'card_id': cardId,
      if (tagId != null) 'tag_id': tagId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CardTagsCompanion copyWith(
      {Value<int>? cardId, Value<int>? tagId, Value<int>? rowid}) {
    return CardTagsCompanion(
      cardId: cardId ?? this.cardId,
      tagId: tagId ?? this.tagId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (cardId.present) {
      map['card_id'] = Variable<int>(cardId.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<int>(tagId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CardTagsCompanion(')
          ..write('cardId: $cardId, ')
          ..write('tagId: $tagId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSettingRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(Insertable<AppSettingRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppSettingRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSettingRow(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSettingRow extends DataClass implements Insertable<AppSettingRow> {
  final String key;
  final String value;
  const AppSettingRow({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      key: Value(key),
      value: Value(value),
    );
  }

  factory AppSettingRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSettingRow(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  AppSettingRow copyWith({String? key, String? value}) => AppSettingRow(
        key: key ?? this.key,
        value: value ?? this.value,
      );
  AppSettingRow copyWithCompanion(AppSettingsCompanion data) {
    return AppSettingRow(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingRow(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSettingRow &&
          other.key == this.key &&
          other.value == this.value);
}

class AppSettingsCompanion extends UpdateCompanion<AppSettingRow> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        value = Value(value);
  static Insertable<AppSettingRow> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith(
      {Value<String>? key, Value<String>? value, Value<int>? rowid}) {
    return AppSettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $GamesTable games = $GamesTable(this);
  late final $CardSetsTable cardSets = $CardSetsTable(this);
  late final $CardRowsTable cardRows = $CardRowsTable(this);
  late final $CardImagesTable cardImages = $CardImagesTable(this);
  late final $TagsTable tags = $TagsTable(this);
  late final $CardTagsTable cardTags = $CardTagsTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [games, cardSets, cardRows, cardImages, tags, cardTags, appSettings];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('card_rows',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('card_images', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('card_rows',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('card_tags', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('tags',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('card_tags', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$GamesTableCreateCompanionBuilder = GamesCompanion Function({
  Value<int> id,
  required String code,
  required String name,
  Value<String?> iconAsset,
  Value<int> sortOrder,
});
typedef $$GamesTableUpdateCompanionBuilder = GamesCompanion Function({
  Value<int> id,
  Value<String> code,
  Value<String> name,
  Value<String?> iconAsset,
  Value<int> sortOrder,
});

class $$GamesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GamesTable,
    GameRow,
    $$GamesTableFilterComposer,
    $$GamesTableOrderingComposer,
    $$GamesTableCreateCompanionBuilder,
    $$GamesTableUpdateCompanionBuilder> {
  $$GamesTableTableManager(_$AppDatabase db, $GamesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$GamesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$GamesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> code = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> iconAsset = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
          }) =>
              GamesCompanion(
            id: id,
            code: code,
            name: name,
            iconAsset: iconAsset,
            sortOrder: sortOrder,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String code,
            required String name,
            Value<String?> iconAsset = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
          }) =>
              GamesCompanion.insert(
            id: id,
            code: code,
            name: name,
            iconAsset: iconAsset,
            sortOrder: sortOrder,
          ),
        ));
}

class $$GamesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $GamesTable> {
  $$GamesTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get code => $state.composableBuilder(
      column: $state.table.code,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get iconAsset => $state.composableBuilder(
      column: $state.table.iconAsset,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get sortOrder => $state.composableBuilder(
      column: $state.table.sortOrder,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter cardSetsRefs(
      ComposableFilter Function($$CardSetsTableFilterComposer f) f) {
    final $$CardSetsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.cardSets,
        getReferencedColumn: (t) => t.gameId,
        builder: (joinBuilder, parentComposers) =>
            $$CardSetsTableFilterComposer(ComposerState(
                $state.db, $state.db.cardSets, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter cardRowsRefs(
      ComposableFilter Function($$CardRowsTableFilterComposer f) f) {
    final $$CardRowsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.cardRows,
        getReferencedColumn: (t) => t.gameId,
        builder: (joinBuilder, parentComposers) =>
            $$CardRowsTableFilterComposer(ComposerState(
                $state.db, $state.db.cardRows, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$GamesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $GamesTable> {
  $$GamesTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get code => $state.composableBuilder(
      column: $state.table.code,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get iconAsset => $state.composableBuilder(
      column: $state.table.iconAsset,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get sortOrder => $state.composableBuilder(
      column: $state.table.sortOrder,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$CardSetsTableCreateCompanionBuilder = CardSetsCompanion Function({
  Value<int> id,
  required int gameId,
  required String name,
  Value<String?> code,
  Value<int?> releaseYear,
  Value<int?> totalCards,
});
typedef $$CardSetsTableUpdateCompanionBuilder = CardSetsCompanion Function({
  Value<int> id,
  Value<int> gameId,
  Value<String> name,
  Value<String?> code,
  Value<int?> releaseYear,
  Value<int?> totalCards,
});

class $$CardSetsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CardSetsTable,
    SetRow,
    $$CardSetsTableFilterComposer,
    $$CardSetsTableOrderingComposer,
    $$CardSetsTableCreateCompanionBuilder,
    $$CardSetsTableUpdateCompanionBuilder> {
  $$CardSetsTableTableManager(_$AppDatabase db, $CardSetsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CardSetsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$CardSetsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> gameId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> code = const Value.absent(),
            Value<int?> releaseYear = const Value.absent(),
            Value<int?> totalCards = const Value.absent(),
          }) =>
              CardSetsCompanion(
            id: id,
            gameId: gameId,
            name: name,
            code: code,
            releaseYear: releaseYear,
            totalCards: totalCards,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int gameId,
            required String name,
            Value<String?> code = const Value.absent(),
            Value<int?> releaseYear = const Value.absent(),
            Value<int?> totalCards = const Value.absent(),
          }) =>
              CardSetsCompanion.insert(
            id: id,
            gameId: gameId,
            name: name,
            code: code,
            releaseYear: releaseYear,
            totalCards: totalCards,
          ),
        ));
}

class $$CardSetsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $CardSetsTable> {
  $$CardSetsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get code => $state.composableBuilder(
      column: $state.table.code,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get releaseYear => $state.composableBuilder(
      column: $state.table.releaseYear,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get totalCards => $state.composableBuilder(
      column: $state.table.totalCards,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$GamesTableFilterComposer get gameId {
    final $$GamesTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.gameId,
        referencedTable: $state.db.games,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$GamesTableFilterComposer(
            ComposerState(
                $state.db, $state.db.games, joinBuilder, parentComposers)));
    return composer;
  }

  ComposableFilter cardRowsRefs(
      ComposableFilter Function($$CardRowsTableFilterComposer f) f) {
    final $$CardRowsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.cardRows,
        getReferencedColumn: (t) => t.setId,
        builder: (joinBuilder, parentComposers) =>
            $$CardRowsTableFilterComposer(ComposerState(
                $state.db, $state.db.cardRows, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$CardSetsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $CardSetsTable> {
  $$CardSetsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get code => $state.composableBuilder(
      column: $state.table.code,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get releaseYear => $state.composableBuilder(
      column: $state.table.releaseYear,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get totalCards => $state.composableBuilder(
      column: $state.table.totalCards,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$GamesTableOrderingComposer get gameId {
    final $$GamesTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.gameId,
        referencedTable: $state.db.games,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$GamesTableOrderingComposer(
            ComposerState(
                $state.db, $state.db.games, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$CardRowsTableCreateCompanionBuilder = CardRowsCompanion Function({
  Value<int> id,
  required int gameId,
  Value<int?> setId,
  required String name,
  Value<String?> cardNumber,
  Value<String?> rarity,
  Value<String> condition,
  Value<int> quantity,
  Value<String> status,
  Value<bool> isFavorite,
  Value<double?> purchasePrice,
  Value<double?> currentValue,
  Value<String> currency,
  Value<int?> wishlistPriority,
  Value<double?> wishlistTargetPrice,
  Value<String?> language,
  Value<bool> isGraded,
  Value<String?> grade,
  Value<String?> notes,
  required int createdAt,
  required int updatedAt,
});
typedef $$CardRowsTableUpdateCompanionBuilder = CardRowsCompanion Function({
  Value<int> id,
  Value<int> gameId,
  Value<int?> setId,
  Value<String> name,
  Value<String?> cardNumber,
  Value<String?> rarity,
  Value<String> condition,
  Value<int> quantity,
  Value<String> status,
  Value<bool> isFavorite,
  Value<double?> purchasePrice,
  Value<double?> currentValue,
  Value<String> currency,
  Value<int?> wishlistPriority,
  Value<double?> wishlistTargetPrice,
  Value<String?> language,
  Value<bool> isGraded,
  Value<String?> grade,
  Value<String?> notes,
  Value<int> createdAt,
  Value<int> updatedAt,
});

class $$CardRowsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CardRowsTable,
    CardRow,
    $$CardRowsTableFilterComposer,
    $$CardRowsTableOrderingComposer,
    $$CardRowsTableCreateCompanionBuilder,
    $$CardRowsTableUpdateCompanionBuilder> {
  $$CardRowsTableTableManager(_$AppDatabase db, $CardRowsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CardRowsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$CardRowsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> gameId = const Value.absent(),
            Value<int?> setId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> cardNumber = const Value.absent(),
            Value<String?> rarity = const Value.absent(),
            Value<String> condition = const Value.absent(),
            Value<int> quantity = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
            Value<double?> purchasePrice = const Value.absent(),
            Value<double?> currentValue = const Value.absent(),
            Value<String> currency = const Value.absent(),
            Value<int?> wishlistPriority = const Value.absent(),
            Value<double?> wishlistTargetPrice = const Value.absent(),
            Value<String?> language = const Value.absent(),
            Value<bool> isGraded = const Value.absent(),
            Value<String?> grade = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int> updatedAt = const Value.absent(),
          }) =>
              CardRowsCompanion(
            id: id,
            gameId: gameId,
            setId: setId,
            name: name,
            cardNumber: cardNumber,
            rarity: rarity,
            condition: condition,
            quantity: quantity,
            status: status,
            isFavorite: isFavorite,
            purchasePrice: purchasePrice,
            currentValue: currentValue,
            currency: currency,
            wishlistPriority: wishlistPriority,
            wishlistTargetPrice: wishlistTargetPrice,
            language: language,
            isGraded: isGraded,
            grade: grade,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int gameId,
            Value<int?> setId = const Value.absent(),
            required String name,
            Value<String?> cardNumber = const Value.absent(),
            Value<String?> rarity = const Value.absent(),
            Value<String> condition = const Value.absent(),
            Value<int> quantity = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
            Value<double?> purchasePrice = const Value.absent(),
            Value<double?> currentValue = const Value.absent(),
            Value<String> currency = const Value.absent(),
            Value<int?> wishlistPriority = const Value.absent(),
            Value<double?> wishlistTargetPrice = const Value.absent(),
            Value<String?> language = const Value.absent(),
            Value<bool> isGraded = const Value.absent(),
            Value<String?> grade = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            required int createdAt,
            required int updatedAt,
          }) =>
              CardRowsCompanion.insert(
            id: id,
            gameId: gameId,
            setId: setId,
            name: name,
            cardNumber: cardNumber,
            rarity: rarity,
            condition: condition,
            quantity: quantity,
            status: status,
            isFavorite: isFavorite,
            purchasePrice: purchasePrice,
            currentValue: currentValue,
            currency: currency,
            wishlistPriority: wishlistPriority,
            wishlistTargetPrice: wishlistTargetPrice,
            language: language,
            isGraded: isGraded,
            grade: grade,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
        ));
}

class $$CardRowsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $CardRowsTable> {
  $$CardRowsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get cardNumber => $state.composableBuilder(
      column: $state.table.cardNumber,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get rarity => $state.composableBuilder(
      column: $state.table.rarity,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get condition => $state.composableBuilder(
      column: $state.table.condition,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get quantity => $state.composableBuilder(
      column: $state.table.quantity,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isFavorite => $state.composableBuilder(
      column: $state.table.isFavorite,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get purchasePrice => $state.composableBuilder(
      column: $state.table.purchasePrice,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get currentValue => $state.composableBuilder(
      column: $state.table.currentValue,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get currency => $state.composableBuilder(
      column: $state.table.currency,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get wishlistPriority => $state.composableBuilder(
      column: $state.table.wishlistPriority,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get wishlistTargetPrice => $state.composableBuilder(
      column: $state.table.wishlistTargetPrice,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get language => $state.composableBuilder(
      column: $state.table.language,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isGraded => $state.composableBuilder(
      column: $state.table.isGraded,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get grade => $state.composableBuilder(
      column: $state.table.grade,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$GamesTableFilterComposer get gameId {
    final $$GamesTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.gameId,
        referencedTable: $state.db.games,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$GamesTableFilterComposer(
            ComposerState(
                $state.db, $state.db.games, joinBuilder, parentComposers)));
    return composer;
  }

  $$CardSetsTableFilterComposer get setId {
    final $$CardSetsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.setId,
        referencedTable: $state.db.cardSets,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$CardSetsTableFilterComposer(ComposerState(
                $state.db, $state.db.cardSets, joinBuilder, parentComposers)));
    return composer;
  }

  ComposableFilter cardImagesRefs(
      ComposableFilter Function($$CardImagesTableFilterComposer f) f) {
    final $$CardImagesTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.cardImages,
        getReferencedColumn: (t) => t.cardId,
        builder: (joinBuilder, parentComposers) =>
            $$CardImagesTableFilterComposer(ComposerState($state.db,
                $state.db.cardImages, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter cardTagsRefs(
      ComposableFilter Function($$CardTagsTableFilterComposer f) f) {
    final $$CardTagsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.cardTags,
        getReferencedColumn: (t) => t.cardId,
        builder: (joinBuilder, parentComposers) =>
            $$CardTagsTableFilterComposer(ComposerState(
                $state.db, $state.db.cardTags, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$CardRowsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $CardRowsTable> {
  $$CardRowsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get cardNumber => $state.composableBuilder(
      column: $state.table.cardNumber,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get rarity => $state.composableBuilder(
      column: $state.table.rarity,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get condition => $state.composableBuilder(
      column: $state.table.condition,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get quantity => $state.composableBuilder(
      column: $state.table.quantity,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isFavorite => $state.composableBuilder(
      column: $state.table.isFavorite,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get purchasePrice => $state.composableBuilder(
      column: $state.table.purchasePrice,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get currentValue => $state.composableBuilder(
      column: $state.table.currentValue,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get currency => $state.composableBuilder(
      column: $state.table.currency,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get wishlistPriority => $state.composableBuilder(
      column: $state.table.wishlistPriority,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get wishlistTargetPrice => $state.composableBuilder(
      column: $state.table.wishlistTargetPrice,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get language => $state.composableBuilder(
      column: $state.table.language,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isGraded => $state.composableBuilder(
      column: $state.table.isGraded,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get grade => $state.composableBuilder(
      column: $state.table.grade,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$GamesTableOrderingComposer get gameId {
    final $$GamesTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.gameId,
        referencedTable: $state.db.games,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$GamesTableOrderingComposer(
            ComposerState(
                $state.db, $state.db.games, joinBuilder, parentComposers)));
    return composer;
  }

  $$CardSetsTableOrderingComposer get setId {
    final $$CardSetsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.setId,
        referencedTable: $state.db.cardSets,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$CardSetsTableOrderingComposer(ComposerState(
                $state.db, $state.db.cardSets, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$CardImagesTableCreateCompanionBuilder = CardImagesCompanion Function({
  Value<int> id,
  required int cardId,
  required String filePath,
  Value<String?> thumbPath,
  Value<bool> isPrimary,
  Value<String> side,
  required int createdAt,
});
typedef $$CardImagesTableUpdateCompanionBuilder = CardImagesCompanion Function({
  Value<int> id,
  Value<int> cardId,
  Value<String> filePath,
  Value<String?> thumbPath,
  Value<bool> isPrimary,
  Value<String> side,
  Value<int> createdAt,
});

class $$CardImagesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CardImagesTable,
    CardImageRow,
    $$CardImagesTableFilterComposer,
    $$CardImagesTableOrderingComposer,
    $$CardImagesTableCreateCompanionBuilder,
    $$CardImagesTableUpdateCompanionBuilder> {
  $$CardImagesTableTableManager(_$AppDatabase db, $CardImagesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CardImagesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$CardImagesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> cardId = const Value.absent(),
            Value<String> filePath = const Value.absent(),
            Value<String?> thumbPath = const Value.absent(),
            Value<bool> isPrimary = const Value.absent(),
            Value<String> side = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
          }) =>
              CardImagesCompanion(
            id: id,
            cardId: cardId,
            filePath: filePath,
            thumbPath: thumbPath,
            isPrimary: isPrimary,
            side: side,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int cardId,
            required String filePath,
            Value<String?> thumbPath = const Value.absent(),
            Value<bool> isPrimary = const Value.absent(),
            Value<String> side = const Value.absent(),
            required int createdAt,
          }) =>
              CardImagesCompanion.insert(
            id: id,
            cardId: cardId,
            filePath: filePath,
            thumbPath: thumbPath,
            isPrimary: isPrimary,
            side: side,
            createdAt: createdAt,
          ),
        ));
}

class $$CardImagesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $CardImagesTable> {
  $$CardImagesTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get filePath => $state.composableBuilder(
      column: $state.table.filePath,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get thumbPath => $state.composableBuilder(
      column: $state.table.thumbPath,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isPrimary => $state.composableBuilder(
      column: $state.table.isPrimary,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get side => $state.composableBuilder(
      column: $state.table.side,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$CardRowsTableFilterComposer get cardId {
    final $$CardRowsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cardId,
        referencedTable: $state.db.cardRows,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$CardRowsTableFilterComposer(ComposerState(
                $state.db, $state.db.cardRows, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$CardImagesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $CardImagesTable> {
  $$CardImagesTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get filePath => $state.composableBuilder(
      column: $state.table.filePath,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get thumbPath => $state.composableBuilder(
      column: $state.table.thumbPath,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isPrimary => $state.composableBuilder(
      column: $state.table.isPrimary,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get side => $state.composableBuilder(
      column: $state.table.side,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$CardRowsTableOrderingComposer get cardId {
    final $$CardRowsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cardId,
        referencedTable: $state.db.cardRows,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$CardRowsTableOrderingComposer(ComposerState(
                $state.db, $state.db.cardRows, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$TagsTableCreateCompanionBuilder = TagsCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> color,
  required int createdAt,
});
typedef $$TagsTableUpdateCompanionBuilder = TagsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> color,
  Value<int> createdAt,
});

class $$TagsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TagsTable,
    TagRow,
    $$TagsTableFilterComposer,
    $$TagsTableOrderingComposer,
    $$TagsTableCreateCompanionBuilder,
    $$TagsTableUpdateCompanionBuilder> {
  $$TagsTableTableManager(_$AppDatabase db, $TagsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TagsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TagsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> color = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
          }) =>
              TagsCompanion(
            id: id,
            name: name,
            color: color,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> color = const Value.absent(),
            required int createdAt,
          }) =>
              TagsCompanion.insert(
            id: id,
            name: name,
            color: color,
            createdAt: createdAt,
          ),
        ));
}

class $$TagsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $TagsTable> {
  $$TagsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get color => $state.composableBuilder(
      column: $state.table.color,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter cardTagsRefs(
      ComposableFilter Function($$CardTagsTableFilterComposer f) f) {
    final $$CardTagsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.cardTags,
        getReferencedColumn: (t) => t.tagId,
        builder: (joinBuilder, parentComposers) =>
            $$CardTagsTableFilterComposer(ComposerState(
                $state.db, $state.db.cardTags, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$TagsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $TagsTable> {
  $$TagsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get color => $state.composableBuilder(
      column: $state.table.color,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$CardTagsTableCreateCompanionBuilder = CardTagsCompanion Function({
  required int cardId,
  required int tagId,
  Value<int> rowid,
});
typedef $$CardTagsTableUpdateCompanionBuilder = CardTagsCompanion Function({
  Value<int> cardId,
  Value<int> tagId,
  Value<int> rowid,
});

class $$CardTagsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CardTagsTable,
    CardTagRow,
    $$CardTagsTableFilterComposer,
    $$CardTagsTableOrderingComposer,
    $$CardTagsTableCreateCompanionBuilder,
    $$CardTagsTableUpdateCompanionBuilder> {
  $$CardTagsTableTableManager(_$AppDatabase db, $CardTagsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CardTagsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$CardTagsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> cardId = const Value.absent(),
            Value<int> tagId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CardTagsCompanion(
            cardId: cardId,
            tagId: tagId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int cardId,
            required int tagId,
            Value<int> rowid = const Value.absent(),
          }) =>
              CardTagsCompanion.insert(
            cardId: cardId,
            tagId: tagId,
            rowid: rowid,
          ),
        ));
}

class $$CardTagsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $CardTagsTable> {
  $$CardTagsTableFilterComposer(super.$state);
  $$CardRowsTableFilterComposer get cardId {
    final $$CardRowsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cardId,
        referencedTable: $state.db.cardRows,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$CardRowsTableFilterComposer(ComposerState(
                $state.db, $state.db.cardRows, joinBuilder, parentComposers)));
    return composer;
  }

  $$TagsTableFilterComposer get tagId {
    final $$TagsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tagId,
        referencedTable: $state.db.tags,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$TagsTableFilterComposer(
            ComposerState(
                $state.db, $state.db.tags, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$CardTagsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $CardTagsTable> {
  $$CardTagsTableOrderingComposer(super.$state);
  $$CardRowsTableOrderingComposer get cardId {
    final $$CardRowsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cardId,
        referencedTable: $state.db.cardRows,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$CardRowsTableOrderingComposer(ComposerState(
                $state.db, $state.db.cardRows, joinBuilder, parentComposers)));
    return composer;
  }

  $$TagsTableOrderingComposer get tagId {
    final $$TagsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tagId,
        referencedTable: $state.db.tags,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$TagsTableOrderingComposer(
            ComposerState(
                $state.db, $state.db.tags, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$AppSettingsTableCreateCompanionBuilder = AppSettingsCompanion
    Function({
  required String key,
  required String value,
  Value<int> rowid,
});
typedef $$AppSettingsTableUpdateCompanionBuilder = AppSettingsCompanion
    Function({
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

class $$AppSettingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppSettingsTable,
    AppSettingRow,
    $$AppSettingsTableFilterComposer,
    $$AppSettingsTableOrderingComposer,
    $$AppSettingsTableCreateCompanionBuilder,
    $$AppSettingsTableUpdateCompanionBuilder> {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$AppSettingsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$AppSettingsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppSettingsCompanion(
            key: key,
            value: value,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            required String value,
            Value<int> rowid = const Value.absent(),
          }) =>
              AppSettingsCompanion.insert(
            key: key,
            value: value,
            rowid: rowid,
          ),
        ));
}

class $$AppSettingsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer(super.$state);
  ColumnFilters<String> get key => $state.composableBuilder(
      column: $state.table.key,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get value => $state.composableBuilder(
      column: $state.table.value,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$AppSettingsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get key => $state.composableBuilder(
      column: $state.table.key,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get value => $state.composableBuilder(
      column: $state.table.value,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$GamesTableTableManager get games =>
      $$GamesTableTableManager(_db, _db.games);
  $$CardSetsTableTableManager get cardSets =>
      $$CardSetsTableTableManager(_db, _db.cardSets);
  $$CardRowsTableTableManager get cardRows =>
      $$CardRowsTableTableManager(_db, _db.cardRows);
  $$CardImagesTableTableManager get cardImages =>
      $$CardImagesTableTableManager(_db, _db.cardImages);
  $$TagsTableTableManager get tags => $$TagsTableTableManager(_db, _db.tags);
  $$CardTagsTableTableManager get cardTags =>
      $$CardTagsTableTableManager(_db, _db.cardTags);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
}
