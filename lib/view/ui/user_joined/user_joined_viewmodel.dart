import 'package:stacked/stacked.dart';
import 'package:tajeer/app/locator.dart';
import 'package:tajeer/models/event_model.dart';
import 'package:tajeer/services/common_ui_service.dart';
import 'package:tajeer/services/event_service.dart';

class UserJoinedViewModel extends BaseViewModel with CommonUiService {
  bool loading = false;
  EventService eventService = locator<EventService>();
  List<EventModel> myJoinedEvents = [];
  String msg = "";

  setLoading(bool val) {
    loading = val;
    notifyListeners();
  }

  initialise() async {
    setLoading(true);
    var response = await eventService.getJoinedEvents();
    if (response != false) {
      myJoinedEvents = response;
    }
    if (myJoinedEvents.isEmpty) {
      msg = "No Event Joined Yet";
    }
    setLoading(false);
  }
}
