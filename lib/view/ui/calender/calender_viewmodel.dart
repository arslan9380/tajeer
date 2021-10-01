import 'package:stacked/stacked.dart';

class CalenderViewModel extends BaseViewModel {
  DateTime selectedDate = DateTime.now();

  onDateChange(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }
}
