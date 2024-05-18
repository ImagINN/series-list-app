import 'package:flutter/material.dart';
import 'package:series_list_app/models/series.dart';
import 'package:series_list_app/widgets/series_list_opr/series_object.dart';

class SeriesList extends StatelessWidget {
  const SeriesList(
      {super.key, required this.series, required this.removeSeries})
      : increased = false,
        sortingCriteria = SortingCriteria.name;
  SeriesList.sort(
      {super.key,
      required this.series,
      required this.sortingCriteria,
      required this.removeSeries,
      this.increased = true}) {
    sort(sortingCriteria, increased);
  }

  final List<Series> series;
  final SortingCriteria sortingCriteria;
  final bool increased;

  final void Function(Series series) removeSeries;

  void sort(SortingCriteria sortingCriteria, bool increased) {
    switch (sortingCriteria) {
      case SortingCriteria.name:
        series.sort((a, b) => a.name.compareTo(b.name));
        break;
      case SortingCriteria.rating:
        series.sort((a, b) => a.rating.compareTo(b.rating));
        break;
      case SortingCriteria.date:
        series.sort((a, b) => a.watchingDate.compareTo(b.watchingDate));
        break;
      case SortingCriteria.category:
        series.sort((a, b) => a.category.index.compareTo(b.category.index));
        break;
    }
    if (!increased) {
      for (int i = 0; i < series.length ~/ 2; i++) {
        Series temp = series[i];
        series[i] = series[series.length - i - 1];
        series[series.length - i - 1] = temp;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return series.isEmpty
        ? const Center(
            child: Text(
            'No series added yet.',
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ))
        : ListView.builder(
            itemCount: series.length,
            itemBuilder: (context, index) => Dismissible(
                key: ValueKey(series[index]),
                onDismissed: (direction) => removeSeries(series[index]),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Theme.of(context).colorScheme.error,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete, color: Colors.white, size: 40),
                ),
                child: SeriesObject(series[index])),
          );
  }
}
