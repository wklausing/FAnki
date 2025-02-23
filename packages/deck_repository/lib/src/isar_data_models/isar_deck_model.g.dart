// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_deck_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarDeckModelCollection on Isar {
  IsarCollection<IsarDeckModel> get isarDeckModels => this.collection();
}

const IsarDeckModelSchema = CollectionSchema(
  name: r'IsarDeckModel',
  id: -2476678780410287157,
  properties: {
    r'deckName': PropertySchema(
      id: 0,
      name: r'deckName',
      type: IsarType.string,
    ),
    r'flashCards': PropertySchema(
      id: 1,
      name: r'flashCards',
      type: IsarType.objectList,
      target: r'IsarFlashCardModel',
    )
  },
  estimateSize: _isarDeckModelEstimateSize,
  serialize: _isarDeckModelSerialize,
  deserialize: _isarDeckModelDeserialize,
  deserializeProp: _isarDeckModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'IsarFlashCardModel': IsarFlashCardModelSchema},
  getId: _isarDeckModelGetId,
  getLinks: _isarDeckModelGetLinks,
  attach: _isarDeckModelAttach,
  version: '3.1.0+1',
);

int _isarDeckModelEstimateSize(
  IsarDeckModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.deckName.length * 3;
  bytesCount += 3 + object.flashCards.length * 3;
  {
    final offsets = allOffsets[IsarFlashCardModel]!;
    for (var i = 0; i < object.flashCards.length; i++) {
      final value = object.flashCards[i];
      bytesCount +=
          IsarFlashCardModelSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _isarDeckModelSerialize(
  IsarDeckModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.deckName);
  writer.writeObjectList<IsarFlashCardModel>(
    offsets[1],
    allOffsets,
    IsarFlashCardModelSchema.serialize,
    object.flashCards,
  );
}

IsarDeckModel _isarDeckModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarDeckModel(
    deckName: reader.readString(offsets[0]),
    flashCards: reader.readObjectList<IsarFlashCardModel>(
          offsets[1],
          IsarFlashCardModelSchema.deserialize,
          allOffsets,
          IsarFlashCardModel(),
        ) ??
        [],
    id: id,
  );
  return object;
}

P _isarDeckModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readObjectList<IsarFlashCardModel>(
            offset,
            IsarFlashCardModelSchema.deserialize,
            allOffsets,
            IsarFlashCardModel(),
          ) ??
          []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarDeckModelGetId(IsarDeckModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _isarDeckModelGetLinks(IsarDeckModel object) {
  return [];
}

void _isarDeckModelAttach(
    IsarCollection<dynamic> col, Id id, IsarDeckModel object) {
  object.id = id;
}

extension IsarDeckModelQueryWhereSort
    on QueryBuilder<IsarDeckModel, IsarDeckModel, QWhere> {
  QueryBuilder<IsarDeckModel, IsarDeckModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarDeckModelQueryWhere
    on QueryBuilder<IsarDeckModel, IsarDeckModel, QWhereClause> {
  QueryBuilder<IsarDeckModel, IsarDeckModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarDeckModel, IsarDeckModel, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<IsarDeckModel, IsarDeckModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarDeckModel, IsarDeckModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarDeckModel, IsarDeckModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension IsarDeckModelQueryFilter
    on QueryBuilder<IsarDeckModel, IsarDeckModel, QFilterCondition> {
  QueryBuilder<IsarDeckModel, IsarDeckModel, QAfterFilterCondition>
      deckNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deckName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDeckModel, IsarDeckModel, QAfterFilterCondition>
      deckNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deckName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDeckModel, IsarDeckModel, QAfterFilterCondition>
      deckNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deckName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDeckModel, IsarDeckModel, QAfterFilterCondition>
      deckNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deckName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDeckModel, IsarDeckModel, QAfterFilterCondition>
      deckNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'deckName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDeckModel, IsarDeckModel, QAfterFilterCondition>
      deckNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'deckName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDeckModel, IsarDeckModel, QAfterFilterCondition>
      deckNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'deckName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDeckModel, IsarDeckModel, QAfterFilterCondition>
      deckNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'deckName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDeckModel, IsarDeckModel, QAfterFilterCondition>
      deckNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deckName',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarDeckModel, IsarDeckModel, QAfterFilterCondition>
      deckNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'deckName',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarDeckModel, IsarDeckModel, QAfterFilterCondition>
      flashCardsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'flashCards',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<IsarDeckModel, IsarDeckModel, QAfterFilterCondition>
      flashCardsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'flashCards',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<IsarDeckModel, IsarDeckModel, QAfterFilterCondition>
      flashCardsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'flashCards',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarDeckModel, IsarDeckModel, QAfterFilterCondition>
      flashCardsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'flashCards',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<IsarDeckModel, IsarDeckModel, QAfterFilterCondition>
      flashCardsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'flashCards',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarDeckModel, IsarDeckModel, QAfterFilterCondition>
      flashCardsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'flashCards',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<IsarDeckModel, IsarDeckModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarDeckModel, IsarDeckModel, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarDeckModel, IsarDeckModel, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarDeckModel, IsarDeckModel, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension IsarDeckModelQueryObject
    on QueryBuilder<IsarDeckModel, IsarDeckModel, QFilterCondition> {
  QueryBuilder<IsarDeckModel, IsarDeckModel, QAfterFilterCondition>
      flashCardsElement(FilterQuery<IsarFlashCardModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'flashCards');
    });
  }
}

extension IsarDeckModelQueryLinks
    on QueryBuilder<IsarDeckModel, IsarDeckModel, QFilterCondition> {}

extension IsarDeckModelQuerySortBy
    on QueryBuilder<IsarDeckModel, IsarDeckModel, QSortBy> {
  QueryBuilder<IsarDeckModel, IsarDeckModel, QAfterSortBy> sortByDeckName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deckName', Sort.asc);
    });
  }

  QueryBuilder<IsarDeckModel, IsarDeckModel, QAfterSortBy>
      sortByDeckNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deckName', Sort.desc);
    });
  }
}

extension IsarDeckModelQuerySortThenBy
    on QueryBuilder<IsarDeckModel, IsarDeckModel, QSortThenBy> {
  QueryBuilder<IsarDeckModel, IsarDeckModel, QAfterSortBy> thenByDeckName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deckName', Sort.asc);
    });
  }

  QueryBuilder<IsarDeckModel, IsarDeckModel, QAfterSortBy>
      thenByDeckNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deckName', Sort.desc);
    });
  }

  QueryBuilder<IsarDeckModel, IsarDeckModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarDeckModel, IsarDeckModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension IsarDeckModelQueryWhereDistinct
    on QueryBuilder<IsarDeckModel, IsarDeckModel, QDistinct> {
  QueryBuilder<IsarDeckModel, IsarDeckModel, QDistinct> distinctByDeckName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deckName', caseSensitive: caseSensitive);
    });
  }
}

extension IsarDeckModelQueryProperty
    on QueryBuilder<IsarDeckModel, IsarDeckModel, QQueryProperty> {
  QueryBuilder<IsarDeckModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarDeckModel, String, QQueryOperations> deckNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deckName');
    });
  }

  QueryBuilder<IsarDeckModel, List<IsarFlashCardModel>, QQueryOperations>
      flashCardsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'flashCards');
    });
  }
}
