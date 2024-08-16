import 'package:flutter/material.dart';
import '../../../services/remote_services.dart';

class JobPostDetail extends StatefulWidget {
  final String empId;
  final String jobId;

  JobPostDetail({required this.empId, required this.jobId});

  @override
  _JobPostDetailState createState() => _JobPostDetailState();
}

class _JobPostDetailState extends State<JobPostDetail> {
  late Future<Map<String, dynamic>> jobPostData;

  @override
  void initState() {
    super.initState();
    jobPostData = RemoteServices.fetchJobPost(widget.empId, widget.jobId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Post Detail'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: jobPostData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No job post details available.'));
          } else {
            final jobPost = snapshot.data!;

            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    jobPost['jobTitle'] ?? 'No Title',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Job ID: ${jobPost['jobId'] ?? 'No ID'}',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Job Description:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(jobPost['jobDescription'] ?? 'No Description'),
                  SizedBox(height: 16.0),
                  Text(
                    'Education Required:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(jobPost['education'] ?? 'No Education Info'),
                  SizedBox(height: 16.0),
                  Text(
                    'Experience Required:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(jobPost['experience'] ?? 'No Experience Info'),
                  // Add more details as needed
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
