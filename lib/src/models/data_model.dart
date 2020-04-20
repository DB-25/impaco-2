class DataModel {
  String primaryId;
  String attrOne;
  String attrTwo;
  String attrThr;
  String attrFour;
  String attrFive;
  String attrSix;
  String status;

  DataModel(
      {this.primaryId,
      this.attrOne,
      this.attrTwo,
      this.attrThr,
      this.attrFour,
      this.attrFive,
      this.attrSix,
      this.status});

  factory DataModel.fromMap(Map<String, dynamic> map) {
    return DataModel(
      primaryId: map.containsKey('primaryId') ? (map['primaryId'] ?? '') : '',
      attrOne: map.containsKey('attrOne') ? (map['attrOne'] ?? '') : '',
      attrTwo: map.containsKey('attrTwo') ? (map['attrTwo'] ?? '') : '',
      attrThr: map.containsKey('attrThr') ? (map['attrThr'] ?? '') : '',
      attrFour: map.containsKey('attrFour') ? (map['attrFour'] ?? '') : '',
      attrFive: map.containsKey('attrFive') ? (map['attrFive'] ?? '') : '',
      attrSix: map.containsKey('attrSix') ? (map['attrSix'] ?? '') : '',
    );
  }
}
