class Episode {
  final String title;
  final String date;
  final String episode;

  Episode({required this.title, required this.date, required this.episode});

  Episode.fromJson(Map<String, dynamic> json)
      : title = json["name"] as String,
        date = json["air_date"] as String,
        episode = json["episode"] as String;
}
