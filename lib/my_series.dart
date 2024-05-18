import 'package:flutter/material.dart';
import 'package:series_list_app/models/series.dart';
import 'package:series_list_app/widgets/series_list_opr/series_list.dart';

class MySeries extends StatefulWidget {
  const MySeries({super.key, required this.title});

  final String title;

  @override
  State<MySeries> createState() => _MySeriesState();
}

class _MySeriesState extends State<MySeries> {
  final List<Series> _series = [
    Series(
      name: 'Breaking Bad',
      note:
          'Walter White becomes a meth kingpin to secure his family\'s future.',
      rating: 9.5,
      watchingDate: DateTime(2021, 10, 1),
      category: Category.drama,
    ),
    Series(
      name: 'Stranger Things',
      note: 'A young',
      rating: 8.7,
      watchingDate: DateTime(2021, 10, 2),
      category: Category.sciFi,
    ),
    Series(
      name: 'The Haunting of Hill House',
      note:
          'Flashing between past and present, a fractured family confronts haunting memories of their old home and the terrifying events that drove them from it.',
      rating: 8.6,
      watchingDate: DateTime(2021, 10, 3),
      category: Category.horror,
    ),
    Series(
      name: 'The Witcher',
      note:
          'Geralt of Rivia, a solitary monster hunter, struggles to find his place in a world where people often prove more wicked than beasts.',
      rating: 8.2,
      watchingDate: DateTime(2021, 10, 4),
      category: Category.adventure,
    ),
    Series(
      name: 'Sherlock',
      note:
          'A modern update finds the famous sleuth and his doctor partner solving crime in 21st century London.',
      rating: 9.1,
      watchingDate: DateTime(2021, 10, 5),
      category: Category.detective,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          const Text('Grafik'),
          Expanded(
            child: SeriesList(
              series: _series,
            ),
          )
        ],
      ),
    );
  }
}
