import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

final formatter = DateFormat.yMd(Platform.localeName);

enum SeriesCategories { sciFi, drama, horror, adventure, detective }

enum SortingCriteria { name, rating, date, category }

const icons = {
  SeriesCategories.sciFi: Icons.rocket_launch,
  SeriesCategories.drama: Icons.theater_comedy,
  SeriesCategories.horror: Icons.bug_report,
  SeriesCategories.adventure: Icons.directions_run,
  SeriesCategories.detective: Icons.local_police,
};

class Series {
  Series({
    required this.name,
    this.note = '',
    required this.rating,
    required this.watchingDate,
    required this.category,
  }) : id = uuid.v4();

  late String id, name, note;
  late double rating;
  late DateTime watchingDate;
  late SeriesCategories category;
  late bool favorite = false;

  String get formattedDate {
    initializeDateFormatting(Platform.localeName);
    return formatter.format(watchingDate);
  }

  Series.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    note = json['note'];
    rating = json['rating'];
    watchingDate = DateTime.parse(json['watchingDate']);
    category = SeriesCategories.values.firstWhere((element) => element.name == [json['category']]);
    favorite = json['favorite'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'note': note,
      'rating': rating,
      'watchingDate': watchingDate.toString(),
      'category': category.name,
      'favorite': favorite,
    };
  }
}
