import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icon_plus_app/modules/auth/domain/entities/user.dart';
import 'package:icon_plus_app/modules/core/di/di.dart';
import 'package:icon_plus_app/modules/core/router/app_router.dart';
import 'package:icon_plus_app/modules/core/theme/app_colors.dart';
import 'package:icon_plus_app/modules/core/theme/app_dimensions.dart';
import 'package:icon_plus_app/modules/core/theme/app_text_styles.dart';
import 'package:icon_plus_app/modules/core/utils/space_helpers.dart';
import 'package:icon_plus_app/modules/profile/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileBloc>()..add(ProfileFetched()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Profile', style: AppTextStyles.title),
          backgroundColor: AppColors.background,
        ),
        backgroundColor: AppColors.background,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                24.heightBox,
                CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  child: Text(
                    user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
                    style: AppTextStyles.heading1.copyWith(
                      color: AppColors.primary,
                      fontSize: 40,
                    ),
                  ),
                ),
                16.heightBox,
                Text(
                  user.name,
                  style: AppTextStyles.heading2.copyWith(
                    color: AppColors.primaryDark,
                  ),
                ),
                4.heightBox,
                Text(
                  user.email,
                  style: AppTextStyles.caption.copyWith(fontSize: 16),
                ),
              ],
            ),
          ),
          40.heightBox,
          const _SectionHeader(title: 'Account'),
          12.heightBox,
          _buildInfoSection(context),
          32.heightBox,
          const _SectionHeader(title: 'General'),
          12.heightBox,
          _buildActionsSection(context),
          24.heightBox,
        ],
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            PhosphorIconsBold.briefcase,
            color: AppColors.onBackground,
          ),
          title: Text('Position', style: AppTextStyles.caption),
          subtitle: Text(user.jobTitle ?? '-', style: AppTextStyles.body),
        ),

        ListTile(
          leading: Icon(
            PhosphorIconsBold.buildings,
            color: AppColors.onBackground,
          ),
          title: Text('Company', style: AppTextStyles.caption),
          subtitle: Text(user.company ?? '-', style: AppTextStyles.body),
        ),
      ],
    );
  }

  Widget _buildActionsSection(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            PhosphorIconsBold.pencilSimple,
            color: AppColors.onBackground,
          ),
          title: const Text('Edit Profile'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () async {
            final result = await context.push<bool>(
              AppRouter.editProfile,
              extra: user,
            );
            if (result == true && context.mounted) {
              context.read<ProfileBloc>().add(ProfileFetched());
            }
          },
        ),

        ListTile(
          leading: Icon(PhosphorIconsBold.lock, color: AppColors.onBackground),
          title: const Text('Change Password'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () => context.push(AppRouter.changePassword),
        ),

        ListTile(
          leading: Icon(PhosphorIconsBold.signOut, color: AppColors.error),
          title: const Text('Logout', style: TextStyle(color: AppColors.error)),
          onTap:
              () => context.read<ProfileBloc>().add(ProfileLogoutSubmitted()),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: AppTextStyles.title.copyWith(fontSize: 18));
  }
}
