import 'package:flutter/material.dart';
import 'package:movieapp/feature/details/data/model/cast_model/details_cast_response.dart';

class CastMovie extends StatelessWidget {
  final List<Cast> castList;

  const CastMovie({super.key, required this.castList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: castList.length,
        itemBuilder: (context, index) {
          final cast = castList[index];

          if (cast.name?.isEmpty ?? true) return const SizedBox();

          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: _castItem(
              imageUrl:
                  "https://image.tmdb.org/t/p/w185${cast.profilePath ?? ''}",
              name: cast.name ?? '',
              character: cast.character ?? '',
            ),
          );
        },
      ),
    );
  }
}

Widget _castItem({
  required String imageUrl,
  required String name,
  required String character,
}) {
  return SizedBox(
    width: 80,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white24,
              width: 1.5,
            ),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),

        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 2),

        Text(
          character,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 11,
          ),
        ),
      ],
    ),
  );
}
