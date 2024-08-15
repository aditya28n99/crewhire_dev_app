import 'package:crewhire_dev_app/profile/employer/EmployerHomeProfile.dart';
import 'package:crewhire_dev_app/profile/employer/posts/jobPostForm.dart';
import 'package:crewhire_dev_app/profile/employer/posts/jobPostListPage.dart';
import 'package:flutter/material.dart';
import '../../../services/remote_services.dart';
import '../../../models/employer_model.dart';
import '../../../models/post_model.dart';
import '../posts/jobPostForm.dart';
import 'package:intl/intl.dart'; // For date formatting

class BuyPostDashboard extends StatefulWidget {
  const BuyPostDashboard({Key? key}) : super(key: key);

  @override
  State<BuyPostDashboard> createState() => _BuyPostDashboardState();
}

class _BuyPostDashboardState extends State<BuyPostDashboard> {
  int _selectedIndex = 0; // Index for bottom navigation bar
  int notificationCount = 3;

  late Future<Employer> _employerProfile;

  @override
  void initState() {
    super.initState();
    _employerProfile = RemoteServices.fetchEmployerProfile(
        '068979ad-8d63-41a0-b95c-3d9fcfd1a432');
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigation logic based on selected index
    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              EmployerHomeProfile(), // Replace with origenal Profile Page
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              EmployerHomeProfile(), // Replace with origenal Profile Page
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              EmployerHomeProfile(), // Replace with origenal Profile Page
        ));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<Employer>(
          future: _employerProfile,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              var employer = snapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF130160), // Background color for header
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Stack(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    // Add your action here
                                  },
                                  icon: Icon(Icons.notifications,
                                      color: Colors.white), // Bell icon
                                ),
                                if (notificationCount > 0)
                                  Positioned(
                                    right: 8,
                                    top: 8,
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        '$notificationCount',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Make My Crew',
                                style: TextStyle(
                                  color: Color(
                                      0xFF00F7BA), // Color for header text
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 30,
                                    child: Icon(Icons.person,
                                        color: Color(0xFF130160)),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Welcome!',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '${employer.companyName}',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    // Post buttons go here..
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color(0xFF130160), // Button color
                                minimumSize: Size(
                                    MediaQuery.of(context).size.width * 0.8, 0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30.0),
                                    bottomRight: Radius.circular(30.0),
                                  ),
                                ),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Buy a Post',
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => JobPostForm(
                                          empId:
                                              '068979ad-8d63-41a0-b95c-3d9fcfd1a432')),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color(0xFF130160), // Button color
                                minimumSize: Size(
                                    MediaQuery.of(context).size.width * 0.8, 0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    bottomLeft: Radius.circular(30.0),
                                  ),
                                ),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Post a job ',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Recent posts go here:
                    RecentPostsWidget(),
                  ],
                ),
              );
            }
            return Container(); // Should never reach here
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30), // Increased icon size
            label: 'Home',
            backgroundColor:
                Color(0xFF130160), // Background color for the selected item
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30), // Increased icon size
            label: 'Profile',
            backgroundColor:
                Color(0xFF130160), // Background color for the selected item
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group, size: 30), // Increased icon size
            label: 'Applicants',
            backgroundColor:
                Color(0xFF130160), // Background color for the selected item
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help, size: 30), // Increased icon size
            label: 'Help',
            backgroundColor:
                Color(0xFF130160), // Background color for the selected item
          ),
        ],
        selectedItemColor: Colors.white, // Color for the selected item
        unselectedItemColor: Colors.grey[400], // Color for the unselected items
        backgroundColor:
            Color(0xFF130160), // Background color for the bottom bar
      ),
    );
  }
}

// Separated RecentPostsWidget with PostCardWidget
class RecentPostsWidget extends StatefulWidget {
  @override
  _RecentPostsWidgetState createState() => _RecentPostsWidgetState();
}

class _RecentPostsWidgetState extends State<RecentPostsWidget> {
  late Future<List<Post>> _futurePosts;

  @override
  void initState() {
    super.initState();
    _futurePosts =
        RemoteServices.fetchPosts('068979ad-8d63-41a0-b95c-3d9fcfd1a432');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your Recent Posts',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Handle view all button action
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => JobPostListPage()),
                  );
                },
                child: Text('View All'),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          FutureBuilder<List<Post>>(
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
                return Column(
                  children: snapshot.data!
                      .take(5) // Restrict to only 5 posts
                      .map((post) => PostCardWidget(
                            post: post,
                            employerId:
                                '068979ad-8d63-41a0-b95c-3d9fcfd1a432', // This Hardcoded emp Id we beed to handel
                          ))
                      .toList(),
                );
              }
            },
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
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'view') {
                      // Navigator.pushNamed(
                      //   context,
                      //   '/job-post/$employerId/${post.jobId}',
                      // );
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
