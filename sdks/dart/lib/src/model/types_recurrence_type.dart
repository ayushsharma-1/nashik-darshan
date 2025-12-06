//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'types_recurrence_type.g.dart';

class TypesRecurrenceType extends EnumClass {

  @BuiltValueEnumConst(wireName: r'NONE')
  static const TypesRecurrenceType RecurrenceNone = _$RecurrenceNone;
  @BuiltValueEnumConst(wireName: r'DAILY')
  static const TypesRecurrenceType RecurrenceDaily = _$RecurrenceDaily;
  @BuiltValueEnumConst(wireName: r'WEEKLY')
  static const TypesRecurrenceType RecurrenceWeekly = _$RecurrenceWeekly;
  @BuiltValueEnumConst(wireName: r'MONTHLY')
  static const TypesRecurrenceType RecurrenceMonthly = _$RecurrenceMonthly;
  @BuiltValueEnumConst(wireName: r'YEARLY')
  static const TypesRecurrenceType RecurrenceYearly = _$RecurrenceYearly;

  static Serializer<TypesRecurrenceType> get serializer => _$typesRecurrenceTypeSerializer;

  const TypesRecurrenceType._(String name): super(name);

  static BuiltSet<TypesRecurrenceType> get values => _$values;
  static TypesRecurrenceType valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class TypesRecurrenceTypeMixin = Object with _$TypesRecurrenceTypeMixin;

