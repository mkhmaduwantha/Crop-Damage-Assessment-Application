class NotificationModel {
  final String avatarIcon;
  final String from;
  final String datetime;
  final String message;

  NotificationModel(
      {required this.avatarIcon,
      required this.from,
      required this.datetime,
      required this.message});
}