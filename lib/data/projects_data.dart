class Project {
  const Project({
    required this.id,
    required this.title,
    required this.description,
    required this.techStack,
    this.imageAssets = const [],
    this.coverImage,
    this.repoUrl,
    this.liveUrl,
    this.playStoreUrl,
    this.appStoreUrl,
    this.caseStudy,
    this.year = '2025',
  });

  final String id;
  final String title;
  final String description;
  final List<String> techStack;
  final List<String> imageAssets;
  final String? coverImage;
  final String? repoUrl;
  final String? liveUrl;
  final String? playStoreUrl;
  final String? appStoreUrl;
  final String? caseStudy;
  final String year;

  String? get coverAsset =>
      coverImage ?? (imageAssets.isEmpty ? null : imageAssets.first);

  String? get resolvedPlayStoreUrl {
    if (playStoreUrl != null) return playStoreUrl;
    if (liveUrl != null && liveUrl!.contains('play.google.com')) return liveUrl;
    return null;
  }

  String? get resolvedAppStoreUrl {
    if (appStoreUrl != null) return appStoreUrl;
    if (liveUrl != null && liveUrl!.contains('apps.apple.com')) return liveUrl;
    return null;
  }

  String? get resolvedLiveDemoUrl {
    if (liveUrl == null) return null;
    if (liveUrl!.contains('play.google.com') ||
        liveUrl!.contains('apps.apple.com')) {
      return null;
    }
    return liveUrl;
  }
}

final List<Project> projects = [
  const Project(
    id: 'aec-mobile',
    title: 'AEC Mobile',
    year: '2026',
    description:
        'AEC Mobile is a bilingual (Arabic/English) Flutter app for Arabian Enterprises customers and loyalty members: Catalog & Discovery: Browse and search paint/coating product categories and details. Loyalty & Rewards: Scan purchase invoices/receipts to earn points, track points history, and redeem campaign rewards. Invoices & Bills: View and filter submitted invoice history and statuses. Stores & Centers: Locate nearby Arabian Enterprises distribution centers via Google Maps. Account & Alerts: OTP phone auth, profile management, and Firebase push notifications.',
    techStack: ['Flutter', 'Dart', 'Firebase', 'FCM', 'OTP Auth'],
    imageAssets: [
      'assets/projects/aec/browse-products.png',
      'assets/projects/aec/shop-by-category.png',
      'assets/projects/aec/product-details.png',
      'assets/projects/aec/scan-receipts.png',
      'assets/projects/aec/unlock-rewards.png',
    ],
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=com.aec_mobile&hl=en',
    caseStudy:
        'Built for Arabian Enterprises customers and loyalty members as a bilingual (Arabic/English) companion app. Catalog & Discovery lets users browse and search paint/coating categories and product details. Loyalty & Rewards supports invoice/receipt scanning to earn points, history tracking, and campaign redemptions. Invoices & Bills covers submitted bill statuses with filtering. Stores & Centers locates nearby distribution centers on Google Maps. Account & Alerts includes OTP phone auth, profile management, and Firebase push notifications.',
  ),
  const Project(
    id: 'blckout',
    title: 'blckout',
    year: '2026',
    description:
        'Order coffee, browse the menu, earn loyalty rewards, and track pickup updates with Blckout — your coffee shop app.',
    techStack: [
      'Flutter',
      'Dart',
      'Firebase',
      'FCM',
      'OTP Auth',
      'Live Activities',
    ],
    imageAssets: [
      'assets/projects/blckout/branding.png',
      'assets/projects/blckout/home-search.jpg',
      'assets/projects/blckout/home-welcome.jpg',
      'assets/projects/blckout/browse-categories.jpg',
      'assets/projects/blckout/select-time.jpg',
      'assets/projects/blckout/checkout.jpg',
    ],
    coverImage: 'assets/projects/blckout/branding.png',
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=com.rlink.blckout&hl=en',
    appStoreUrl: 'https://apps.apple.com/us/app/blckout/id6758934818',
    caseStudy:
        'Order coffee, browse the menu, earn rewards & get live order updates.\n\n'
        'ORDER & PICKUP — Browse the full coffee menu, customize your drink, and get notified when your order is ready for pickup.\n\n'
        'LOYALTY REWARDS — Scan your QR code at checkout to earn points. Redeem rewards for free drinks and exclusive offers.\n\n'
        'MENU & OFFERS — Explore seasonal drinks, check ingredients, and stay updated on limited-time coffee shop deals.\n\n'
        'FAST & LIGHTWEIGHT — Optimized for speed and low data usage, with smart menu caching for a smooth experience.\n\n'
        '',
  ),
  const Project(
    id: 'maalpay',
    title: 'Maal Pay',
    year: '2025',
    description:
        'Maal Pay is more than a wallet — it\'s a movement. Born in Syria, built by Syrian talent, and designed for the future, Maal Pay connects the local economy to the world with transfers, USDT access, scan & pay, and real-time currency conversion.',
    techStack: [
      'Flutter',
      'Dart',
      'Firebase',
      'Fintech',
      'USDT',
      'QR Payments',
    ],
    imageAssets: [
      'assets/projects/maalpay/branding.png',
      'assets/projects/maalpay/home-wallet.jpg',
      'assets/projects/maalpay/balance.jpg',
      'assets/projects/maalpay/transfer.jpg',
      'assets/projects/maalpay/pay-request.jpg',
      'assets/projects/maalpay/receive-usdt.jpg',
      'assets/projects/maalpay/referrals.jpg',
    ],
    coverImage: 'assets/projects/maalpay/branding.png',
    caseStudy:
        'Maal Pay is more than a wallet — it\'s a movement. Born in Syria, built by Syrian talent, and designed for the future, Maal Pay connects our local economy to the world.\n\n'
        'From international transfers to crypto access, Maal Pay makes it possible for Syrians to move money with freedom, speed, and control — despite decades of isolation.\n\n'
        'What You Can Do with Maal Pay:\n'
        '• Send & receive money instantly — across Syria or across borders\n'
        '• Access USDT and future crypto tools, even without a bank account\n'
        '• Scan & pay in shops, restaurants, and more\n'
        '• Convert between SYP and global currencies with real-time rates\n'
        '• Play to Earn with Referrals — scratch cards, streaks, and USDT rewards\n'
        '• Track every transaction with full clarity\n\n'
        'Data Secure. Wallet Protected. 100% Syrian.\n'
        'Maal Pay works even when global apps don’t. And we’re just getting started.\n\n'
        'Welcome to the new era of money — faster, freer, and truly local.\n\n'
        'Note: Currently temporarily unavailable on app stores.',
  ),
  const Project(
    id: 'knotify',
    title: 'Knotify',
    year: '2025',
    description:
        'Knotify is a powerful platform designed to help podcasters distribute their shows seamlessly across major platforms like Spotify, Apple Podcasts, and Google Podcasts with just one click, ensuring maximum reach.',
    techStack: ['Flutter', 'Dart', 'Analytics', 'Podcasts', 'Firebase'],
    imageAssets: [
      'assets/projects/knotify/branding.png',
      'assets/projects/knotify/dashboard.png',
      'assets/projects/knotify/analytics-overview.png',
      'assets/projects/knotify/analytics-episodes.png',
    ],
    coverImage: 'assets/projects/knotify/branding.png',
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=com.rlink.knotify',
    appStoreUrl: 'https://apps.apple.com/us/app/knotify-podcast/id6633433879',
    caseStudy:
        'Knotify is a powerful platform designed to help podcasters distribute their shows seamlessly across major platforms like Spotify, Apple Podcasts, and Google Podcasts with just one click, ensuring maximum reach.\n\n'
        'It also provides in-depth analytics, offering valuable insights into downloads, listener demographics, and engagement trends. These analytics empower podcasters to refine their content strategies, optimize audience engagement, and grow their listener base efficiently.',
  ),
  const Project(
    id: 'jumlatech',
    title: 'Jumlatech',
    year: '2024',
    description:
        'Jumlatech is a commercial service designed for retail store owners, enabling them to access the key products they need.',
    techStack: ['Flutter', 'Dart', 'E-commerce', 'B2B', 'Arabic RTL'],
    imageAssets: [
      'assets/projects/jumlatech/jumla-zone.jpg',
      'assets/projects/jumlatech/home.jpg',
      'assets/projects/jumlatech/categories.jpg',
      'assets/projects/jumlatech/cart.webp',
    ],
    coverImage: 'assets/projects/jumlatech/jumla-zone.jpg',
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=com.tms.jumlatech&hl=en',
    caseStudy:
        'Jumlatech is a commercial service designed for retail store owners, enabling them to access the key products they need.\n\n'
        'Retailers can browse categories and brands, search inventory, apply discounts, manage cart quantities by piece or carton, and order wholesale goods through Jumla Zone — a bilingual Arabic experience built for Syrian retail.',
  ),
  const Project(
    id: 'etloob',
    title: 'Etloob',
    year: '2026',
    description:
        'Etloob is an online store designed to high standards and international expertise — delivering a unique shopping experience with easy, safe payments and flexible delivery methods.',
    techStack: ['Flutter', 'Dart', 'E-commerce', 'Payments', 'Delivery'],
    imageAssets: [
      'assets/projects/etloob/branding.png',
      'assets/projects/etloob/home-fashion.jpg',
      'assets/projects/etloob/home-market.jpg',
      'assets/projects/etloob/product-details.jpg',
      'assets/projects/etloob/coupons.png',
      'assets/projects/etloob/checkout.png',
      'assets/projects/etloob/delivery-branding.jpg',
    ],
    coverImage: 'assets/projects/etloob/branding.png',
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=com.etloob&hl=en',
    appStoreUrl:
        'https://apps.apple.com/us/app/etloob-shop-online/id1673303303',
    caseStudy:
        'Etloob is an online store. It has been designed according to high standards and international expertise; to give a unique shopping experience including easily safely payments, and delivery methods.\n\n'
        'Shoppers can browse products and categories, apply coupons, check out with flexible delivery options, and complete secure payments — across fashion, market, and more.',
  ),
];

Project? projectById(String id) {
  for (final project in projects) {
    if (project.id == id) return project;
  }
  return null;
}
