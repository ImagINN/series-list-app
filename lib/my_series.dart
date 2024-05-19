import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:series_list_app/models/file_operations.dart';
import 'package:series_list_app/models/series.dart';
import 'package:series_list_app/widgets/new_series.dart';
import 'package:series_list_app/widgets/series_list_opr/series_list.dart';
import 'package:vertical_barchart/vertical-barchart.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';

class MySeries extends StatefulWidget {
  const MySeries({super.key, required this.title});

  final String title;

  @override
  State<MySeries> createState() => _MySeriesState();
}

class _MySeriesState extends State<MySeries> {
  List<Series> _series = [];

  final FileOperations _fileOperations = const FileOperations();

  SortingCriteria _sortingCriteria = SortingCriteria.name;

  bool _increased = true;

  IconData _icon = Icons.arrow_downward;

  int categoryValue(SeriesCategories category) {
    return _series.where((element) => element.category == category).length;
  }

  double get maxCategory {
    double max = 0;
    for (SeriesCategories category in SeriesCategories.values) {
      double k = categoryValue(category).toDouble();
      if (k > max) max = k;
    }
    return max;
  }

  List<VBarChartModel> get chartData {
    List<VBarChartModel> chartModel = [];
    int idx = 0;
    for (SeriesCategories category in SeriesCategories.values) {
      chartModel.add(VBarChartModel(
        index: idx,
        label: '${category.name.toUpperCase()} (${categoryValue(category)})',
        colors: [Colors.yellowAccent, Colors.deepOrangeAccent],
        jumlah: categoryValue(category).toDouble(),
      ));
      idx++;
    }
    return chartModel;
  }

  void _showModal() {
    showModalBottomSheet(
      context: context,
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: double.infinity),
      isScrollControlled: true,
      builder: (context) => NewSeries(addSeries: _addSeries),
      useSafeArea: true,
    );
  }

  void _addSeries(Series newSeries) async {
    setState(() {
      _series.add(newSeries);
    });
    await _fileOperations.writeToFile(jsonEncode(_series));
  }

  void _removeSeries(Series series) {
    final index = _series.indexOf(series);
    setState(() {
      _series.remove(series);
    });
    _fileOperations.writeToFile(jsonEncode(_series));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).colorScheme.error,
        content: Row(children: [
          Text('${series.name} is removed'),
          const Spacer(),
          TextButton(
              onPressed: () =>
                  ScaffoldMessenger.of(context).hideCurrentSnackBar(),
              child:
                  const Text('Cancel', style: TextStyle(color: Colors.white)))
        ]),
        action: SnackBarAction(
          label: 'UNDO',
          textColor: Colors.limeAccent,
          onPressed: () {
            setState(() {
              _series.insert(index, series);
            });
            _fileOperations.writeToFile(jsonEncode(_series));
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.wait([
      _fileOperations.readFromFile().then((value) => setState(() {
            _series = value;
          }))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          const Icon(Icons.sort),
          DropdownButton(
            dropdownColor: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(10),
            value: _sortingCriteria,
            items: SortingCriteria.values
                .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e.name.toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    )))
                .toList(),
            onChanged: (value) {
              if (value == null) return;
              setState(() => _sortingCriteria = value);
            },
          ),
          IconButton(
            icon: Icon(_icon),
            onPressed: () {
              setState(() {
                _increased = !_increased;
                _icon = _increased ? Icons.arrow_downward : Icons.arrow_upward;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showModal,
          ),
        ],
      ),
      body: Column(
        children: [
          _series.isEmpty
              ? const SizedBox(
                  height: 0.1,
                )
              : Container(
                  margin: const EdgeInsets.fromLTRB(4, 8, 4, 4),
                  padding: const EdgeInsets.fromLTRB(16, 8, 4, 8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.onPrimaryContainer,
                        Theme.of(context).colorScheme.surfaceVariant,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        children: icons.keys
                            .map((e) => Icon(
                                  icons[e],
                                  color: Colors.limeAccent,
                                ))
                            .toList(),
                      ),
                      Expanded(
                        child: VerticalBarchart(
                          background: Colors.transparent,
                          labelSizeFactor: 0.4,
                          labelColor:
                              MediaQuery.of(context).platformBrightness !=
                                      Brightness.dark
                                  ? Colors.black
                                  : Colors.white,
                          barStyle: BarStyle.CIRCLE,
                          maxX: maxCategory,
                          data: chartData,
                          showLegend: false,
                        ),
                      )
                    ],
                  )),
          Expanded(
            child: SeriesList.sort(
              series: _series,
              sortingCriteria: _sortingCriteria,
              increased: _increased,
              removeSeries: _removeSeries,
            ),
          )
        ],
      ),
    );
  }
}
