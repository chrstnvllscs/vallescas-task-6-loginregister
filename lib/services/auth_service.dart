import '../models/user_model.dart';

class AuthService {
  AuthService._privateConstructor();

  static final AuthService instance = AuthService._privateConstructor();

  final List<UserModel> _users = [];
  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;
  List<UserModel> get users => List.unmodifiable(_users);

  /// Registers a new user into memory.
  /// Returns null on success, or an error message on failure.
  String? register({
    required String fullName,
    required String email,
    required String password,
  }) {
    final trimmedEmail = email.trim().toLowerCase();
    final trimmedName = fullName.trim();

    if (trimmedName.isEmpty) {
      return 'Please enter your full name.';
    }

    if (trimmedEmail.isEmpty || !trimmedEmail.contains('@') || !trimmedEmail.contains('.')) {
      return 'Please enter a valid email address.';
    }

    if (password.length < 6) {
      return 'Password must be at least 6 characters.';
    }

    final exists = _users.any((u) => u.email.toLowerCase() == trimmedEmail);
    if (exists) {
      return 'An account with this email already exists.';
    }

    final newUser = UserModel(
      fullName: trimmedName,
      email: trimmedEmail,
      password: password,
    );
    _users.add(newUser);
    return null;
  }

  /// Attempts to log in with email & password.
  /// Returns null on success, or an error message on failure.
  String? login({
    required String email,
    required String password,
  }) {
    final trimmedEmail = email.trim().toLowerCase();

    final user = _users.firstWhere(
      (u) => u.email.toLowerCase() == trimmedEmail,
      orElse: () => UserModel(fullName: '', email: '', password: ''),
    );

    if (user.email.isEmpty) {
      return 'No account found with this email.';
    }

    if (user.password != password) {
      return 'Incorrect password. Please try again.';
    }

    _currentUser = user;
    return null;
  }

  /// Logs out the current session.
  void logout() {
    _currentUser = null;
  }
}
