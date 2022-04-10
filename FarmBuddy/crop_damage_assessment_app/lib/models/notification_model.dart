class NotificationModel {
  final String status;
  final String from;
  final String datetime;
  final String message;

  NotificationModel(
      {required this.status,
      required this.from,
      required this.datetime,
      required this.message});
}