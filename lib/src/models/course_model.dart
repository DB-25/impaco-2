class CourseModel {
  String courseId;
  String name;
  String title;
  String instructor;
  String websiteLink;
  String platform;
  String courseLink;
  String status;

  CourseModel(
      {this.courseId,
      this.name,
      this.title,
      this.instructor,
      this.websiteLink,
      this.platform,
      this.courseLink,
      this.status});

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      courseId: map.containsKey('courseId') ? (map['courseId'] ?? '') : '',
      name: map.containsKey('name') ? (map['name'] ?? '') : '',
      title: map.containsKey('title') ? (map['title'] ?? '') : '',
      instructor:
          map.containsKey('instructor') ? (map['instructor'] ?? '') : '',
      websiteLink:
          map.containsKey('websiteLink') ? (map['websiteLink'] ?? '') : '',
      platform: map.containsKey('platform') ? (map['platform'] ?? '') : '',
      courseLink:
          map.containsKey('courseLink') ? (map['courseLink'] ?? '') : '',
      status: map.containsKey('status') ? (map['status'] ?? '') : '',
    );
  }
}
