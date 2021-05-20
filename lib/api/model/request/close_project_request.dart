import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:signtracker/api/serializers.dart';

part 'close_project_request.g.dart';

abstract class CloseProjectRequest implements Built<CloseProjectRequest, CloseProjectRequestBuilder> {
  /// Initializes a new instance of the [CloseProjectRequest] class
  factory CloseProjectRequest([updates(CloseProjectRequestBuilder b)]) = _$CloseProjectRequest;

  CloseProjectRequest._();

  CloseProjectRequest copy({
    bool existingsSignsUncovered,
    bool signsRemoved,
  }) {
    return _$CloseProjectRequest._(
      existingsSignsUncovered: existingsSignsUncovered ?? this.existingsSignsUncovered,
      signsRemoved: signsRemoved ?? this.signsRemoved,
    );
  }

  @nullable
  bool get existingsSignsUncovered;

  @nullable
  bool get signsRemoved;

  /// serializer
  static Serializer<CloseProjectRequest> get serializer => _$closeProjectRequestSerializer;

  /// get Sign from Json
  static CloseProjectRequest fromJson(dynamic json) => standardSerializers.deserialize(json);

  ///convert to Json
  dynamic toJson() => standardSerializers.serialize(this);
}
