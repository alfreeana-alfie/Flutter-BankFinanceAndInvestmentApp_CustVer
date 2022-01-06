import 'package:flutter_banking_app/utils/string.dart';

class Testimonial {
  int? id;
  String? locale, name, testimonials, createdAt, status;

  Testimonial(
      {this.id,
      this.locale,
      this.name,
      this.testimonials,
      this.status,
      this.createdAt});

  factory Testimonial.fromMap(Map<String, dynamic> map) {
    return Testimonial(
        id: map[Field.id] as int?,
        locale: map[Field.locale] as String?,
        name: map[Field.name] as String?,
        testimonials: map[Field.testimonials] as String?,
        status: map[Field.status] as String?,
        createdAt: map[Field.createdAt] as String?);
  }
}
