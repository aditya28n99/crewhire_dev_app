import 'package:crewhire_dev_app/profile/employer/posts/jobPostDetail.dart';
import 'package:flutter/material.dart';
import '../../../models/post_model.dart';
import '../../../services/remote_services.dart';
import 'package:intl/intl.dart'; // For date formatting

class JobPostListPage extends StatefulWidget {
  const JobPostListPage({Key? key}) : super(key: key);

  @override
  State<JobPostListPage> createState() => _JobPostListPageState();
}

class _JobPostListPageState extends State<JobPostListPage> {
  late Future<List<Post>> _futurePosts;

  @override
  void initState() {
    super.initState();
    _futurePosts =
        RemoteServices.fetchPosts('068979ad-8d63-41a0-b95c-3d9fcfd1a432');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back when back button is pressed
          },
        ),
        title: Text('Job Post List'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search functionality here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<List<Post>>(
          future: _futurePosts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'EMPTY',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      'You do not have any post yet',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              );
            } else {
              return PostsListWidget(posts: snapshot.data!);
            }
          },
        ),
      ),
    );
  }
}

class PostsListWidget extends StatelessWidget {
  final List<Post> posts;

  const PostsListWidget({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.0),
          posts.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'EMPTY',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20.0,
                        ),
                      ),
                      Text(
                        'You do not have any post yet',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: posts
                      .map((post) => PostCardWidget(
                            post: post,
                            employerId: '068979ad-8d63-41a0-b95c-3d9fcfd1a432',
                          ))
                      .toList(),
                ),
        ],
      ),
    );
  }
}

// Separate PostCardWidget
class PostCardWidget extends StatelessWidget {
  final Post post;
  final String employerId;

  const PostCardWidget({Key? key, required this.post, required this.employerId})
      : super(key: key);

  String calculateStatus(DateTime applyBefore) {
    final currentDate = DateTime.now();
    return applyBefore.isAfter(currentDate) ? 'Active' : 'Expired';
  }

  @override
  Widget build(BuildContext context) {
    final status = calculateStatus(DateTime.parse(post.applyBefore));
    final statusColor = status == 'Active' ? Colors.green : Colors.red;

    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Placeholder for logo
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.jobTitle,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        post.jobLocation,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  child: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'view') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => JobPostDetail(
                                  empId: employerId, jobId: post.jobId)),
                        );
                      } else if (value == 'edit') {
                        // Navigator.pushNamed(
                        //   context,
                        //   '/update-job-post/$employerId/${post.jobId}',
                        // );
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'view',
                        child: Text('View'),
                      ),
                      PopupMenuItem(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                    ],
                    icon: Icon(Icons.more_vert, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Apply Before: ${DateFormat.yMMMd().format(DateTime.parse(post.applyBefore))}',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
                SizedBox(width: 10.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color:
                        status == 'Active' ? Colors.green[50] : Colors.red[50],
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(color: statusColor),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                        color: statusColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Salary: ${post.salary}',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  child: Text(
                    // 'Applications Received: ${post.numberOfApplicants}',
                    'Applications Received: 0',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
