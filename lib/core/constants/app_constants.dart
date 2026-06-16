import '../data/portfolio_data.dart';

class AppConstants {
  static Map<String, dynamic> get _info =>
      PortfolioData.data['personalInfo'] ?? {};

  static String get devName => _info['name'] ?? 'Rania Abdelbary';
  static String get devTitle => _info['title'] ?? 'Architectural Engineer | BIM Specialist';
  static String get devDescription =>
      _info['description'] ??
      'BIM-focused Architectural Engineer with 8+ years of experience in architectural design, site supervision, and finishing works management.';

  static String get devImagePath =>
      _info['image'] ?? 'assets/images/rania_image.png';
  static String get devCvPath =>
      _info['cv'] ??
      '';

  // Social Links
  static String get githubUrl =>
      _info['github'] ?? '';
  static String get linkedinUrl =>
      _info['linkedin'] ?? 'https://www.linkedin.com/in/rania-abdelbary-718b85342';
  static String get email =>
      'mailto:${_info['email'] ?? 'ranianasr609@gmail.com'}';
  static String get whatsappNumber =>
      _info['whatsappNumber'] ?? '+201011712614';
  static String get whatsappUrl =>
      'https://wa.me/${whatsappNumber.replaceAll('+', '')}';
  static String get phoneCallUrl => 'tel:${_info['phone'] ?? '+971501587005'}';
}
