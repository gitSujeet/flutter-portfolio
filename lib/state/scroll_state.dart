import 'package:flutter/foundation.dart';

/// Tracks which section is currently visible.
/// Used to highlight the active nav link.
class PortfolioScrollState extends ChangeNotifier {
  String _activeSection = 'hero';

  String get activeSection => _activeSection;

  void updateSection(String section) {
    if (_activeSection != section) {
      _activeSection = section;
      notifyListeners();
    }
  }
}
