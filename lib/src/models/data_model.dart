class DataModel {
  String primaryId;
  String attrOne;
  String attrTwo;
  String attrThr;
  String attrFour;
  String attrFive;
  String attrSix;
  String status;

  DataModel({
    this.primaryId,
    this.attrOne,
    this.attrTwo,
    this.attrThr,
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
        attrThr : parsedJson['attrThr'],
        attrFour : parsedJson['attrFour'],
        attrFive : parsedJson['attrFive'],
        attrSix : parsedJson['attrSix'],
    );
  }
}