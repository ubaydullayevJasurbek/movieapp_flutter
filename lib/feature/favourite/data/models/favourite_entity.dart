import 'package:isar_community/isar.dart';

part 'favourite_entity.g.dart';

@collection
class FavouriteEntity {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late int movieId;

  late String title;
  String? posterPath;
  late double voteAverage;
  DateTime? releaseDate;
  late List<String> genres;
  late String mediaType;
  late DateTime addedAt;

  FavouriteEntity();
}
