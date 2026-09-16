import 'package:flutter/foundation.dart';
import 'package:meta_seo/meta_seo.dart';

/// Site URL used for Open Graph / Twitter share previews.
const portfolioSiteUrl = 'https://hibahashem.github.io/my-website/';
const portfolioOgImage = '${portfolioSiteUrl}og.png';

const portfolioSeoTitle = 'Hiba Hashem';
const portfolioSeoDescription =
    'Senior Flutter Developer — scalable cross-platform apps with Clean Architecture, BLoC, Firebase & CI/CD.';

void configureMetaSeo() {
  if (kIsWeb) {
    MetaSEO().config();
  }
}

void applyPortfolioSeo({
  String title = portfolioSeoTitle,
  String description = portfolioSeoDescription,
  String? imageUrl,
  String? url,
}) {
  if (!kIsWeb) return;

  final meta = MetaSEO();
  final ogImage = imageUrl ?? portfolioOgImage;
  final pageUrl = url ?? portfolioSiteUrl;

  meta
    ..author(author: 'Hiba Hashem')
    ..description(description: description)
    ..keywords(
      keywords:
          'Hiba Hashem, Flutter Developer, Mobile Developer, Dart, Portfolio',
    )
    ..ogTitle(ogTitle: title)
    ..ogDescription(ogDescription: description)
    ..ogImage(ogImage: ogImage)
    ..twitterCard(twitterCard: TwitterCard.summaryLargeImage)
    ..twitterTitle(twitterTitle: title)
    ..twitterDescription(twitterDescription: description)
    ..twitterImage(twitterImage: ogImage)
    ..propertyContent(property: 'og:type', content: 'website')
    ..propertyContent(property: 'og:site_name', content: 'Hiba Hashem')
    ..propertyContent(property: 'og:url', content: pageUrl)
    ..nameContent(name: 'title', content: title)
    ..nameContent(name: 'application-name', content: 'Hiba Hashem');
}
