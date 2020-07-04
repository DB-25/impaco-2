class DataModel {
  String primaryId;
  String name;
  String subject;
  String startDate;
  String startTime;
  String appName;
  String meetingLink;
  String status;

  DataModel(
      {this.primaryId,
      this.name,
      this.subject,
      this.startDate,
      this.startTime,
      this.appName,
      this.meetingLink,
      this.status});

  factory DataModel.fromMap(Map<String, dynamic> map) {
    return DataModel(
      primaryId: map.containsKey('primaryId') ? (map['primaryId'] ?? '') : '',
      name: map.containsKey('name') ? (map['name'] ?? '') : '',
      subject: map.containsKey('subject') ? (map['subject'] ?? '') : '',
      startDate: map.containsKey('startDate') ? (map['startDate'] ?? '') : '',
      startTime: map.containsKey('startTime') ? (map['startTime'] ?? '') : '',
      appName: map.containsKey('appName') ? (map['appName'] ?? '') : '',
      meetingLink:
          map.containsKey('meetingLink') ? (map['meetingLink'] ?? '') : '',
    );
  }
}
