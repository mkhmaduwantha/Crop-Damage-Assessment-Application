class Claim {
  final String uid;
  final String status;
  final int timestamp;
  final String claim_name;
  final String crop_type;
  final String reason;
  final String description;
  final String agrarian_division;
  final String province;
  final String damage_date;
  final String damage_area;
  final String estimate;
  final List<dynamic> claim_image_urls;
  final String claim_video_url;

  Claim({
    required this.uid,
    required this.status,
    required this.timestamp,
    required this.claim_name,
    required this.crop_type,
    required this.reason,
    required this.description,
    required this.agrarian_division,
    required this.province,
    required this.damage_date,
    required this.damage_area,
    required this.estimate,
    required this.claim_image_urls,
    required this.claim_video_url
  });
}
