// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gamification_database.dart';

// ignore_for_file: type=lint
mixin _$LeaderboardDaoMixin on DatabaseAccessor<GamificationDatabase> {
  $LeaderboardEntriesTable get leaderboardEntries =>
      attachedDatabase.leaderboardEntries;
  $LeaderboardPageMetaTable get leaderboardPageMeta =>
      attachedDatabase.leaderboardPageMeta;
  LeaderboardDaoManager get managers => LeaderboardDaoManager(this);
}

class LeaderboardDaoManager {
  final _$LeaderboardDaoMixin _db;
  LeaderboardDaoManager(this._db);
  $$LeaderboardEntriesTableTableManager get leaderboardEntries =>
      $$LeaderboardEntriesTableTableManager(
        _db.attachedDatabase,
        _db.leaderboardEntries,
      );
  $$LeaderboardPageMetaTableTableManager get leaderboardPageMeta =>
      $$LeaderboardPageMetaTableTableManager(
        _db.attachedDatabase,
        _db.leaderboardPageMeta,
      );
}

class $LeaderboardEntriesTable extends LeaderboardEntries
    with TableInfo<$LeaderboardEntriesTable, LeaderboardEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LeaderboardEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _scopeMeta = const VerificationMeta('scope');
  @override
  late final GeneratedColumn<String> scope = GeneratedColumn<String>(
    'scope',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pageIndexMeta = const VerificationMeta(
    'pageIndex',
  );
  @override
  late final GeneratedColumn<int> pageIndex = GeneratedColumn<int>(
    'page_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userNameMeta = const VerificationMeta(
    'userName',
  );
  @override
  late final GeneratedColumn<String> userName = GeneratedColumn<String>(
    'user_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avatarUrlMeta = const VerificationMeta(
    'avatarUrl',
  );
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
    'avatar_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rankMeta = const VerificationMeta('rank');
  @override
  late final GeneratedColumn<int> rank = GeneratedColumn<int>(
    'rank',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _xpMeta = const VerificationMeta('xp');
  @override
  late final GeneratedColumn<int> xp = GeneratedColumn<int>(
    'xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rankChangeMeta = const VerificationMeta(
    'rankChange',
  );
  @override
  late final GeneratedColumn<String> rankChange = GeneratedColumn<String>(
    'rank_change',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    scope,
    pageIndex,
    userId,
    userName,
    avatarUrl,
    rank,
    xp,
    rankChange,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'leaderboard_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<LeaderboardEntryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('scope')) {
      context.handle(
        _scopeMeta,
        scope.isAcceptableOrUnknown(data['scope']!, _scopeMeta),
      );
    } else if (isInserting) {
      context.missing(_scopeMeta);
    }
    if (data.containsKey('page_index')) {
      context.handle(
        _pageIndexMeta,
        pageIndex.isAcceptableOrUnknown(data['page_index']!, _pageIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_pageIndexMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('user_name')) {
      context.handle(
        _userNameMeta,
        userName.isAcceptableOrUnknown(data['user_name']!, _userNameMeta),
      );
    } else if (isInserting) {
      context.missing(_userNameMeta);
    }
    if (data.containsKey('avatar_url')) {
      context.handle(
        _avatarUrlMeta,
        avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_avatarUrlMeta);
    }
    if (data.containsKey('rank')) {
      context.handle(
        _rankMeta,
        rank.isAcceptableOrUnknown(data['rank']!, _rankMeta),
      );
    } else if (isInserting) {
      context.missing(_rankMeta);
    }
    if (data.containsKey('xp')) {
      context.handle(_xpMeta, xp.isAcceptableOrUnknown(data['xp']!, _xpMeta));
    } else if (isInserting) {
      context.missing(_xpMeta);
    }
    if (data.containsKey('rank_change')) {
      context.handle(
        _rankChangeMeta,
        rankChange.isAcceptableOrUnknown(data['rank_change']!, _rankChangeMeta),
      );
    } else if (isInserting) {
      context.missing(_rankChangeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {scope, pageIndex, userId};
  @override
  LeaderboardEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LeaderboardEntryRow(
      scope: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scope'],
      )!,
      pageIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}page_index'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      userName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_name'],
      )!,
      avatarUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_url'],
      )!,
      rank: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rank'],
      )!,
      xp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}xp'],
      )!,
      rankChange: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rank_change'],
      )!,
    );
  }

  @override
  $LeaderboardEntriesTable createAlias(String alias) {
    return $LeaderboardEntriesTable(attachedDatabase, alias);
  }
}

class LeaderboardEntryRow extends DataClass
    implements Insertable<LeaderboardEntryRow> {
  final String scope;
  final int pageIndex;
  final String userId;
  final String userName;
  final String avatarUrl;
  final int rank;
  final int xp;
  final String rankChange;
  const LeaderboardEntryRow({
    required this.scope,
    required this.pageIndex,
    required this.userId,
    required this.userName,
    required this.avatarUrl,
    required this.rank,
    required this.xp,
    required this.rankChange,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['scope'] = Variable<String>(scope);
    map['page_index'] = Variable<int>(pageIndex);
    map['user_id'] = Variable<String>(userId);
    map['user_name'] = Variable<String>(userName);
    map['avatar_url'] = Variable<String>(avatarUrl);
    map['rank'] = Variable<int>(rank);
    map['xp'] = Variable<int>(xp);
    map['rank_change'] = Variable<String>(rankChange);
    return map;
  }

  LeaderboardEntriesCompanion toCompanion(bool nullToAbsent) {
    return LeaderboardEntriesCompanion(
      scope: Value(scope),
      pageIndex: Value(pageIndex),
      userId: Value(userId),
      userName: Value(userName),
      avatarUrl: Value(avatarUrl),
      rank: Value(rank),
      xp: Value(xp),
      rankChange: Value(rankChange),
    );
  }

  factory LeaderboardEntryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LeaderboardEntryRow(
      scope: serializer.fromJson<String>(json['scope']),
      pageIndex: serializer.fromJson<int>(json['pageIndex']),
      userId: serializer.fromJson<String>(json['userId']),
      userName: serializer.fromJson<String>(json['userName']),
      avatarUrl: serializer.fromJson<String>(json['avatarUrl']),
      rank: serializer.fromJson<int>(json['rank']),
      xp: serializer.fromJson<int>(json['xp']),
      rankChange: serializer.fromJson<String>(json['rankChange']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'scope': serializer.toJson<String>(scope),
      'pageIndex': serializer.toJson<int>(pageIndex),
      'userId': serializer.toJson<String>(userId),
      'userName': serializer.toJson<String>(userName),
      'avatarUrl': serializer.toJson<String>(avatarUrl),
      'rank': serializer.toJson<int>(rank),
      'xp': serializer.toJson<int>(xp),
      'rankChange': serializer.toJson<String>(rankChange),
    };
  }

  LeaderboardEntryRow copyWith({
    String? scope,
    int? pageIndex,
    String? userId,
    String? userName,
    String? avatarUrl,
    int? rank,
    int? xp,
    String? rankChange,
  }) => LeaderboardEntryRow(
    scope: scope ?? this.scope,
    pageIndex: pageIndex ?? this.pageIndex,
    userId: userId ?? this.userId,
    userName: userName ?? this.userName,
    avatarUrl: avatarUrl ?? this.avatarUrl,
    rank: rank ?? this.rank,
    xp: xp ?? this.xp,
    rankChange: rankChange ?? this.rankChange,
  );
  LeaderboardEntryRow copyWithCompanion(LeaderboardEntriesCompanion data) {
    return LeaderboardEntryRow(
      scope: data.scope.present ? data.scope.value : this.scope,
      pageIndex: data.pageIndex.present ? data.pageIndex.value : this.pageIndex,
      userId: data.userId.present ? data.userId.value : this.userId,
      userName: data.userName.present ? data.userName.value : this.userName,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
      rank: data.rank.present ? data.rank.value : this.rank,
      xp: data.xp.present ? data.xp.value : this.xp,
      rankChange: data.rankChange.present
          ? data.rankChange.value
          : this.rankChange,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LeaderboardEntryRow(')
          ..write('scope: $scope, ')
          ..write('pageIndex: $pageIndex, ')
          ..write('userId: $userId, ')
          ..write('userName: $userName, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('rank: $rank, ')
          ..write('xp: $xp, ')
          ..write('rankChange: $rankChange')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    scope,
    pageIndex,
    userId,
    userName,
    avatarUrl,
    rank,
    xp,
    rankChange,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LeaderboardEntryRow &&
          other.scope == this.scope &&
          other.pageIndex == this.pageIndex &&
          other.userId == this.userId &&
          other.userName == this.userName &&
          other.avatarUrl == this.avatarUrl &&
          other.rank == this.rank &&
          other.xp == this.xp &&
          other.rankChange == this.rankChange);
}

class LeaderboardEntriesCompanion extends UpdateCompanion<LeaderboardEntryRow> {
  final Value<String> scope;
  final Value<int> pageIndex;
  final Value<String> userId;
  final Value<String> userName;
  final Value<String> avatarUrl;
  final Value<int> rank;
  final Value<int> xp;
  final Value<String> rankChange;
  final Value<int> rowid;
  const LeaderboardEntriesCompanion({
    this.scope = const Value.absent(),
    this.pageIndex = const Value.absent(),
    this.userId = const Value.absent(),
    this.userName = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.rank = const Value.absent(),
    this.xp = const Value.absent(),
    this.rankChange = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LeaderboardEntriesCompanion.insert({
    required String scope,
    required int pageIndex,
    required String userId,
    required String userName,
    required String avatarUrl,
    required int rank,
    required int xp,
    required String rankChange,
    this.rowid = const Value.absent(),
  }) : scope = Value(scope),
       pageIndex = Value(pageIndex),
       userId = Value(userId),
       userName = Value(userName),
       avatarUrl = Value(avatarUrl),
       rank = Value(rank),
       xp = Value(xp),
       rankChange = Value(rankChange);
  static Insertable<LeaderboardEntryRow> custom({
    Expression<String>? scope,
    Expression<int>? pageIndex,
    Expression<String>? userId,
    Expression<String>? userName,
    Expression<String>? avatarUrl,
    Expression<int>? rank,
    Expression<int>? xp,
    Expression<String>? rankChange,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (scope != null) 'scope': scope,
      if (pageIndex != null) 'page_index': pageIndex,
      if (userId != null) 'user_id': userId,
      if (userName != null) 'user_name': userName,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (rank != null) 'rank': rank,
      if (xp != null) 'xp': xp,
      if (rankChange != null) 'rank_change': rankChange,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LeaderboardEntriesCompanion copyWith({
    Value<String>? scope,
    Value<int>? pageIndex,
    Value<String>? userId,
    Value<String>? userName,
    Value<String>? avatarUrl,
    Value<int>? rank,
    Value<int>? xp,
    Value<String>? rankChange,
    Value<int>? rowid,
  }) {
    return LeaderboardEntriesCompanion(
      scope: scope ?? this.scope,
      pageIndex: pageIndex ?? this.pageIndex,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      rank: rank ?? this.rank,
      xp: xp ?? this.xp,
      rankChange: rankChange ?? this.rankChange,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (scope.present) {
      map['scope'] = Variable<String>(scope.value);
    }
    if (pageIndex.present) {
      map['page_index'] = Variable<int>(pageIndex.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (userName.present) {
      map['user_name'] = Variable<String>(userName.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (rank.present) {
      map['rank'] = Variable<int>(rank.value);
    }
    if (xp.present) {
      map['xp'] = Variable<int>(xp.value);
    }
    if (rankChange.present) {
      map['rank_change'] = Variable<String>(rankChange.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LeaderboardEntriesCompanion(')
          ..write('scope: $scope, ')
          ..write('pageIndex: $pageIndex, ')
          ..write('userId: $userId, ')
          ..write('userName: $userName, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('rank: $rank, ')
          ..write('xp: $xp, ')
          ..write('rankChange: $rankChange, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LeaderboardPageMetaTable extends LeaderboardPageMeta
    with TableInfo<$LeaderboardPageMetaTable, LeaderboardPageMetaRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LeaderboardPageMetaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _scopeMeta = const VerificationMeta('scope');
  @override
  late final GeneratedColumn<String> scope = GeneratedColumn<String>(
    'scope',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pageIndexMeta = const VerificationMeta(
    'pageIndex',
  );
  @override
  late final GeneratedColumn<int> pageIndex = GeneratedColumn<int>(
    'page_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hasNextPageMeta = const VerificationMeta(
    'hasNextPage',
  );
  @override
  late final GeneratedColumn<bool> hasNextPage = GeneratedColumn<bool>(
    'has_next_page',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_next_page" IN (0, 1))',
    ),
  );
  static const VerificationMeta _updatedAtMillisMeta = const VerificationMeta(
    'updatedAtMillis',
  );
  @override
  late final GeneratedColumn<int> updatedAtMillis = GeneratedColumn<int>(
    'updated_at_millis',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    scope,
    pageIndex,
    hasNextPage,
    updatedAtMillis,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'leaderboard_page_meta';
  @override
  VerificationContext validateIntegrity(
    Insertable<LeaderboardPageMetaRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('scope')) {
      context.handle(
        _scopeMeta,
        scope.isAcceptableOrUnknown(data['scope']!, _scopeMeta),
      );
    } else if (isInserting) {
      context.missing(_scopeMeta);
    }
    if (data.containsKey('page_index')) {
      context.handle(
        _pageIndexMeta,
        pageIndex.isAcceptableOrUnknown(data['page_index']!, _pageIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_pageIndexMeta);
    }
    if (data.containsKey('has_next_page')) {
      context.handle(
        _hasNextPageMeta,
        hasNextPage.isAcceptableOrUnknown(
          data['has_next_page']!,
          _hasNextPageMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_hasNextPageMeta);
    }
    if (data.containsKey('updated_at_millis')) {
      context.handle(
        _updatedAtMillisMeta,
        updatedAtMillis.isAcceptableOrUnknown(
          data['updated_at_millis']!,
          _updatedAtMillisMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMillisMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {scope, pageIndex};
  @override
  LeaderboardPageMetaRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LeaderboardPageMetaRow(
      scope: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scope'],
      )!,
      pageIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}page_index'],
      )!,
      hasNextPage: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_next_page'],
      )!,
      updatedAtMillis: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_millis'],
      )!,
    );
  }

  @override
  $LeaderboardPageMetaTable createAlias(String alias) {
    return $LeaderboardPageMetaTable(attachedDatabase, alias);
  }
}

class LeaderboardPageMetaRow extends DataClass
    implements Insertable<LeaderboardPageMetaRow> {
  final String scope;
  final int pageIndex;
  final bool hasNextPage;
  final int updatedAtMillis;
  const LeaderboardPageMetaRow({
    required this.scope,
    required this.pageIndex,
    required this.hasNextPage,
    required this.updatedAtMillis,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['scope'] = Variable<String>(scope);
    map['page_index'] = Variable<int>(pageIndex);
    map['has_next_page'] = Variable<bool>(hasNextPage);
    map['updated_at_millis'] = Variable<int>(updatedAtMillis);
    return map;
  }

  LeaderboardPageMetaCompanion toCompanion(bool nullToAbsent) {
    return LeaderboardPageMetaCompanion(
      scope: Value(scope),
      pageIndex: Value(pageIndex),
      hasNextPage: Value(hasNextPage),
      updatedAtMillis: Value(updatedAtMillis),
    );
  }

  factory LeaderboardPageMetaRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LeaderboardPageMetaRow(
      scope: serializer.fromJson<String>(json['scope']),
      pageIndex: serializer.fromJson<int>(json['pageIndex']),
      hasNextPage: serializer.fromJson<bool>(json['hasNextPage']),
      updatedAtMillis: serializer.fromJson<int>(json['updatedAtMillis']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'scope': serializer.toJson<String>(scope),
      'pageIndex': serializer.toJson<int>(pageIndex),
      'hasNextPage': serializer.toJson<bool>(hasNextPage),
      'updatedAtMillis': serializer.toJson<int>(updatedAtMillis),
    };
  }

  LeaderboardPageMetaRow copyWith({
    String? scope,
    int? pageIndex,
    bool? hasNextPage,
    int? updatedAtMillis,
  }) => LeaderboardPageMetaRow(
    scope: scope ?? this.scope,
    pageIndex: pageIndex ?? this.pageIndex,
    hasNextPage: hasNextPage ?? this.hasNextPage,
    updatedAtMillis: updatedAtMillis ?? this.updatedAtMillis,
  );
  LeaderboardPageMetaRow copyWithCompanion(LeaderboardPageMetaCompanion data) {
    return LeaderboardPageMetaRow(
      scope: data.scope.present ? data.scope.value : this.scope,
      pageIndex: data.pageIndex.present ? data.pageIndex.value : this.pageIndex,
      hasNextPage: data.hasNextPage.present
          ? data.hasNextPage.value
          : this.hasNextPage,
      updatedAtMillis: data.updatedAtMillis.present
          ? data.updatedAtMillis.value
          : this.updatedAtMillis,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LeaderboardPageMetaRow(')
          ..write('scope: $scope, ')
          ..write('pageIndex: $pageIndex, ')
          ..write('hasNextPage: $hasNextPage, ')
          ..write('updatedAtMillis: $updatedAtMillis')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(scope, pageIndex, hasNextPage, updatedAtMillis);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LeaderboardPageMetaRow &&
          other.scope == this.scope &&
          other.pageIndex == this.pageIndex &&
          other.hasNextPage == this.hasNextPage &&
          other.updatedAtMillis == this.updatedAtMillis);
}

class LeaderboardPageMetaCompanion
    extends UpdateCompanion<LeaderboardPageMetaRow> {
  final Value<String> scope;
  final Value<int> pageIndex;
  final Value<bool> hasNextPage;
  final Value<int> updatedAtMillis;
  final Value<int> rowid;
  const LeaderboardPageMetaCompanion({
    this.scope = const Value.absent(),
    this.pageIndex = const Value.absent(),
    this.hasNextPage = const Value.absent(),
    this.updatedAtMillis = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LeaderboardPageMetaCompanion.insert({
    required String scope,
    required int pageIndex,
    required bool hasNextPage,
    required int updatedAtMillis,
    this.rowid = const Value.absent(),
  }) : scope = Value(scope),
       pageIndex = Value(pageIndex),
       hasNextPage = Value(hasNextPage),
       updatedAtMillis = Value(updatedAtMillis);
  static Insertable<LeaderboardPageMetaRow> custom({
    Expression<String>? scope,
    Expression<int>? pageIndex,
    Expression<bool>? hasNextPage,
    Expression<int>? updatedAtMillis,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (scope != null) 'scope': scope,
      if (pageIndex != null) 'page_index': pageIndex,
      if (hasNextPage != null) 'has_next_page': hasNextPage,
      if (updatedAtMillis != null) 'updated_at_millis': updatedAtMillis,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LeaderboardPageMetaCompanion copyWith({
    Value<String>? scope,
    Value<int>? pageIndex,
    Value<bool>? hasNextPage,
    Value<int>? updatedAtMillis,
    Value<int>? rowid,
  }) {
    return LeaderboardPageMetaCompanion(
      scope: scope ?? this.scope,
      pageIndex: pageIndex ?? this.pageIndex,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      updatedAtMillis: updatedAtMillis ?? this.updatedAtMillis,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (scope.present) {
      map['scope'] = Variable<String>(scope.value);
    }
    if (pageIndex.present) {
      map['page_index'] = Variable<int>(pageIndex.value);
    }
    if (hasNextPage.present) {
      map['has_next_page'] = Variable<bool>(hasNextPage.value);
    }
    if (updatedAtMillis.present) {
      map['updated_at_millis'] = Variable<int>(updatedAtMillis.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LeaderboardPageMetaCompanion(')
          ..write('scope: $scope, ')
          ..write('pageIndex: $pageIndex, ')
          ..write('hasNextPage: $hasNextPage, ')
          ..write('updatedAtMillis: $updatedAtMillis, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$GamificationDatabase extends GeneratedDatabase {
  _$GamificationDatabase(QueryExecutor e) : super(e);
  $GamificationDatabaseManager get managers =>
      $GamificationDatabaseManager(this);
  late final $LeaderboardEntriesTable leaderboardEntries =
      $LeaderboardEntriesTable(this);
  late final $LeaderboardPageMetaTable leaderboardPageMeta =
      $LeaderboardPageMetaTable(this);
  late final LeaderboardDao leaderboardDao = LeaderboardDao(
    this as GamificationDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    leaderboardEntries,
    leaderboardPageMeta,
  ];
}

typedef $$LeaderboardEntriesTableCreateCompanionBuilder =
    LeaderboardEntriesCompanion Function({
      required String scope,
      required int pageIndex,
      required String userId,
      required String userName,
      required String avatarUrl,
      required int rank,
      required int xp,
      required String rankChange,
      Value<int> rowid,
    });
typedef $$LeaderboardEntriesTableUpdateCompanionBuilder =
    LeaderboardEntriesCompanion Function({
      Value<String> scope,
      Value<int> pageIndex,
      Value<String> userId,
      Value<String> userName,
      Value<String> avatarUrl,
      Value<int> rank,
      Value<int> xp,
      Value<String> rankChange,
      Value<int> rowid,
    });

class $$LeaderboardEntriesTableFilterComposer
    extends Composer<_$GamificationDatabase, $LeaderboardEntriesTable> {
  $$LeaderboardEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pageIndex => $composableBuilder(
    column: $table.pageIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userName => $composableBuilder(
    column: $table.userName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rank => $composableBuilder(
    column: $table.rank,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xp => $composableBuilder(
    column: $table.xp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rankChange => $composableBuilder(
    column: $table.rankChange,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LeaderboardEntriesTableOrderingComposer
    extends Composer<_$GamificationDatabase, $LeaderboardEntriesTable> {
  $$LeaderboardEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pageIndex => $composableBuilder(
    column: $table.pageIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userName => $composableBuilder(
    column: $table.userName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rank => $composableBuilder(
    column: $table.rank,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xp => $composableBuilder(
    column: $table.xp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rankChange => $composableBuilder(
    column: $table.rankChange,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LeaderboardEntriesTableAnnotationComposer
    extends Composer<_$GamificationDatabase, $LeaderboardEntriesTable> {
  $$LeaderboardEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get scope =>
      $composableBuilder(column: $table.scope, builder: (column) => column);

  GeneratedColumn<int> get pageIndex =>
      $composableBuilder(column: $table.pageIndex, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get userName =>
      $composableBuilder(column: $table.userName, builder: (column) => column);

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);

  GeneratedColumn<int> get rank =>
      $composableBuilder(column: $table.rank, builder: (column) => column);

  GeneratedColumn<int> get xp =>
      $composableBuilder(column: $table.xp, builder: (column) => column);

  GeneratedColumn<String> get rankChange => $composableBuilder(
    column: $table.rankChange,
    builder: (column) => column,
  );
}

class $$LeaderboardEntriesTableTableManager
    extends
        RootTableManager<
          _$GamificationDatabase,
          $LeaderboardEntriesTable,
          LeaderboardEntryRow,
          $$LeaderboardEntriesTableFilterComposer,
          $$LeaderboardEntriesTableOrderingComposer,
          $$LeaderboardEntriesTableAnnotationComposer,
          $$LeaderboardEntriesTableCreateCompanionBuilder,
          $$LeaderboardEntriesTableUpdateCompanionBuilder,
          (
            LeaderboardEntryRow,
            BaseReferences<
              _$GamificationDatabase,
              $LeaderboardEntriesTable,
              LeaderboardEntryRow
            >,
          ),
          LeaderboardEntryRow,
          PrefetchHooks Function()
        > {
  $$LeaderboardEntriesTableTableManager(
    _$GamificationDatabase db,
    $LeaderboardEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LeaderboardEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LeaderboardEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LeaderboardEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> scope = const Value.absent(),
                Value<int> pageIndex = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> userName = const Value.absent(),
                Value<String> avatarUrl = const Value.absent(),
                Value<int> rank = const Value.absent(),
                Value<int> xp = const Value.absent(),
                Value<String> rankChange = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LeaderboardEntriesCompanion(
                scope: scope,
                pageIndex: pageIndex,
                userId: userId,
                userName: userName,
                avatarUrl: avatarUrl,
                rank: rank,
                xp: xp,
                rankChange: rankChange,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String scope,
                required int pageIndex,
                required String userId,
                required String userName,
                required String avatarUrl,
                required int rank,
                required int xp,
                required String rankChange,
                Value<int> rowid = const Value.absent(),
              }) => LeaderboardEntriesCompanion.insert(
                scope: scope,
                pageIndex: pageIndex,
                userId: userId,
                userName: userName,
                avatarUrl: avatarUrl,
                rank: rank,
                xp: xp,
                rankChange: rankChange,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LeaderboardEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$GamificationDatabase,
      $LeaderboardEntriesTable,
      LeaderboardEntryRow,
      $$LeaderboardEntriesTableFilterComposer,
      $$LeaderboardEntriesTableOrderingComposer,
      $$LeaderboardEntriesTableAnnotationComposer,
      $$LeaderboardEntriesTableCreateCompanionBuilder,
      $$LeaderboardEntriesTableUpdateCompanionBuilder,
      (
        LeaderboardEntryRow,
        BaseReferences<
          _$GamificationDatabase,
          $LeaderboardEntriesTable,
          LeaderboardEntryRow
        >,
      ),
      LeaderboardEntryRow,
      PrefetchHooks Function()
    >;
typedef $$LeaderboardPageMetaTableCreateCompanionBuilder =
    LeaderboardPageMetaCompanion Function({
      required String scope,
      required int pageIndex,
      required bool hasNextPage,
      required int updatedAtMillis,
      Value<int> rowid,
    });
typedef $$LeaderboardPageMetaTableUpdateCompanionBuilder =
    LeaderboardPageMetaCompanion Function({
      Value<String> scope,
      Value<int> pageIndex,
      Value<bool> hasNextPage,
      Value<int> updatedAtMillis,
      Value<int> rowid,
    });

class $$LeaderboardPageMetaTableFilterComposer
    extends Composer<_$GamificationDatabase, $LeaderboardPageMetaTable> {
  $$LeaderboardPageMetaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pageIndex => $composableBuilder(
    column: $table.pageIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasNextPage => $composableBuilder(
    column: $table.hasNextPage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAtMillis => $composableBuilder(
    column: $table.updatedAtMillis,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LeaderboardPageMetaTableOrderingComposer
    extends Composer<_$GamificationDatabase, $LeaderboardPageMetaTable> {
  $$LeaderboardPageMetaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pageIndex => $composableBuilder(
    column: $table.pageIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasNextPage => $composableBuilder(
    column: $table.hasNextPage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAtMillis => $composableBuilder(
    column: $table.updatedAtMillis,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LeaderboardPageMetaTableAnnotationComposer
    extends Composer<_$GamificationDatabase, $LeaderboardPageMetaTable> {
  $$LeaderboardPageMetaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get scope =>
      $composableBuilder(column: $table.scope, builder: (column) => column);

  GeneratedColumn<int> get pageIndex =>
      $composableBuilder(column: $table.pageIndex, builder: (column) => column);

  GeneratedColumn<bool> get hasNextPage => $composableBuilder(
    column: $table.hasNextPage,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updatedAtMillis => $composableBuilder(
    column: $table.updatedAtMillis,
    builder: (column) => column,
  );
}

class $$LeaderboardPageMetaTableTableManager
    extends
        RootTableManager<
          _$GamificationDatabase,
          $LeaderboardPageMetaTable,
          LeaderboardPageMetaRow,
          $$LeaderboardPageMetaTableFilterComposer,
          $$LeaderboardPageMetaTableOrderingComposer,
          $$LeaderboardPageMetaTableAnnotationComposer,
          $$LeaderboardPageMetaTableCreateCompanionBuilder,
          $$LeaderboardPageMetaTableUpdateCompanionBuilder,
          (
            LeaderboardPageMetaRow,
            BaseReferences<
              _$GamificationDatabase,
              $LeaderboardPageMetaTable,
              LeaderboardPageMetaRow
            >,
          ),
          LeaderboardPageMetaRow,
          PrefetchHooks Function()
        > {
  $$LeaderboardPageMetaTableTableManager(
    _$GamificationDatabase db,
    $LeaderboardPageMetaTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LeaderboardPageMetaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LeaderboardPageMetaTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LeaderboardPageMetaTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> scope = const Value.absent(),
                Value<int> pageIndex = const Value.absent(),
                Value<bool> hasNextPage = const Value.absent(),
                Value<int> updatedAtMillis = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LeaderboardPageMetaCompanion(
                scope: scope,
                pageIndex: pageIndex,
                hasNextPage: hasNextPage,
                updatedAtMillis: updatedAtMillis,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String scope,
                required int pageIndex,
                required bool hasNextPage,
                required int updatedAtMillis,
                Value<int> rowid = const Value.absent(),
              }) => LeaderboardPageMetaCompanion.insert(
                scope: scope,
                pageIndex: pageIndex,
                hasNextPage: hasNextPage,
                updatedAtMillis: updatedAtMillis,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LeaderboardPageMetaTableProcessedTableManager =
    ProcessedTableManager<
      _$GamificationDatabase,
      $LeaderboardPageMetaTable,
      LeaderboardPageMetaRow,
      $$LeaderboardPageMetaTableFilterComposer,
      $$LeaderboardPageMetaTableOrderingComposer,
      $$LeaderboardPageMetaTableAnnotationComposer,
      $$LeaderboardPageMetaTableCreateCompanionBuilder,
      $$LeaderboardPageMetaTableUpdateCompanionBuilder,
      (
        LeaderboardPageMetaRow,
        BaseReferences<
          _$GamificationDatabase,
          $LeaderboardPageMetaTable,
          LeaderboardPageMetaRow
        >,
      ),
      LeaderboardPageMetaRow,
      PrefetchHooks Function()
    >;

class $GamificationDatabaseManager {
  final _$GamificationDatabase _db;
  $GamificationDatabaseManager(this._db);
  $$LeaderboardEntriesTableTableManager get leaderboardEntries =>
      $$LeaderboardEntriesTableTableManager(_db, _db.leaderboardEntries);
  $$LeaderboardPageMetaTableTableManager get leaderboardPageMeta =>
      $$LeaderboardPageMetaTableTableManager(_db, _db.leaderboardPageMeta);
}
