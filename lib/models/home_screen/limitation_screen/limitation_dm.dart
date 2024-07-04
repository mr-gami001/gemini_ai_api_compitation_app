class LimitationDm {
  String? title;
  String? desc;
  int? index;
  String? iconText;
  bool? isSelected;
  LimitationDm({
    this.title,
    this.desc,
    this.index,
    this.iconText,
    this.isSelected,
  });
}

class LimitationListDm {
  String? title;
  bool? isSelected;
  int? index;
  List<LimitationDm>? limitationList;
  LimitationListDm({
    this.title,
    this.index,
    this.limitationList,
    this.isSelected,
  });
}
