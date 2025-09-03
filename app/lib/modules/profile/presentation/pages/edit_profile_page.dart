import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icon_plus_app/modules/auth/domain/entities/user.dart';
import 'package:icon_plus_app/modules/core/di/di.dart';
import 'package:icon_plus_app/modules/core/theme/app_dimensions.dart';
import 'package:icon_plus_app/modules/core/theme/app_text_styles.dart';
import 'package:icon_plus_app/modules/core/utils/space_helpers.dart';
import 'package:icon_plus_app/modules/profile/presentation/blocs/edit_profile_bloc/edit_profile_bloc.dart';

class EditProfilePage extends StatefulWidget {
  final User user;

  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _jobTitleController;
  late final TextEditingController _companyController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _jobTitleController = TextEditingController(text: widget.user.jobTitle);
    _companyController = TextEditingController(text: widget.user.company);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _jobTitleController.dispose();
    _companyController.dispose();
    super.dispose();
  }

  void _onSave(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<EditProfileBloc>().add(
        EditProfileFormSubmitted(
          name: _nameController.text,
          jobTitle: _jobTitleController.text,
          company: _companyController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EditProfileBloc>(),
      child: BlocListener<EditProfileBloc, EditProfileState>(
        listener: (context, state) {
          if (state.status == EditProfileStatus.success) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text("Your profile has been updated!"),
                  backgroundColor: Colors.green,
                ),
              );
            context.pop(true);
          }
          if (state.status == EditProfileStatus.failure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'Update failed'),
                  backgroundColor: Colors.red,
                ),
              );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Edit Profile', style: AppTextStyles.title),
          ),
          body: SingleChildScrollView(
            padding: AppDimensions.pagePadding,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  24.heightBox,
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator:
                        (value) =>
                            value!.isEmpty ? 'Name cannot be empty' : null,
                  ),
                  16.heightBox,
                  TextFormField(
                    controller: _jobTitleController,
                    decoration: const InputDecoration(labelText: 'Jabatan'),
                  ),
                  16.heightBox,
                  TextFormField(
                    controller: _companyController,
                    decoration: const InputDecoration(labelText: 'Company'),
                  ),
                  32.heightBox,
                  BlocBuilder<EditProfileBloc, EditProfileState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed:
                            state.status == EditProfileStatus.loading
                                ? null
                                : () => _onSave(context),
                        child:
                            state.status == EditProfileStatus.loading
                                ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                : const Text('Save Changes'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
