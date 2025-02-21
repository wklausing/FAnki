// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deck_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDeckModelCollection on Isar {
  IsarCollection<DeckModel> get deckModels => this.collection();
}

const DeckModelSchema = CollectionSchema(
  name: r'DeckModel',
  id: 7835046003316378680,
  properties: {
    r'deckCreator': PropertySchema(
      id: 0,
      name: r'deckCreator',
      type: IsarType.string,
    ),
    r'deckName': PropertySchema(
      id: 1,
      name: r'deckName',
      type: IsarType.string,
    ),
    r'flashCards': PropertySchema(
      id: 2,
      name: r'flashCards',
      type: IsarType.objectList,
      target: r'FlashCardModel',
    )
  },
  estimateSize: _deckModelEstimateSize,
  serialize: _deckModelSerialize,
  deserialize: _deckModelDeserialize,
  deserializeProp: _deckModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'FlashCardModel': FlashCardModelSchema},
  getId: _deckModelGetId,
  getLinks: _deckModelGetLinks,
  attach: _deckModelAttach,
  version: '3.1.0+1',
);

int _deckModelEstimateSize(
  DeckModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.deckCreator;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.deckName.length * 3;
  bytesCount += 3 + object.flashCards.length * 3;
  {
    final offsets = allOffsets[FlashCardModel]!;
    for (var i = 0; i < object.flashCards.length; i++) {
      final value = object.flashCards[i];
      bytesCount +=
          FlashCardModelSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _deckModelSerialize(
  DeckModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.deckCreator);
  writer.writeString(offsets[1], object.deckName);
  writer.writeObjectList<FlashCardModel>(
    offsets[2],
    allOffsets,
    FlashCardModelSchema.serialize,
    object.flashCards,
  );
}

DeckModel _deckModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DeckModel(
    deckCreator: reader.readStringOrNull(offsets[0]),
    deckName: reader.readString(offsets[1]),
    flashCards: reader.readObjectList<FlashCardModel>(
          offsets[2],
          FlashCardModelSchema.deserialize,
          allOffsets,
          FlashCardModel(),
        ) ??
        [],
  );
  object.id = id;
  return object;
}

P _deckModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readObjectList<FlashCardModel>(
            offset,
            FlashCardModelSchema.deserialize,
            allOffsets,
            FlashCardModel(),
          ) ??
          []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _deckModelGetId(DeckModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _deckModelGetLinks(DeckModel object) {
  return [];
}

void _deckModelAttach(IsarCollection<dynamic> col, Id id, DeckModel object) {
  object.id = id;
}

extension DeckModelQueryWhereSort
    on QueryBuilder<DeckModel, DeckModel, QWhere> {
  QueryBuilder<DeckModel, DeckModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DeckModelQueryWhere
    on QueryBuilder<DeckModel, DeckModel, QWhereClause> {
  QueryBuilder<DeckModel, DeckModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DeckModel, DeckModel, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<DeckModel, DeckModel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DeckModel, DeckModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DeckModel, DeckModel, QAfterWhereClause> idBetween(
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

extension DeckModelQueryFilter
    on QueryBuilder<DeckModel, DeckModel, QFilterCondition> {
  QueryBuilder<DeckModel, DeckModel, QAfterFilterCondition>
      deckCreatorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deckCreator',
      ));
    });
  }

  QueryBuilder<DeckModel, DeckModel, QAfterFilterCondition>
      deckCreatorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deckCreator',
      ));
    });
  }

  QueryBuilder<DeckModel, DeckModel, QAfterFilterCondition> deckCreatorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deckCreator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeckModel, DeckModel, QAfterFilterCondition>
      deckCreatorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deckCreator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeckModel, DeckModel, QAfterFilterCondition> deckCreatorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deckCreator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeckModel, DeckModel, QAfterFilterCondition> deckCreatorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deckCreator',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeckModel, DeckModel, QAfterFilterCondition>
      deckCreatorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'deckCreator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeckModel, DeckModel, QAfterFilterCondition> deckCreatorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'deckCreator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeckModel, DeckModel, QAfterFilterCondition> deckCreatorContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'deckCreator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeckModel, DeckModel, QAfterFilterCondition> deckCreatorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'deckCreator',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeckModel, DeckModel, QAfterFilterCondition>
      deckCreatorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deckCreator',
        value: '',
      ));
    });
  }

  QueryBuilder<DeckModel, DeckModel, QAfterFilterCondition>
      deckCreatorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'deckCreator',
        value: '',
      ));
    });
  }

  QueryBuilder<DeckModel, DeckModel, QAfterFilterCondition> deckNameEqualTo(
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

  QueryBuilder<DeckModel, DeckModel, QAfterFilterCondition> deckNameGreaterThan(
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

  QueryBuilder<DeckModel, DeckModel, QAfterFilterCondition> deckNameLessThan(
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

  QueryBuilder<DeckModel, DeckModel, QAfterFilterCondition> deckNameBetween(
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

  QueryBuilder<DeckModel, DeckModel, QAfterFilterCondition> deckNameStartsWith(
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

  QueryBuilder<DeckModel, DeckModel, QAfterFilterCondition> deckNameEndsWith(
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

  QueryBuilder<DeckModel, DeckModel, QAfterFilterCondition> deckNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'deckName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeckModel, DeckModel, QAfterFilterCondition> deckNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'deckName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeckModel, DeckModel, QAfterFilterCondition> deckNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deckName',
        value: '',
      ));
    });
  }

  QueryBuilder<DeckModel, DeckModel, QAfterFilterCondition>
      deckNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'deckName',
        value: '',
      ));
    });
  }

  QueryBuilder<DeckModel, DeckModel, QAfterFilterCondition>
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

  QueryBuilder<DeckModel, DeckModel, QAfterFilterCondition>
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

  QueryBuilder<DeckModel, DeckModel, QAfterFilterCondition>
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

  QueryBuilder<DeckModel, DeckModel, QAfterFilterCondition>
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

  QueryBuilder<DeckModel, DeckModel, QAfterFilterCondition>
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

  QueryBuilder<DeckModel, DeckModel, QAfterFilterCondition>
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

  QueryBuilder<DeckModel, DeckModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DeckModel, DeckModel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<DeckModel, DeckModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<DeckModel, DeckModel, QAfterFilterCondition> idBetween(
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

extension DeckModelQueryObject
    on QueryBuilder<DeckModel, DeckModel, QFilterCondition> {
  QueryBuilder<DeckModel, DeckModel, QAfterFilterCondition> flashCardsElement(
      FilterQuery<FlashCardModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'flashCards');
    });
  }
}

extension DeckModelQueryLinks
    on QueryBuilder<DeckModel, DeckModel, QFilterCondition> {}

extension DeckModelQuerySortBy on QueryBuilder<DeckModel, DeckModel, QSortBy> {
  QueryBuilder<DeckModel, DeckModel, QAfterSortBy> sortByDeckCreator() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deckCreator', Sort.asc);
    });
  }

  QueryBuilder<DeckModel, DeckModel, QAfterSortBy> sortByDeckCreatorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deckCreator', Sort.desc);
    });
  }

  QueryBuilder<DeckModel, DeckModel, QAfterSortBy> sortByDeckName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deckName', Sort.asc);
    });
  }

  QueryBuilder<DeckModel, DeckModel, QAfterSortBy> sortByDeckNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deckName', Sort.desc);
    });
  }
}

extension DeckModelQuerySortThenBy
    on QueryBuilder<DeckModel, DeckModel, QSortThenBy> {
  QueryBuilder<DeckModel, DeckModel, QAfterSortBy> thenByDeckCreator() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deckCreator', Sort.asc);
    });
  }

  QueryBuilder<DeckModel, DeckModel, QAfterSortBy> thenByDeckCreatorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deckCreator', Sort.desc);
    });
  }

  QueryBuilder<DeckModel, DeckModel, QAfterSortBy> thenByDeckName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deckName', Sort.asc);
    });
  }

  QueryBuilder<DeckModel, DeckModel, QAfterSortBy> thenByDeckNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deckName', Sort.desc);
    });
  }

  QueryBuilder<DeckModel, DeckModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DeckModel, DeckModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension DeckModelQueryWhereDistinct
    on QueryBuilder<DeckModel, DeckModel, QDistinct> {
  QueryBuilder<DeckModel, DeckModel, QDistinct> distinctByDeckCreator(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deckCreator', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DeckModel, DeckModel, QDistinct> distinctByDeckName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deckName', caseSensitive: caseSensitive);
    });
  }
}

extension DeckModelQueryProperty
    on QueryBuilder<DeckModel, DeckModel, QQueryProperty> {
  QueryBuilder<DeckModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DeckModel, String?, QQueryOperations> deckCreatorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deckCreator');
    });
  }

  QueryBuilder<DeckModel, String, QQueryOperations> deckNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deckName');
    });
  }

  QueryBuilder<DeckModel, List<FlashCardModel>, QQueryOperations>
      flashCardsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'flashCards');
    });
  }
}
