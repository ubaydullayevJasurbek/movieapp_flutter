// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFavouriteEntityCollection on Isar {
  IsarCollection<FavouriteEntity> get favouriteEntitys => this.collection();
}

const FavouriteEntitySchema = CollectionSchema(
  name: r'FavouriteEntity',
  id: -3225873005877532634,
  properties: {
    r'addedAt': PropertySchema(
      id: 0,
      name: r'addedAt',
      type: IsarType.dateTime,
    ),
    r'genres': PropertySchema(
      id: 1,
      name: r'genres',
      type: IsarType.stringList,
    ),
    r'mediaType': PropertySchema(
      id: 2,
      name: r'mediaType',
      type: IsarType.string,
    ),
    r'movieId': PropertySchema(id: 3, name: r'movieId', type: IsarType.long),
    r'posterPath': PropertySchema(
      id: 4,
      name: r'posterPath',
      type: IsarType.string,
    ),
    r'releaseDate': PropertySchema(
      id: 5,
      name: r'releaseDate',
      type: IsarType.dateTime,
    ),
    r'title': PropertySchema(id: 6, name: r'title', type: IsarType.string),
    r'voteAverage': PropertySchema(
      id: 7,
      name: r'voteAverage',
      type: IsarType.double,
    ),
  },

  estimateSize: _favouriteEntityEstimateSize,
  serialize: _favouriteEntitySerialize,
  deserialize: _favouriteEntityDeserialize,
  deserializeProp: _favouriteEntityDeserializeProp,
  idName: r'id',
  indexes: {
    r'movieId': IndexSchema(
      id: -1138826636860436442,
      name: r'movieId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'movieId',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _favouriteEntityGetId,
  getLinks: _favouriteEntityGetLinks,
  attach: _favouriteEntityAttach,
  version: '3.3.2',
);

int _favouriteEntityEstimateSize(
  FavouriteEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.genres.length * 3;
  {
    for (var i = 0; i < object.genres.length; i++) {
      final value = object.genres[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.mediaType.length * 3;
  {
    final value = object.posterPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _favouriteEntitySerialize(
  FavouriteEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.addedAt);
  writer.writeStringList(offsets[1], object.genres);
  writer.writeString(offsets[2], object.mediaType);
  writer.writeLong(offsets[3], object.movieId);
  writer.writeString(offsets[4], object.posterPath);
  writer.writeDateTime(offsets[5], object.releaseDate);
  writer.writeString(offsets[6], object.title);
  writer.writeDouble(offsets[7], object.voteAverage);
}

FavouriteEntity _favouriteEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FavouriteEntity();
  object.addedAt = reader.readDateTime(offsets[0]);
  object.genres = reader.readStringList(offsets[1]) ?? [];
  object.id = id;
  object.mediaType = reader.readString(offsets[2]);
  object.movieId = reader.readLong(offsets[3]);
  object.posterPath = reader.readStringOrNull(offsets[4]);
  object.releaseDate = reader.readDateTimeOrNull(offsets[5]);
  object.title = reader.readString(offsets[6]);
  object.voteAverage = reader.readDouble(offsets[7]);
  return object;
}

P _favouriteEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readStringList(offset) ?? []) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _favouriteEntityGetId(FavouriteEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _favouriteEntityGetLinks(FavouriteEntity object) {
  return [];
}

void _favouriteEntityAttach(
  IsarCollection<dynamic> col,
  Id id,
  FavouriteEntity object,
) {
  object.id = id;
}

extension FavouriteEntityByIndex on IsarCollection<FavouriteEntity> {
  Future<FavouriteEntity?> getByMovieId(int movieId) {
    return getByIndex(r'movieId', [movieId]);
  }

  FavouriteEntity? getByMovieIdSync(int movieId) {
    return getByIndexSync(r'movieId', [movieId]);
  }

  Future<bool> deleteByMovieId(int movieId) {
    return deleteByIndex(r'movieId', [movieId]);
  }

  bool deleteByMovieIdSync(int movieId) {
    return deleteByIndexSync(r'movieId', [movieId]);
  }

  Future<List<FavouriteEntity?>> getAllByMovieId(List<int> movieIdValues) {
    final values = movieIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'movieId', values);
  }

  List<FavouriteEntity?> getAllByMovieIdSync(List<int> movieIdValues) {
    final values = movieIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'movieId', values);
  }

  Future<int> deleteAllByMovieId(List<int> movieIdValues) {
    final values = movieIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'movieId', values);
  }

  int deleteAllByMovieIdSync(List<int> movieIdValues) {
    final values = movieIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'movieId', values);
  }

  Future<Id> putByMovieId(FavouriteEntity object) {
    return putByIndex(r'movieId', object);
  }

  Id putByMovieIdSync(FavouriteEntity object, {bool saveLinks = true}) {
    return putByIndexSync(r'movieId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByMovieId(List<FavouriteEntity> objects) {
    return putAllByIndex(r'movieId', objects);
  }

  List<Id> putAllByMovieIdSync(
    List<FavouriteEntity> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'movieId', objects, saveLinks: saveLinks);
  }
}

extension FavouriteEntityQueryWhereSort
    on QueryBuilder<FavouriteEntity, FavouriteEntity, QWhere> {
  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterWhere> anyMovieId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'movieId'),
      );
    });
  }
}

extension FavouriteEntityQueryWhere
    on QueryBuilder<FavouriteEntity, FavouriteEntity, QWhereClause> {
  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterWhereClause>
  idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterWhereClause>
  movieIdEqualTo(int movieId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'movieId', value: [movieId]),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterWhereClause>
  movieIdNotEqualTo(int movieId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'movieId',
                lower: [],
                upper: [movieId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'movieId',
                lower: [movieId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'movieId',
                lower: [movieId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'movieId',
                lower: [],
                upper: [movieId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterWhereClause>
  movieIdGreaterThan(int movieId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'movieId',
          lower: [movieId],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterWhereClause>
  movieIdLessThan(int movieId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'movieId',
          lower: [],
          upper: [movieId],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterWhereClause>
  movieIdBetween(
    int lowerMovieId,
    int upperMovieId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'movieId',
          lower: [lowerMovieId],
          includeLower: includeLower,
          upper: [upperMovieId],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension FavouriteEntityQueryFilter
    on QueryBuilder<FavouriteEntity, FavouriteEntity, QFilterCondition> {
  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  addedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'addedAt', value: value),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  addedAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'addedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  addedAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'addedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  addedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'addedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  genresElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'genres',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  genresElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'genres',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  genresElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'genres',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  genresElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'genres',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  genresElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'genres',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  genresElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'genres',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  genresElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'genres',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  genresElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'genres',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  genresElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'genres', value: ''),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  genresElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'genres', value: ''),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  genresLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'genres', length, true, length, true);
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  genresIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'genres', 0, true, 0, true);
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  genresIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'genres', 0, false, 999999, true);
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  genresLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'genres', 0, true, length, include);
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  genresLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'genres', length, include, 999999, true);
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  genresLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'genres',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  mediaTypeEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'mediaType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  mediaTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'mediaType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  mediaTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'mediaType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  mediaTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'mediaType',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  mediaTypeStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'mediaType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  mediaTypeEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'mediaType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  mediaTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'mediaType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  mediaTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'mediaType',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  mediaTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'mediaType', value: ''),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  mediaTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'mediaType', value: ''),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  movieIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'movieId', value: value),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  movieIdGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'movieId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  movieIdLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'movieId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  movieIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'movieId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  posterPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'posterPath'),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  posterPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'posterPath'),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  posterPathEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'posterPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  posterPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'posterPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  posterPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'posterPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  posterPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'posterPath',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  posterPathStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'posterPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  posterPathEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'posterPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  posterPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'posterPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  posterPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'posterPath',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  posterPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'posterPath', value: ''),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  posterPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'posterPath', value: ''),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  releaseDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'releaseDate'),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  releaseDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'releaseDate'),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  releaseDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'releaseDate', value: value),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  releaseDateGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'releaseDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  releaseDateLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'releaseDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  releaseDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'releaseDate',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  titleEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'title',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  titleStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  titleEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'title',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'title', value: ''),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'title', value: ''),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  voteAverageEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'voteAverage',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  voteAverageGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'voteAverage',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  voteAverageLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'voteAverage',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterFilterCondition>
  voteAverageBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'voteAverage',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }
}

extension FavouriteEntityQueryObject
    on QueryBuilder<FavouriteEntity, FavouriteEntity, QFilterCondition> {}

extension FavouriteEntityQueryLinks
    on QueryBuilder<FavouriteEntity, FavouriteEntity, QFilterCondition> {}

extension FavouriteEntityQuerySortBy
    on QueryBuilder<FavouriteEntity, FavouriteEntity, QSortBy> {
  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterSortBy> sortByAddedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedAt', Sort.asc);
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterSortBy>
  sortByAddedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedAt', Sort.desc);
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterSortBy>
  sortByMediaType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaType', Sort.asc);
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterSortBy>
  sortByMediaTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaType', Sort.desc);
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterSortBy> sortByMovieId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieId', Sort.asc);
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterSortBy>
  sortByMovieIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieId', Sort.desc);
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterSortBy>
  sortByPosterPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'posterPath', Sort.asc);
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterSortBy>
  sortByPosterPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'posterPath', Sort.desc);
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterSortBy>
  sortByReleaseDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'releaseDate', Sort.asc);
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterSortBy>
  sortByReleaseDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'releaseDate', Sort.desc);
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterSortBy>
  sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterSortBy>
  sortByVoteAverage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voteAverage', Sort.asc);
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterSortBy>
  sortByVoteAverageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voteAverage', Sort.desc);
    });
  }
}

extension FavouriteEntityQuerySortThenBy
    on QueryBuilder<FavouriteEntity, FavouriteEntity, QSortThenBy> {
  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterSortBy> thenByAddedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedAt', Sort.asc);
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterSortBy>
  thenByAddedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedAt', Sort.desc);
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterSortBy>
  thenByMediaType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaType', Sort.asc);
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterSortBy>
  thenByMediaTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaType', Sort.desc);
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterSortBy> thenByMovieId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieId', Sort.asc);
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterSortBy>
  thenByMovieIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieId', Sort.desc);
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterSortBy>
  thenByPosterPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'posterPath', Sort.asc);
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterSortBy>
  thenByPosterPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'posterPath', Sort.desc);
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterSortBy>
  thenByReleaseDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'releaseDate', Sort.asc);
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterSortBy>
  thenByReleaseDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'releaseDate', Sort.desc);
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterSortBy>
  thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterSortBy>
  thenByVoteAverage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voteAverage', Sort.asc);
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QAfterSortBy>
  thenByVoteAverageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voteAverage', Sort.desc);
    });
  }
}

extension FavouriteEntityQueryWhereDistinct
    on QueryBuilder<FavouriteEntity, FavouriteEntity, QDistinct> {
  QueryBuilder<FavouriteEntity, FavouriteEntity, QDistinct>
  distinctByAddedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'addedAt');
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QDistinct> distinctByGenres() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'genres');
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QDistinct>
  distinctByMediaType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mediaType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QDistinct>
  distinctByMovieId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'movieId');
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QDistinct>
  distinctByPosterPath({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'posterPath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QDistinct>
  distinctByReleaseDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'releaseDate');
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QDistinct> distinctByTitle({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FavouriteEntity, FavouriteEntity, QDistinct>
  distinctByVoteAverage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'voteAverage');
    });
  }
}

extension FavouriteEntityQueryProperty
    on QueryBuilder<FavouriteEntity, FavouriteEntity, QQueryProperty> {
  QueryBuilder<FavouriteEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FavouriteEntity, DateTime, QQueryOperations> addedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'addedAt');
    });
  }

  QueryBuilder<FavouriteEntity, List<String>, QQueryOperations>
  genresProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'genres');
    });
  }

  QueryBuilder<FavouriteEntity, String, QQueryOperations> mediaTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mediaType');
    });
  }

  QueryBuilder<FavouriteEntity, int, QQueryOperations> movieIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'movieId');
    });
  }

  QueryBuilder<FavouriteEntity, String?, QQueryOperations>
  posterPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'posterPath');
    });
  }

  QueryBuilder<FavouriteEntity, DateTime?, QQueryOperations>
  releaseDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'releaseDate');
    });
  }

  QueryBuilder<FavouriteEntity, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<FavouriteEntity, double, QQueryOperations>
  voteAverageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'voteAverage');
    });
  }
}
