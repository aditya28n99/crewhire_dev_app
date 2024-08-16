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
        // backgroundColor: Colors.blueGrey[800],
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
            final benefits = jobPost['benefits'] as List<dynamic>? ?? [];
            final skills = jobPost['skills'] as List<dynamic>? ?? [];

            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Job Title and Location
                  Center(
                    child: Column(
                      children: [
                        Text(
                          jobPost['jobTitle'] ?? 'No Title',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey[800], // Your matching color
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          jobPost['jobLocation'] ?? 'No Location',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blueGrey[600], // Your matching color
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.0),

                  // Job Description
                  _buildSection(
                    title: 'Job Description',
                    content: jobPost['jobDescription'] ?? 'No Description',
                  ),

                  // Job Requirements
                  _buildSection(
                    title: 'Job Requirements',
                    content:
                        jobPost['jobRequirements'] ?? 'No Requirements Info',
                  ),

                  // Responsibilities
                  _buildSection(
                    title: 'Responsibilities',
                    content: 'Detailed responsibilities will be listed here.',
                  ),

                  // Education Required
                  _buildSection(
                    title: 'Education Required',
                    content: jobPost['education'] ?? 'No Education Info',
                  ),

                  // Experience Required
                  _buildSection(
                    title: 'Experience Required',
                    content: jobPost['experience'] ?? 'No Experience Info',
                  ),

                  // Salary
                  _buildSection(
                    title: 'Salary',
                    content: jobPost['salary'] ?? 'No Salary Info',
                  ),

                  // Employment Type and Work Type
                  _buildSection(
                    title: 'Employment Type',
                    content:
                        jobPost['employementType'] ?? 'No Employment Type Info',
                  ),
                  _buildSection(
                    title: 'Work Type',
                    content: jobPost['workType'] ?? 'No Work Type Info',
                  ),

                  // Skills Required
                  _buildSection(
                    title: 'Skills Required',
                    content: skills.isEmpty
                        ? 'No Skills Info'
                        : skills.map((skill) => '• $skill').join('\n'),
                  ),

                  // Benefits
                  _buildSection(
                    title: 'Benefits',
                    content: benefits.isEmpty
                        ? 'No Benefits Info'
                        : benefits.map((benefit) => '• $benefit').join('\n'),
                  ),

                  // Apply Before
                  _buildSection(
                    title: 'Apply Before',
                    content: jobPost['applyBefore'] ?? 'No Apply Before Info',
                  ),

                  SizedBox(height: 40.0),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey[800], // Your matching color
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            content,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
