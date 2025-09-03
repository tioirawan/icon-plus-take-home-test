import 'package:flutter/material.dart';
import 'package:icon_plus_app/modules/core/theme/app_colors.dart';
import 'package:icon_plus_app/modules/core/theme/app_text_styles.dart';
import 'package:icon_plus_app/modules/core/utils/space_helpers.dart';

class ProfileInfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ProfileInfoTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.grey1, size: 24),
        16.widthBox,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: AppTextStyles.caption),
            4.heightBox,
            Text(
              value.isEmpty ? '-' : value,
              style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }
}
