import 'package:json_annotation/json_annotation.dart';

part 'details_cast_response.g.dart';

@JsonSerializable()
class DetailsCastResponse {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "cast")
  final List<Cast> cast;
  @JsonKey(name: "crew")
  final List<Cast> crew;

  DetailsCastResponse({
    required this.id,
    required this.cast,
    required this.crew,
  });

  factory DetailsCastResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailsCastResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailsCastResponseToJson(this);
}

@JsonSerializable()
class Cast {
  @JsonKey(name: "adult")
  final bool? adult;
  @JsonKey(name: "gender")
  final int? gender;
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "known_for_department")
  final String? knownForDepartment;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "original_name")
  final String? originalName;
  @JsonKey(name: "popularity")
  final double? popularity;
  @JsonKey(name: "profile_path")
  final String? profilePath;
  @JsonKey(name: "cast_id")
  final int? castId;
  @JsonKey(name: "character")
  final String? character;
  @JsonKey(name: "credit_id")
  final String? creditId;
  @JsonKey(name: "order")
  final int? order;
  @JsonKey(name: "department")
  final String? department;
  @JsonKey(name: "job")
  final String? job;

  Cast({
    this.adult,
    this.gender,
    required this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
    this.department,
    this.job,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);
  Map<String, dynamic> toJson() => _$CastToJson(this);
}


