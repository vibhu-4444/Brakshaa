import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static const supportedLocales = [
    Locale('en'),
    Locale('hi'),
  ];

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _BrakshaaLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const _values = <String, Map<String, String>>{
    'en': {
      'app_name': 'Brakshaa',
      'good_morning': 'Good Morning, Farmer',
      'current_location': 'Current Location',
      'punjab': 'Punjab, India',
      'today_forecast': "Today's Forecast",
      'weather_copy':
          'Partly cloudy with a 20% chance of rain in the evening. Optimal conditions for spraying.',
      'soil_moisture': 'Soil Moisture',
      'optimal': 'Optimal',
      'ai_insights': 'AI Insights',
      'wheat_nitrogen': 'Wheat: Apply Nitrogen',
      'nitrogen_copy':
          'Based on current soil data and upcoming rain, applying 20kg/acre of Urea in the next 48 hours will maximize yield by an estimated 12%.',
      'take_action': 'Take Action',
      'market_prices': 'Market Prices',
      'quick_actions': 'Quick Actions',
      'disease_alert': 'Disease Alert',
      'yellow_rust': 'Yellow Rust Threat',
      'yellow_rust_copy':
          'High humidity reported in neighboring farms. Inspect wheat leaves for yellow stripes. Recommended preventative spray within 3 days.',
      'daily_tip': 'Daily Tip',
      'water_conservation': 'Water Conservation',
      'water_conservation_copy':
          'Irrigating during early morning or late evening reduces evaporation loss by up to 20%, saving water and energy costs.',
      'home': 'Home',
      'diagnose': 'Diagnose',
      'community': 'Community',
      'market': 'Market',
      'profile': 'Profile',
      'plant_disease_detection': 'Plant Disease Detection',
      'diagnose_intro':
          'Upload or capture a crop image and let AI identify diseases instantly.',
      'ai_disease_scanner': 'AI-Powered Disease Scanner',
      'ai_disease_copy':
          'Get instant diagnosis, causes and treatment recommendations with precision accuracy.',
      'capture_photo': 'Capture Photo',
      'upload_gallery': 'Upload from Gallery',
      'supported_formats': 'Supported formats: JPG, PNG (Max 5MB)',
      'analyze_image': 'Analyze Image',
      'analysis_results': 'Analysis Results',
      'diagnosis': 'Diagnosis',
      'confidence': '98% Confidence',
      'severity': 'High Severity',
      'symptoms': 'Symptoms',
      'causes': 'Causes',
      'treatment': 'Treatment Recommendations',
      'prevention': 'Prevention Checklist',
      'download_report': 'Download PDF Report',
      'need_more_help': 'Need more help?',
      'ask_ai': 'Ask Brakshaa AI',
      'community_subtitle': 'Connect with experts and fellow farmers.',
      'share_update': 'Share an update, ask a question...',
      'all_posts': 'All Posts',
      'expert_advice': 'Expert Advice',
      'market_trends': 'Market Trends',
      'pest_control': 'Pest Control',
      'net_balance': 'Net Balance',
      'income': 'Income',
      'expenses': 'Expenses',
      'monthly_analytics': 'Monthly Analytics',
      'this_year': 'This Year',
      'farm_details': 'Farm Details',
      'preferences': 'Preferences',
      'language': 'Language',
      'dark_mode': 'Dark Mode',
      'push_alerts': 'Push Alerts',
      'support': 'Support',
      'sign_out': 'Sign Out',
      'verified_farmer': 'Verified Farmer',
      'pro_member': 'Pro Member',
      'auth_title': 'Welcome to Brakshaa',
      'auth_subtitle': 'Sign in or continue as guest to manage your farm.',
      'email': 'Email',
      'password': 'Password',
      'continue_guest': 'Continue as Guest',
      'google_login': 'Continue with Google',
      'phone_login': 'Phone OTP Login',
    },
    'hi': {
      'app_name': 'ब्रक्षा',
      'good_morning': 'सुप्रभात, किसान',
      'current_location': 'वर्तमान स्थान',
      'punjab': 'पंजाब, भारत',
      'today_forecast': 'आज का मौसम',
      'weather_copy':
          'शाम को 20% बारिश की संभावना के साथ आंशिक बादल। छिड़काव के लिए अनुकूल स्थिति।',
      'soil_moisture': 'मिट्टी की नमी',
      'optimal': 'उत्तम',
      'ai_insights': 'AI सुझाव',
      'wheat_nitrogen': 'गेहूं: नाइट्रोजन डालें',
      'nitrogen_copy':
          'मौजूदा मिट्टी डेटा और आने वाली बारिश के आधार पर अगले 48 घंटों में 20kg/acre यूरिया उपज को लगभग 12% बढ़ा सकता है।',
      'take_action': 'कार्य करें',
      'market_prices': 'बाज़ार भाव',
      'quick_actions': 'त्वरित कार्य',
      'disease_alert': 'रोग अलर्ट',
      'yellow_rust': 'येलो रस्ट खतरा',
      'yellow_rust_copy':
          'पास के खेतों में अधिक नमी दर्ज हुई है। गेहूं की पत्तियों पर पीली धारियां जांचें। 3 दिनों में रोकथाम छिड़काव करें।',
      'daily_tip': 'आज की सलाह',
      'water_conservation': 'जल संरक्षण',
      'water_conservation_copy':
          'सुबह जल्दी या शाम को सिंचाई करने से वाष्पीकरण 20% तक घटता है, जिससे पानी और ऊर्जा बचती है।',
      'home': 'होम',
      'diagnose': 'जांच',
      'community': 'समुदाय',
      'market': 'बाज़ार',
      'profile': 'प्रोफाइल',
      'plant_disease_detection': 'फसल रोग पहचान',
      'diagnose_intro': 'फसल की फोटो अपलोड करें या खींचें और AI से तुरंत रोग पहचानें।',
      'ai_disease_scanner': 'AI रोग स्कैनर',
      'ai_disease_copy': 'तुरंत निदान, कारण और उपचार सुझाव पाएं।',
      'capture_photo': 'फोटो लें',
      'upload_gallery': 'गैलरी से अपलोड',
      'supported_formats': 'समर्थित: JPG, PNG (अधिकतम 5MB)',
      'analyze_image': 'इमेज जांचें',
      'analysis_results': 'विश्लेषण परिणाम',
      'diagnosis': 'निदान',
      'confidence': '98% भरोसा',
      'severity': 'गंभीर',
      'symptoms': 'लक्षण',
      'causes': 'कारण',
      'treatment': 'उपचार सुझाव',
      'prevention': 'रोकथाम सूची',
      'download_report': 'PDF रिपोर्ट डाउनलोड',
      'need_more_help': 'और मदद चाहिए?',
      'ask_ai': 'ब्रक्षा AI से पूछें',
      'community_subtitle': 'विशेषज्ञों और किसानों से जुड़ें।',
      'share_update': 'अपडेट साझा करें या प्रश्न पूछें...',
      'all_posts': 'सभी पोस्ट',
      'expert_advice': 'विशेषज्ञ सलाह',
      'market_trends': 'बाज़ार रुझान',
      'pest_control': 'कीट नियंत्रण',
      'net_balance': 'कुल शेष',
      'income': 'आय',
      'expenses': 'खर्च',
      'monthly_analytics': 'मासिक विश्लेषण',
      'this_year': 'इस वर्ष',
      'farm_details': 'खेत विवरण',
      'preferences': 'पसंद',
      'language': 'भाषा',
      'dark_mode': 'डार्क मोड',
      'push_alerts': 'पुश अलर्ट',
      'support': 'सहायता',
      'sign_out': 'साइन आउट',
      'verified_farmer': 'सत्यापित किसान',
      'pro_member': 'प्रो सदस्य',
      'auth_title': 'ब्रक्षा में स्वागत है',
      'auth_subtitle': 'अपने खेत को संभालने के लिए साइन इन करें या अतिथि मोड चुनें।',
      'email': 'ईमेल',
      'password': 'पासवर्ड',
      'continue_guest': 'अतिथि के रूप में जारी रखें',
      'google_login': 'Google से जारी रखें',
      'phone_login': 'फोन OTP लॉगिन',
    },
  };

  String t(String key) => _values[locale.languageCode]?[key] ?? _values['en']![key] ?? key;
}

class _BrakshaaLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _BrakshaaLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLocales
        .map((supported) => supported.languageCode)
        .contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_BrakshaaLocalizationsDelegate old) => false;
}
