class FitnessGoalDm {
  String? title;
  String? desc;
  int? index;
  String? iconText;
  List<KeyPoint>? keyPoints;
  FitnessGoalDm({
    this.title,
    this.desc,
    this.index,
    this.iconText,
    this.keyPoints,
  });
}

class KeyPoint {
  String? title;
  bool? isSelected;
  KeyPoint({this.title, this.isSelected});
}
