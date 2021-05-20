import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:intl/intl.dart';

final _dateFormat = DateFormat('''yyyy-MM-ddTHH:mm:ss+00:00''');

class DateTimeSerializer implements PrimitiveSerializer<DateTime> {

  @override
  final Iterable<Type> types = new BuiltList<Type>([DateTime]);
  @override
  final String wireName = 'DateTime';

  @override
  Object serialize(Serializers serializers, DateTime dateTime,
      {FullType specifiedType: FullType.unspecified}) {
    return _dateFormat.format(dateTime.toUtc());
  }

  @override
  DateTime deserialize(Serializers serializers, Object serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final String dateTime = serialized;
    return DateTime.parse(dateTime);
  }
}