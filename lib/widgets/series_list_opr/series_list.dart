import 'package:flutter/material.dart';
import 'package:series_list_app/models/series.dart';

class SeriesList extends StatelessWidget {
  const SeriesList({Key? key, required this.series}) : super(key: key);

  final List<Series> series;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: series.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(series[index].name),
          subtitle: Text(series[index].category.toString().split('.').last),
          trailing: Text(series[index].rating.toString()),
        );
      },
    );
  }
}