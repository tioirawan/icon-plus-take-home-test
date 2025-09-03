import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_plus_app/modules/auth/domain/entities/user.dart';
import 'package:icon_plus_app/modules/core/di/di.dart';
import 'package:icon_plus_app/modules/core/theme/app_dimensions.dart';
import 'package:icon_plus_app/modules/core/theme/app_text_styles.dart';
import 'package:icon_plus_app/modules/core/utils/space_helpers.dart';
import 'package:icon_plus_app/modules/profile/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:icon_plus_app/modules/profile/presentation/widgets/profile_info_tile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileBloc>()..add(ProfileFetched()),
      child: Scaffold(
        appBar: AppBar(title: const Text('My Profile')),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            switch (state.status) {
              case ProfileStatus.loading:
              case ProfileStatus.initial:
                return const Center(child: CircularProgressIndicator());
              case ProfileStatus.failure:
                return Center(
                  child: Text(state.errorMessage ?? 'Failed to load profile.'),
                );
              case ProfileStatus.success:
                if (state.user == null) {
                  return const Center(child: Text('User data not found.'));
                }
                return _ProfileSuccessView(user: state.user!);
            }
          },
        ),
      ),
    );
  }
}

class _ProfileSuccessView extends StatelessWidget {
  final User user;
  const _ProfileSuccessView({required this.user});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppDimensions.pagePadding,
      child: Column(
        children: [
          24.heightBox,
          CircleAvatar(
            radius: 50,
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Text(
              user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
              style: AppTextStyles.heading1.copyWith(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          16.heightBox,
          Text(user.name, style: AppTextStyles.heading2),
          8.heightBox,
          Text(user.email, style: AppTextStyles.caption.copyWith(fontSize: 16)),
          32.heightBox,
          _buildInfoCard(context),
          32.heightBox,
          _buildActions(context),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return Container(
      padding: AppDimensions.cardPadding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppDimensions.borderRadiusMd,
      ),
      child: Column(
        children: [
          ProfileInfoTile(
            icon: CupertinoIcons.briefcase_fill,
            label: 'Jabatan',
            value: user.jobTitle ?? '',
          ),
          const Divider(height: 32),
          ProfileInfoTile(
            icon: CupertinoIcons.building_2_fill,
            label: 'Company',
            value: user.company ?? '',
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppDimensions.borderRadiusMd,
      ),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(CupertinoIcons.pencil),
            title: const Text('Edit Profile'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // TODO: Navigate to Edit Profile Page
            },
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          ListTile(
            leading: const Icon(CupertinoIcons.lock_fill),
            title: const Text('Change Password'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // TODO: Navigate to Change Password Page
            },
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () {
              context.read<ProfileBloc>().add(ProfileLogoutSubmitted());
            },
          ),
        ],
      ),
    );
  }
}
