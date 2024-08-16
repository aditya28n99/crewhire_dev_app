import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Add provider package
import '../../../services/jobPostController.dart';

class JobPostEdit extends StatelessWidget {
  final String empId;
  final String jobId;

  JobPostEdit({required this.empId, required this.jobId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => JobPostController()..fetchJobPost(empId, jobId),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Job Post'),
          backgroundColor: Colors.red[50], // Your primary color
        ),
        body: Consumer<JobPostController>(
          builder: (context, controller, child) {
            if (controller.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (controller.error != null) {
              return Center(child: Text('Error: ${controller.error}'));
            }

            if (controller.jobPostData == null) {
              return Center(child: Text('No data found'));
            }

            final jobPostData = controller.jobPostData!;
            final benefits =
                (jobPostData['benefits'] as List<dynamic>? ?? []).join(', ');
            final skills =
                (jobPostData['skills'] as List<dynamic>? ?? []).join(', ');

            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: GlobalKey<FormState>(),
                child: Builder(
                  builder: (context) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Position
                          _buildTextFormField(
                            initialValue: jobPostData['position'],
                            labelText: 'Position',
                            icon: Icons.work,
                            validator: (value) =>
                                value!.isEmpty ? 'Enter position' : null,
                            onChanged: (value) =>
                                jobPostData['position'] = value,
                          ),
                          // Job Location
                          _buildTextFormField(
                            initialValue: jobPostData['jobLocation'],
                            labelText: 'Job Location',
                            icon: Icons.location_on,
                            validator: (value) =>
                                value!.isEmpty ? 'Enter job location' : null,
                            onChanged: (value) =>
                                jobPostData['jobLocation'] = value,
                          ),
                          // Job Description
                          _buildTextFormField(
                            initialValue: jobPostData['jobDescription'],
                            labelText: 'Job Description',
                            icon: Icons.description,
                            maxLines: 4,
                            validator: (value) =>
                                value!.isEmpty ? 'Enter job description' : null,
                            onChanged: (value) =>
                                jobPostData['jobDescription'] = value,
                          ),
                          // Job Requirements
                          _buildTextFormField(
                            initialValue: jobPostData['jobRequirements'],
                            labelText: 'Job Requirements',
                            icon: Icons.list,
                            maxLines: 4,
                            validator: (value) => value!.isEmpty
                                ? 'Enter job requirements'
                                : null,
                            onChanged: (value) =>
                                jobPostData['jobRequirements'] = value,
                          ),
                          // Education Required
                          _buildTextFormField(
                            initialValue: jobPostData['education'],
                            labelText: 'Education Required',
                            icon: Icons.school,
                            validator: (value) => value!.isEmpty
                                ? 'Enter education required'
                                : null,
                            onChanged: (value) =>
                                jobPostData['education'] = value,
                          ),
                          // Experience Required
                          _buildTextFormField(
                            initialValue: jobPostData['experience'],
                            labelText: 'Experience Required',
                            icon: Icons.monetization_on,
                            validator: (value) => value!.isEmpty
                                ? 'Enter experience required'
                                : null,
                            onChanged: (value) =>
                                jobPostData['experience'] = value,
                          ),
                          // Salary
                          _buildTextFormField(
                            initialValue: jobPostData['salary'],
                            labelText: 'Salary',
                            icon: Icons.monetization_on,
                            validator: (value) =>
                                value!.isEmpty ? 'Enter salary' : null,
                            onChanged: (value) => jobPostData['salary'] = value,
                          ),
                          // Employment Type
                          _buildTextFormField(
                            initialValue: jobPostData['employementType'],
                            labelText: 'Employment Type',
                            icon: Icons.work_outline,
                            validator: (value) =>
                                value!.isEmpty ? 'Enter employment type' : null,
                            onChanged: (value) =>
                                jobPostData['employementType'] = value,
                          ),
                          // Work Type
                          _buildTextFormField(
                            initialValue: jobPostData['workType'],
                            labelText: 'Work Type',
                            icon: Icons.work_outline,
                            validator: (value) =>
                                value!.isEmpty ? 'Enter work type' : null,
                            onChanged: (value) =>
                                jobPostData['workType'] = value,
                          ),
                          // Benefits
                          _buildTextFormField(
                            initialValue: benefits,
                            labelText: 'Benefits',
                            icon: Icons.card_giftcard,
                            validator: (value) =>
                                value!.isEmpty ? 'Enter benefits' : null,
                            onChanged: (value) {
                              jobPostData['benefits'] = value
                                  .split(',')
                                  .map((s) => s.trim())
                                  .toList();
                            },
                          ),
                          // Skills
                          _buildTextFormField(
                            initialValue: skills,
                            labelText: 'Skills',
                            icon: Icons.star,
                            validator: (value) =>
                                value!.isEmpty ? 'Enter skills' : null,
                            onChanged: (value) {
                              jobPostData['skills'] = value
                                  .split(',')
                                  .map((s) => s.trim())
                                  .toList();
                            },
                          ),
                          // Apply Before
                          _buildTextFormField(
                            initialValue: jobPostData['applyBefore'],
                            labelText: 'Apply Before (YYYY-MM-DD)',
                            icon: Icons.calendar_today,
                            validator: (value) => value!.isEmpty
                                ? 'Enter apply before date'
                                : null,
                            onChanged: (value) =>
                                jobPostData['applyBefore'] = value,
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              final form = Form.of(context);
                              if (form != null && form.validate()) {
                                controller.updateJobPost(
                                    empId, jobId, jobPostData);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Job post updated successfully')),
                                );
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Update'),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF130160),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required String initialValue,
    required String labelText,
    int? maxLines,
    required String? Function(String?) validator,
    required void Function(String) onChanged,
    required IconData icon,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
          prefixIcon: Icon(icon,
              color: Colors.redAccent[400]), // Colors.redAccent.shade400 color
        ),
        maxLines: maxLines ?? 1,
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }
}
