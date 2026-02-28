import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:teachers_app/core/routes/app_router.gr.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/show_snackbar.dart';

/// Utility to handle social media interactions
class SocialMediaLauncher {
  /// Launch a social media URL
  ///
  /// [forceApp] - If true, tries to open in external app (good for Maps, YouTube)
  /// If [forceApp] is false or fails, tries to open in external browser
  /// If that fails or is not a launchable URL, opens in internal WebView
  static Future<void> launch(
    BuildContext context, {
    required String url,
    required String title,
    bool forceApp = false,
  }) async {
    final uri = Uri.parse(url);
    bool launched = false;

    // 1. Force App Launch (YouTube, Maps)
    if (forceApp) {
      try {
        launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
      } catch (_) {
        // Ignore exception, try fallback
        launched = false;
      }
    }

    // 2. Try External App (Facebook, Instagram) if not already launched
    if (!launched && !forceApp) {
      try {
        // Check if we can launch it (requires queries/schemes in AndroidManifest/Info.plist)
        // Note: valid https links often return true for canLaunchUrl because browser can handle them
        if (await canLaunchUrl(uri)) {
          launched = await launchUrl(
            uri,
            mode: LaunchMode.externalNonBrowserApplication,
          );
        }
      } catch (_) {
        // Ignore "Activity not found" or other exceptions
        // We want to fall back to WebView if app launch fails
        launched = false;
      }
    }

    if (launched) return;

    // 3. Last Resort for ForceApp: External Browser (Maps/YouTube often better in browser than WebView)
    if (forceApp) {
      try {
        launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
      } catch (_) {
        launched = false;
      }
    }

    if (launched) return;

    // 4. Fallback: Open in internal WebView
    // This runs if:
    // - forceApp failed both app and browser launch
    // - !forceApp (FB/Insta) failed app launch (e.g. app not installed)
    try {
      if (context.mounted) {
        context.router.push(AppWebViewRoute(url: url, title: title));
      }
    } catch (e) {
      if (context.mounted) {
        showFlushbar(
          context: context,
          message: 'Could not launch $title',
          isError: true,
        );
      }
    }
  }
}
