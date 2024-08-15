import 'package:intl/intl.dart';

class Post {
  final String jobId;
  final String logoUrl;
  final String jobTitle;
  final String jobDescription;
  final String jobLocation;
  final String salary;
  final String applyBefore;
  final String daysRemaining;
  final int numApplicants;
  final List<String> benefits;
  final String education;
  final String jobRequirements;
  final String experience;
  final List<String> skills;
  final String employementType;
  final String workType;
  final String position;

  Post({
    required this.jobId,
    required this.logoUrl,
    required this.jobTitle,
    required this.jobDescription,
    required this.jobLocation,
    required this.salary,
    required this.applyBefore,
    required this.daysRemaining,
    required this.numApplicants,
    required this.benefits,
    required this.education,
    required this.jobRequirements,
    required this.experience,
    required this.skills,
    required this.employementType,
    required this.workType,
    required this.position,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      jobId: json['jobId'] ?? '',
      logoUrl: json['logoUrl'] ?? '',
      jobTitle: json['jobTitle'] ?? '',
      jobDescription: json['jobDescription'] ?? '',
      jobLocation: json['jobLocation'] ?? '',
      salary: json['salary'] ?? '',
      applyBefore: json['applyBefore'] ?? '',
      daysRemaining: calculateDaysRemaining(json['applyBefore'] ?? ''),
      numApplicants: json['numApplicants'] ?? 0,
      benefits: List<String>.from(json['benefits'] ?? []),
      education: json['education'] ?? '',
      jobRequirements: json['jobRequirements'] ?? '',
      experience: json['experience'] ?? '',
      skills: List<String>.from(json['skills'] ?? []),
      employementType: json['employementType'] ?? '',
      workType: json['workType'] ?? '',
      position: json['position'] ?? '',
    );
  }
}

String calculateDaysRemaining(String applyBefore) {
  final DateTime applyBeforeDate = DateFormat('yyyy-MM-dd').parse(applyBefore);
  final DateTime currentDate = DateTime.now();
  final int dayDiff = applyBeforeDate.difference(currentDate).inDays;

  if (dayDiff < 0) {
    return '${-dayDiff} Day${-dayDiff == 1 ? '' : 's'} Ago';
  } else {
    return '$dayDiff Day${dayDiff == 1 ? '' : 's'} Remaining';
  }
}
