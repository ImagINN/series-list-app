import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:series_list_app/models/series.dart';

class SeriesObject extends StatelessWidget {
  const SeriesObject(this.series, {super.key});

  final Series series;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            Text(
              series.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                RatingBarIndicator(
                  rating: series.rating,
                  itemSize: 24,
                  unratedColor: Colors.amber.withAlpha(50),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                  ),
                ),
                const Spacer(),
                Icon(icons[series.category], color: Colors.blueGrey),
                const SizedBox(width: 4),
                Text(series.formattedDate),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                series.note.isEmpty
                    ? const SizedBox(
                        height: 0.1,
                      )
                    : Expanded(
                        child: Text(
                          'Note: ${series.note}',
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
