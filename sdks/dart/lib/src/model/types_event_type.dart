//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'types_event_type.g.dart';

class TypesEventType extends EnumClass {

  @BuiltValueEnumConst(wireName: r'AARTI')
  static const TypesEventType EventTypeAarti = _$EventTypeAarti;
  @BuiltValueEnumConst(wireName: r'FESTIVAL')
  static const TypesEventType EventTypeFestival = _$EventTypeFestival;
  @BuiltValueEnumConst(wireName: r'CULTURAL')
  static const TypesEventType EventTypeCultural = _$EventTypeCultural;
  @BuiltValueEnumConst(wireName: r'WORKSHOP')
  static const TypesEventType EventTypeWorkshop = _$EventTypeWorkshop;
  @BuiltValueEnumConst(wireName: r'SPECIAL_DARSHAN')
  static const TypesEventType EventTypeSpecialDarshan = _$EventTypeSpecialDarshan;

  static Serializer<TypesEventType> get serializer => _$typesEventTypeSerializer;

  const TypesEventType._(String name): super(name);

  static BuiltSet<TypesEventType> get values => _$values;
  static TypesEventType valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class TypesEventTypeMixin = Object with _$TypesEventTypeMixin;

