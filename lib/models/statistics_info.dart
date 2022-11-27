import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class StatisticsInfo {
  final String? svgSrc, title;
  final int? numOfFiles;
  final Color? color;

  StatisticsInfo({
    this.svgSrc,
    this.title,
    this.numOfFiles,
    this.color,
  });
}

List demoMyFiles = [
  StatisticsInfo(
    title: "Users",
    numOfFiles: 1328,
    svgSrc: "assets/icons/Documents.svg",
    color: primaryColor,
  ),
  StatisticsInfo(
    title: "Quotes",
    numOfFiles: 1328,
    svgSrc: "assets/icons/google_drive.svg",
    color: Color(0xFFFFA113),
  ),
  StatisticsInfo(
    title: "Pending quotes",
    numOfFiles: 1328,
    svgSrc: "assets/icons/one_drive.svg",
    color: Color(0xFFA4CDFF),
  ),
  StatisticsInfo(
    title: "Most popular quote",
    numOfFiles: 5328,
    svgSrc: "assets/icons/drop_box.svg",
    color: Color(0xFF007EE5),
  ),
];
