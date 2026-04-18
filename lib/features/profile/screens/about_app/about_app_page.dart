import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(title: 'About App'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: context.scale(20),
          vertical: context.scaleHeight(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: context.scaleHeight(20)),
            // App Logo
            Container(
              width: context.scale(120),
              height: context.scale(120),
              decoration: BoxDecoration(
                color: context.colors.surface,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: context.colors.surface300.withValues(alpha: 0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              padding: EdgeInsets.all(context.scale(20)),
              child: Image.asset(
                'assets/logo/app_logo.png',
                fit: BoxFit.contain,
                // Fallback icon nicely gracefully handles if image is broken or missing
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.school_rounded,
                    size: context.scale(60),
                    color: context.colors.primary,
                  );
                },
              ),
            ),
            SizedBox(height: context.scaleHeight(24)),
            // App Name
            Text(
              'School Management App',
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colors.primary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: context.scaleHeight(8)),
            // Version
            Text(
              'Version 1.0.0',
              style: context.textTheme.titleMedium?.copyWith(
                color: context.colors.surface600,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: context.scaleHeight(40)),
            // Company Info Card
            Container(
              padding: EdgeInsets.all(context.scale(20)),
              decoration: BoxDecoration(
                color: context.colors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: context.colors.surface300.withValues(alpha: 0.5),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.business_rounded,
                        color: context.colors.primary,
                        size: context.scale(24),
                      ),
                      SizedBox(width: context.scale(12)),
                      Expanded(
                        child: Text(
                          'Company Information',
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.colors.surface900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.scaleHeight(16)),
                  Text(
                    'Shangar Darshan IT Solutions',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.colors.surface800,
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(8)),
                  Text(
                    'We are dedicated to providing the best software solutions for educational institutions, ensuring smooth administration and enhanced learning experiences. Our innovative platform is designed to connect teachers, students, and parents seamlessly.',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colors.surface600,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(24)),
                  // Website Link Button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final Uri url = Uri.parse('https://sgadi.info/');
                        if (!await launchUrl(url)) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Could not open the website'),
                              ),
                            );
                          }
                        }
                      },
                      icon: const Icon(Icons.language_rounded),
                      label: const Text('Visit Our Website'),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: context.scaleHeight(12),
                        ),
                        side: BorderSide(color: context.colors.primary),
                        foregroundColor: context.colors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: context.scaleHeight(40)),
            // Copyright
            Text(
              '© ${DateTime.now().year} Shangar Darshan IT Solutions.\nAll rights reserved.',
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colors.surface400,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
