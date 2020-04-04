class DataModel {
  String primaryId;
  String name;
  String contactNo;
  String noOfPeople;
  String pinCode;
  String type;
  String address;

  DataModel.fromJson(Map<String, dynamic> parsedJson)
    : primaryId = parsedJson['primaryId'],
        name = parsedJson['name'],
        contactNo = parsedJson['contactNo'],
        noOfPeople = parsedJson['noOfPeople'],
        pinCode = parsedJson['pinCode'],
        type = parsedJson['type'],
        address = parsedJson['address'];
}