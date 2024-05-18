import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

final formatter = DateFormat.yMd(Platform.localeName);

enum Category { sciFi, drama, horror, adventure, detective }

const icons = {
  Category.sciFi: Icons.rocket_launch,
  Category.drama: Icons.theater_comedy,
  Category.horror: Icons.bug_report,
  Category.adventure: Icons.directions_run,
  Category.detective: Icons.local_police,
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
  late Category category;
  late bool favorite = false;

  String get formattedDate {
    initializeDateFormatting(Platform.localeName);
    return formatter.format(watchingDate);
  }
}
