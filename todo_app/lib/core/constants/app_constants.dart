class AppConstants {
  // API related
  // static const String baseUrl = 'YOUR_API_BASE_URL';
  
  // Storage Keys
  static const String authTokenKey = 'auth_token';
  static const String userDataKey = 'user_data';
  
  // Messages
  static const String loginSuccess = 'Successfully logged in';
  static const String loginError = 'Login failed';
  static const String registerSuccess = 'Successfully registered';
  static const String registerError = 'Registration failed';
  static const String todoAddSuccess = 'Todo added successfully';
  static const String todoUpdateSuccess = 'Todo updated successfully';
  static const String todoDeleteSuccess = 'Todo deleted successfully';
  
  // Validation
  static const String emailRequired = 'Email is required';
  static const String invalidEmail = 'Please enter a valid email';
  static const String passwordRequired = 'Password is required';
  static const String passwordTooShort = 'Password must be at least 6 characters';
  static const String todoTitleRequired = 'Todo title is required';
} 