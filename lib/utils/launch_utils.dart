import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openExternalUrl(String url) async {
  final uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    debugPrint('Could not launch $url');
  }
}

Future<void> openMailto(String email) async {
  await openExternalUrl('mailto:$email');
}

Future<void> openResumePdf() async {
  if (kIsWeb) {
    // Flutter web serves assets under assets/<asset_key>.
    await openExternalUrl('assets/assets/resume.pdf');
    return;
  }

  // Non-web: asset is bundled; host a public URL for true download later.
  try {
    await rootBundle.load('assets/resume.pdf');
    debugPrint(
      'Resume asset loaded. TODO: host a public PDF URL for mobile/desktop download.',
    );
  } catch (e) {
    debugPrint('Resume asset missing: $e');
  }
}
