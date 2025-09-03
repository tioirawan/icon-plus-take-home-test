part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];
}

class EditProfileFormSubmitted extends EditProfileEvent {
  final String name;
  final String jobTitle;
  final String company;

  const EditProfileFormSubmitted({
    required this.name,
    required this.jobTitle,
    required this.company,
  });
}
