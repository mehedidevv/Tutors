class Validators {
  // ─── Required ──────────────────────────────────────
  static String? required(String? value, {String fieldName = "This field"}) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }

  // ─── Name ──────────────────────────────────────────
  static String? name(String? value, {String fieldName = "Name"}) {
    if (value == null || value.trim().isEmpty) return "$fieldName is required";
    if (value.trim().length < 2) return "$fieldName must be at least 2 characters";
    return null;
  }

  // ─── Email ─────────────────────────────────────────
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return "Email is required";
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) return "Enter a valid email address";
    return null;
  }

  // ─── Password ──────────────────────────────────────
  static String? password(String? value) {
    if (value == null || value.isEmpty) return "Password is required";
    if (value.length < 6) return "Password must be at least 6 characters";
    return null;
  }

  // ─── Confirm Password ──────────────────────────────
  static String? confirmPassword(String? value, String originalPassword) {
    if (value == null || value.isEmpty) return "Please confirm your password";
    if (value != originalPassword) return "Passwords do not match";
    return null;
  }

  // ─── Phone ─────────────────────────────────────────
  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) return "Phone number is required";
    final phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');
    if (!phoneRegex.hasMatch(value.trim())) return "Enter a valid phone number";
    return null;
  }

  // ─── Zip Code ──────────────────────────────────────
  static String? zipCode(String? value) {
    if (value == null || value.trim().isEmpty) return "Zip code is required";
    if (value.trim().length < 3) return "Enter a valid zip code";
    return null;
  }

  // ─── OTP ───────────────────────────────────────────
  static String? otp(String? value, {int length = 6}) {
    if (value == null || value.trim().isEmpty) return "OTP is required";
    if (value.trim().length != length) return "Enter a valid $length-digit OTP";
    return null;
  }
}