import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/brakshaa_models.dart';

final aiServiceProvider = Provider<AiService>((ref) => LocalAiService());

abstract class AiService {
  Future<DiagnosisResult> analyzePlantImage({String? imagePath});
  Future<String> answerQuestion(String question);
  Future<String> cropRecommendation();
  Future<String> fertilizerRecommendation();
  Future<String> irrigationSuggestion();
  Future<String> yieldPrediction();
}

class LocalAiService implements AiService {
  @override
  Future<DiagnosisResult> analyzePlantImage({String? imagePath}) async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    return const DiagnosisResult(
      crop: 'Wheat',
      disease: 'Wheat Rust',
      confidence: 0.98,
      severity: 'High Severity',
      symptoms: [
        'Yellow or orange powdery blisters on leaves.',
        'Stunted growth and reduced yield.',
      ],
      causes:
          'Caused by the fungus Puccinia triticina. Thrives in warm, humid conditions with frequent dew.',
      treatments: [
        TreatmentRecommendation(
          title: 'Fungicides',
          description:
              'Apply triazole or strobilurin-based fungicides immediately to halt spread.',
          iconName: 'science',
        ),
        TreatmentRecommendation(
          title: 'Organic Remedies',
          description:
              'Neem oil spray can help suppress early stages, though less effective for severe outbreaks.',
          iconName: 'eco',
        ),
      ],
      prevention: [
        'Use rust-resistant wheat varieties.',
        'Practice crop rotation.',
        'Ensure proper field drainage.',
      ],
    );
  }

  @override
  Future<String> answerQuestion(String question) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (question.trim().isEmpty) {
      return 'Ask about crop health, irrigation, fertilizer timing or market planning.';
    }
    return 'Brakshaa AI suggests monitoring soil moisture for 48 hours and applying targeted nitrogen only if the health score stays below 82%.';
  }

  @override
  Future<String> cropRecommendation() async {
    return 'Wheat remains the best short-term crop for Zone A. Soy can be rotated next season to recover nitrogen balance.';
  }

  @override
  Future<String> fertilizerRecommendation() async {
    return 'Apply 20kg/acre Urea before light rain. Avoid heavy application if rainfall exceeds 25mm.';
  }

  @override
  Future<String> irrigationSuggestion() async {
    return 'Irrigate before 8 AM or after 6 PM to reduce evaporation by up to 20%.';
  }

  @override
  Future<String> yieldPrediction() async {
    return 'Projected wheat yield is 4.8 tons/hectare with the current health score and moisture trend.';
  }
}
