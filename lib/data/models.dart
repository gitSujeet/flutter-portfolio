import 'package:flutter/material.dart';

class ProjectModel {
  final String title;
  final String subtitle;
  final String tag;
  final String metric;
  final String metricLabel;
  final Color accentColor;
  final List<String> techChips;

  const ProjectModel({
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.metric,
    required this.metricLabel,
    required this.accentColor,
    this.techChips = const [],
  });
}

class ExperienceModel {
  final String role;
  final String company;
  final String location;
  final String duration;
  final List<String> highlights;
  final List<String> awards;

  const ExperienceModel({
    required this.role,
    required this.company,
    required this.location,
    required this.duration,
    required this.highlights,
    required this.awards,
  });
}
