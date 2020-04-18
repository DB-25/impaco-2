class DataModel {
  String primaryId;
  String attrOne;
  String attrTwo;
  String attrThree;
  String attrFour;
  String attrFive;
  String attrSix;
  String status;

  DataModel({
    this.primaryId,
    this.attrOne,
    this.attrTwo,
    this.attrThree,
    this.attrFour,
    this.attrFive,
    this.attrSix,
    this.status
  });

  factory DataModel.fromMap(Map<String, dynamic> parsedJson) {
    return DataModel(
        primaryId : parsedJson['primaryId'],
        attrOne : parsedJson['attrOne'],
        attrTwo : parsedJson['attrTwo'],
        attrThree : parsedJson['attrThree'],
        attrFour : parsedJson['attrFour'],
        attrFive : parsedJson['attrFive'],
        attrSix : parsedJson['attrSix'],
    );
  }
}