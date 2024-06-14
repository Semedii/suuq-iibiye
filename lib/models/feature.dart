class Feature{
  final String title;
  final String value;

  Feature({required this.title, required this.value});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'value': value,
    };
  }
}