import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:series_list_app/models/series.dart';

class NewSeries extends StatefulWidget {
  const NewSeries({Key? key, required this.addSeries}) : super(key: key);

  final void Function(Series series) addSeries;

  @override
  _NewSeriesState createState() => _NewSeriesState();
}

class _NewSeriesState extends State<NewSeries> {
  final _nameController = TextEditingController();
  final _notController = TextEditingController();
  final formatter = DateFormat.yMd(Platform.localeName);

  DateTime? _watchingDate;

  SeriesCategories _selectedCategory = SeriesCategories.sciFi;

  double _rating = 0;

  void _showDatePicker() async {
    final today = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: today,
        firstDate: DateTime(today.year - 1, today.month, today.day),
        lastDate: today);
    setState(() {
      _watchingDate = newDate;
    });
  }

  void _saveSeries() {
    if (_nameController.text.trim().isEmpty) {
      showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                title: const Text("Error"),
                content: const Text("Name cannot be empty"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("OK"))
                ],
              )));
      return;
    } else if (_rating < 1 || _rating > 5) {
      showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                title: const Text("Error"),
                content: const Text("Rating must be between 1 and 5"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("OK"))
                ],
              )));
      return;
    } else if (_watchingDate == null) {
      showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                title: const Text("Error"),
                content: const Text("Date cannot be empty"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("OK"))
                ],
              )));
      return;
    }
    widget.addSeries(Series(
      name: _nameController.text,
      note: _notController.text,
      rating: _rating,
      watchingDate: _watchingDate!,
      category: _selectedCategory,
    ));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 64, 16, 16),
      child: Column(
        children: [
          TextField(
            maxLength: 50,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Name',
              hintText: 'Enter the name of the series',hintStyle: TextStyle(fontSize: 12)
            ),
            controller: _nameController,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text("Rate",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 16,
                  )),
              const SizedBox(width: 10),
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                unratedColor: Colors.amber.withAlpha(50),
                itemSize: 30,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star_rounded,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  _rating = rating;
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Watching Date",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.7), fontSize: 16),
              ),
              const SizedBox(width: 10),
              IconButton(
                  onPressed: _showDatePicker,
                  icon: const Icon(Icons.date_range)),
              Text(
                _watchingDate == null
                    ? "No date selected"
                    : formatter.format(_watchingDate!),
                style: const TextStyle(fontSize: 16),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text("Category",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 16,
                  )),
              const SizedBox(width: 10),
              DropdownButton(
                value: _selectedCategory,
                items: SeriesCategories.values
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e.name.toUpperCase(),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() => _selectedCategory = value);
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextField(
            maxLength: 300,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Note',
              hintText: 'Enter a note',hintStyle: TextStyle(fontSize: 12),
            ),
            controller: _notController,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              ElevatedButton(
                onPressed: _saveSeries,
                child: const Text("Save"),
              ),
              const SizedBox(width: 10),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.redAccent)),
                  child: const Text("Cancel"))
            ],
          ),
        ],
      ),
    );
  }
}
