import 'package:flutter/material.dart';
import 'package:series_list_app/models/series.dart';

class SeriesObject extends StatelessWidget {
  const SeriesObject({Key? key, required this.series}) : super(key: key);

  final Series series;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          Text(series.name),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              const SizedBox(height: 4),
              Text(series.rating.toStringAsFixed(2)),
              const Spacer(),
              const Icon(Icons.calendar_today, color: Colors.blueAccent),
              const SizedBox(height: 4),
              Text(series.watchingDate.toString()),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              series.note.isEmpty
                  ? const SizedBox(height: 0.1,)
                  : Text('Note: ${series.note}')
            ],
          )
        ],
      ),
    ));
  }
}
