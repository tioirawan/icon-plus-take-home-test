import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? jobTitle;
  final String? company;

  const User({
    required this.id,
    required this.email,
    required this.name,
    this.jobTitle,
    this.company,
  });

  @override
  List<Object?> get props => [id, email, name, jobTitle, company];
}
