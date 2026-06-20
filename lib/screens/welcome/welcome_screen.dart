import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/gold_button.dart';
import '../main/main_shell.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final safeHeight =
        MediaQuery.sizeOf(context).height -
        MediaQuery.paddingOf(context).vertical -
        62;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: AppAssets.welcomeBackground,
              fit: BoxFit.cover,
              color: Colors.black.withValues(alpha: 0.76),
              colorBlendMode: BlendMode.darken,
              errorWidget: (context, url, error) =>
                  Container(color: AppColors.background),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.background.withValues(alpha: 0.55),
                    AppColors.background.withValues(alpha: 0.96),
                    AppColors.background,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(24, 36, 24, 26),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: safeHeight > 0 ? safeHeight : 0,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 26),
                    _LuxuryLogo(),
                    const SizedBox(height: AppSpacing.xxl),
                    Text(
                      'صالون الحلاقة',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.largeTitle.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 34,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 96,
                      height: 1.3,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            AppColors.primaryGold,
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'أسلوبك.. هويتك',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.sectionTitle.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'تجربة حلاقة فاخرة بين يديك',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body,
                    ),
                    const SizedBox(height: 48),
                    const _FeatureList(),
                    const SizedBox(height: 54),
                    GoldButton(
                      text: 'ابدأ الآن',
                      icon: Icons.arrow_back_rounded,
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => const MainShell()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LuxuryLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 224,
      height: 224,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: AppColors.primaryGold, width: 1.5),
        color: AppColors.secondaryBackground,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryGold.withValues(alpha: 0.26),
            blurRadius: 36,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Image.asset(AppAssets.appLogo, fit: BoxFit.cover),
      ),
    );
  }
}

class _FeatureList extends StatelessWidget {
  const _FeatureList();

  @override
  Widget build(BuildContext context) {
    const features = [
      (Icons.event_available_rounded, 'حجز سهل وسريع'),
      (Icons.workspace_premium_rounded, 'أفضل الحلاقين'),
      (Icons.local_offer_rounded, 'عروض حصرية'),
      (Icons.credit_card_rounded, 'دفع آمن'),
    ];

    return Column(
      children: features
          .map(
            (feature) => Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppColors.primaryGold.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.borderGold),
                    ),
                    child: Icon(
                      feature.$1,
                      color: AppColors.primaryGold,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      feature.$2,
                      textAlign: TextAlign.right,
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
