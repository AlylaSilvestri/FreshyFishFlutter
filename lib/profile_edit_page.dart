import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:freshy_fish/Models/user.dart';
import 'package:freshy_fish/log_in_page.dart';
import 'package:freshy_fish/main_page.dart';
import 'package:freshy_fish/services/storage_service.dart';
import 'package:http/http.dart' as http;

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  ProfileEditPageState createState() => ProfileEditPageState();
}

class ProfileEditPageState extends State<ProfileEditPage> {
  final StorageService _storageService = StorageService();
  final User _user = User();
  late String _userId;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      String? token = await _storageService.getToken();
      var response = await http.get(
        Uri.parse("https://freshyfishapi.ydns.eu/api/auth/me"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        print(data);
        setState(() {
          _user.name = data["data"]["name"];
          _user.email = data["data"]["email"];
          _user.address = data["data"]["address"];
          _user.phone_number = data["data"]["phone_number"];
          _userId = data["data"]["ID_user"].toString();
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load profile')),
      );
    }
  }

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      String? token = await _storageService.getToken();
      final response = await http.put(
          Uri.parse('https://freshyfishapi.ydns.eu/api/auth/user/$_userId'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
            'Accept': 'application/json'
          },
          body: _user.updatetojson()
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update profile')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred')),
      );
    }
  }

  Future<void> _deleteAccount() async {
    try {
      String? token = await _storageService.getToken();
      final response = await http.delete(
          Uri.parse("https://freshyfishapi.ydns.eu/api/auth/delete"),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': "Bearer $token",
          }
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LogInPage())
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to delete account"))
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("An error occurred"))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 0, 150, 200),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
            'Edit Profile',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
            )
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildProfileHeader(),
                const SizedBox(height: 20),
                _buildTextField(
                  label: 'Address',
                  initialValue: _user.address,
                  onChanged: (value) => _user.address = value,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter your address'
                      : null,
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  label: 'Email',
                  initialValue: _user.email,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => _user.email = value,
                  validator: (value) => _validateEmail(value),
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  label: 'Phone',
                  initialValue: _user.phone_number,
                  keyboardType: TextInputType.phone,
                  onChanged: (value) => _user.phone_number = value,
                  validator: (value) => _validatePhone(value),
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  label: 'Password',
                  obscureText: true,
                  onChanged: (value) => _user.password = value,
                  validator: (value) => _validatePassword(value),
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  label: 'Confirm Password',
                  obscureText: true,
                  onChanged: (value) => _user.password_confirmation = value,
                  validator: (value) => _validateConfirmPassword(value),
                ),
                const SizedBox(height: 30),
                _buildActionButtons()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Center(
      child: Column(
        children: [
          Text(
            _user.name ?? 'User Profile',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    String? initialValue,
    bool obscureText = false,
    required Function(String) onChanged,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      initialValue: initialValue,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300)
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue.shade500, width: 2)
        ),
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: _updateProfile,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, // Text and icon color
              backgroundColor: Color.fromARGB(255, 0, 150, 200), // Button background color
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2, // Slight shadow for an elevated look
            ),
            child: const Text(
              'Save Changes',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

        ),
        // const SizedBox(width: 16),
        // Expanded(
        //   child: OutlinedButton(
        //     onPressed: () => _showDeleteConfirmation(),
        //     style: OutlinedButton.styleFrom(
        //         foregroundColor: Colors.red,
        //         side: BorderSide(color: Colors.red.shade300),
        //         padding: const EdgeInsets.symmetric(vertical: 15),
        //         shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(12)
        //         )
        //     ),
        //     child: const Text(
        //         'Delete Account',
        //         style: TextStyle(
        //             fontSize: 16,
        //             fontWeight: FontWeight.bold
        //         )
        //     ),
        //   ),
        // ),
      ],
    );
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Account Deletion'),
        content: const Text('Are you sure you want to delete your account? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _deleteAccount();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  // Validation methods
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Please enter an email';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return !emailRegex.hasMatch(value) ? 'Enter a valid email' : null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Please enter a phone number';
    final phoneRegex = RegExp(r'^\+?[0-9]{10,14}$');
    return !phoneRegex.hasMatch(value) ? 'Enter a valid phone number' : null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter a password';
    return value.length < 6 ? 'Password must be at least 6 characters' : null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    return value != _user.password ? 'Passwords do not match' : null;
  }
}