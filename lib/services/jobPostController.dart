// job_post_controller.dart
import 'package:flutter/material.dart';
import 'remote_services.dart'; // Import the API service

class JobPostController extends ChangeNotifier {
  Map<String, dynamic>? _jobPostData;
  bool _isLoading = false;
  String? _error;

  Map<String, dynamic>? get jobPostData => _jobPostData;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchJobPost(String employerId, String jobId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _jobPostData = await RemoteServices.fetchJobPost(employerId, jobId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateJobPost(
      String employerId, String jobId, Map<String, dynamic> updatedData) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await RemoteServices.updateJobPost(employerId, jobId, updatedData);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
