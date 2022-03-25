class Claim {
  final String? uid;
  final String? timestamp;
  final String? claim_name;
  final String? crop_type;
  final String? reason;
  final String? description;
  final String? agrarian_division;
  final String? province;
  final String? damage_date;
  final String? damage_area;
  final String? estimate;
  final List<dynamic>? claim_image_urls;
  final String? claim_video_url;

  Claim({
    this.uid,
    this.timestamp,
    this.claim_name,
    this.crop_type,
    this.reason,
    this.description,
    this.agrarian_division,
    this.province,
    this.damage_date,
    this.damage_area,
    this.estimate,
    this.claim_image_urls,
    this.claim_video_url
  });
}
