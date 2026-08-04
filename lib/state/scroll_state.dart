import 'package:flutter/foundation.dart';

/// Tracks which section is currently visible and the scroll offset.
/// Used to highlight the active nav link.
class PortfolioScrollState extends ChangeNotifier {
  String _activeSection = 'hero';
  double _scrollOffset = 0;

  String get activeSection => _activeSection;
  double get scrollOffset => _scrollOffset;

  void updateSection(String section) {
    if (_activeSection != section) {
      _activeSection = section;
      notifyListeners();
    }
  }

  void updateOffset(double offset) {
    _scrollOffset = offset;
    notifyListeners();
  }
}
