abstract class AddPtmEvent {
  const AddPtmEvent();
}

class TitleChanged extends AddPtmEvent {
  final String title;
  const TitleChanged(this.title);
}

class DateChanged extends AddPtmEvent {
  final DateTime date;
  const DateChanged(this.date);
}

class TimeChanged extends AddPtmEvent {
  final String time;
  const TimeChanged(this.time);
}

class LocationChanged extends AddPtmEvent {
  final String location;
  const LocationChanged(this.location);
}

class DescriptionChanged extends AddPtmEvent {
  final String description;
  const DescriptionChanged(this.description);
}

class SubmitPtm extends AddPtmEvent {
  const SubmitPtm();
}
