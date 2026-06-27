class FarmerProfile {
  const FarmerProfile({
    required this.name,
    required this.email,
    required this.phone,
    required this.farmName,
    required this.farmSize,
    required this.crops,
    required this.location,
    required this.soilType,
  });

  final String name;
  final String email;
  final String phone;
  final String farmName;
  final String farmSize;
  final List<String> crops;
  final String location;
  final String soilType;
}

class WeatherInsight {
  const WeatherInsight({
    required this.temperature,
    required this.low,
    required this.description,
  });

  final String temperature;
  final String low;
  final String description;
}

class SoilStatus {
  const SoilStatus({
    required this.moisture,
    required this.zone,
    required this.status,
  });

  final int moisture;
  final String zone;
  final String status;
}

class MarketPrice {
  const MarketPrice({
    required this.crop,
    required this.price,
    required this.delta,
    required this.up,
  });

  final String crop;
  final String price;
  final String delta;
  final bool up;
}

class DashboardSnapshot {
  const DashboardSnapshot({
    required this.weather,
    required this.soil,
    required this.marketPrices,
  });

  final WeatherInsight weather;
  final SoilStatus soil;
  final List<MarketPrice> marketPrices;
}

class DiagnosisResult {
  const DiagnosisResult({
    required this.crop,
    required this.disease,
    required this.confidence,
    required this.severity,
    required this.symptoms,
    required this.causes,
    required this.treatments,
    required this.prevention,
  });

  final String crop;
  final String disease;
  final double confidence;
  final String severity;
  final List<String> symptoms;
  final String causes;
  final List<TreatmentRecommendation> treatments;
  final List<String> prevention;
}

class TreatmentRecommendation {
  const TreatmentRecommendation({
    required this.title,
    required this.description,
    required this.iconName,
  });

  final String title;
  final String description;
  final String iconName;
}

class CommunityPost {
  const CommunityPost({
    required this.author,
    required this.meta,
    required this.body,
    required this.likes,
    required this.comments,
    this.imageAsset,
    this.avatarAsset,
    this.expertReply,
    this.pollOptions = const [],
  });

  final String author;
  final String meta;
  final String body;
  final int likes;
  final int comments;
  final String? imageAsset;
  final String? avatarAsset;
  final ExpertReply? expertReply;
  final List<PollOption> pollOptions;

  CommunityPost copyWith({int? likes, int? comments}) {
    return CommunityPost(
      author: author,
      meta: meta,
      body: body,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      imageAsset: imageAsset,
      avatarAsset: avatarAsset,
      expertReply: expertReply,
      pollOptions: pollOptions,
    );
  }
}

class ExpertReply {
  const ExpertReply({
    required this.name,
    required this.role,
    required this.message,
  });

  final String name;
  final String role;
  final String message;
}

class PollOption {
  const PollOption({
    required this.title,
    required this.percent,
  });

  final String title;
  final int percent;
}

class FinanceSummary {
  const FinanceSummary({
    required this.netBalance,
    required this.income,
    required this.expenses,
    required this.monthly,
    required this.transactions,
  });

  final String netBalance;
  final String income;
  final String expenses;
  final List<MonthlyFinance> monthly;
  final List<FinanceTransaction> transactions;
}

class MonthlyFinance {
  const MonthlyFinance({
    required this.month,
    required this.income,
    required this.expenses,
  });

  final String month;
  final double income;
  final double expenses;
}

class FinanceTransaction {
  const FinanceTransaction({
    required this.title,
    required this.time,
    required this.amount,
    required this.category,
    required this.positive,
  });

  final String title;
  final String time;
  final String amount;
  final String category;
  final bool positive;
}
