import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/brakshaa_models.dart';

final brakshaaRepositoryProvider = Provider<BrakshaaRepository>(
  (ref) => LocalBrakshaaRepository(),
);

abstract class BrakshaaRepository {
  DashboardSnapshot dashboard();
  FarmerProfile profile();
  List<CommunityPost> communityPosts();
  FinanceSummary financeSummary();
}

class LocalBrakshaaRepository implements BrakshaaRepository {
  @override
  DashboardSnapshot dashboard() {
    return const DashboardSnapshot(
      weather: WeatherInsight(
        temperature: '28°C',
        low: '22°C',
        description:
            'Partly cloudy with a 20% chance of rain in the evening. Optimal conditions for spraying.',
      ),
      soil: SoilStatus(moisture: 64, zone: 'Zone A (Wheat)', status: 'Optimal'),
      marketPrices: [
        MarketPrice(crop: 'Wheat', price: '₹2,125', delta: '1.2%', up: true),
        MarketPrice(crop: 'Basmati Rice', price: '₹4,500', delta: '0.5%', up: false),
      ],
    );
  }

  @override
  FarmerProfile profile() {
    return const FarmerProfile(
      name: 'Ramesh Kumar',
      email: 'ramesh.k@agrotech.in',
      phone: '+91 98765 43210',
      farmName: 'Green Acres',
      farmSize: '12.5 Hectares',
      crops: ['Wheat', 'Soy'],
      location: 'Punjab, India',
      soilType: 'Loamy',
    );
  }

  @override
  List<CommunityPost> communityPosts() {
    return const [
      CommunityPost(
        author: 'Rajesh Kumar',
        meta: '2 hours ago • Wheat Farmer',
        body:
            'Noticing slight yellowing on the tips of my wheat crop in sector 4. Soil moisture looks fine on the dashboard. Could this be a nitrogen deficiency starting early?',
        likes: 24,
        comments: 3,
        imageAsset: 'assets/images/community_wheat.png',
        avatarAsset: 'assets/images/farmer_avatar_alt.png',
        expertReply: ExpertReply(
          name: 'Dr. Sharma',
          role: 'Agronomist',
          message:
              'Given the recent temperature drop, this might be temporary cold stress rather than nitrogen deficiency. Keep monitoring via the AI health score for the next 48h before applying fertilizers.',
        ),
      ),
      CommunityPost(
        author: 'Anita Patel',
        meta: '5 hours ago • Organic Vegetables',
        body:
            "What organic pesticide alternative is everyone finding most effective against aphids this season? Neem oil isn't quite doing it for my tomatoes.",
        likes: 12,
        comments: 8,
        pollOptions: [
          PollOption(title: 'Pyrethrin spray', percent: 65),
          PollOption(title: 'Soap solutions', percent: 20),
          PollOption(title: 'Ladybugs (Biological)', percent: 15),
        ],
      ),
    ];
  }

  @override
  FinanceSummary financeSummary() {
    return const FinanceSummary(
      netBalance: r'$14,250',
      income: r'$22,400',
      expenses: r'$8,150',
      monthly: [
        MonthlyFinance(month: 'JAN', income: 0.42, expenses: 0.68),
        MonthlyFinance(month: 'FEB', income: 0.38, expenses: 0.54),
        MonthlyFinance(month: 'MAR', income: 0.42, expenses: 0.82),
        MonthlyFinance(month: 'APR', income: 0.55, expenses: 0.66),
        MonthlyFinance(month: 'MAY', income: 0.42, expenses: 0.98),
        MonthlyFinance(month: 'JUN', income: 0.58, expenses: 0.50),
      ],
      transactions: [
        FinanceTransaction(
          title: 'Premium Fertilizer',
          time: 'Today, 10:45 AM',
          amount: r'-$450.00',
          category: 'Supplies',
          positive: false,
        ),
        FinanceTransaction(
          title: 'Crop Yield Sale',
          time: 'Yesterday, 2:15 PM',
          amount: r'+$3,200.00',
          category: 'Market',
          positive: true,
        ),
        FinanceTransaction(
          title: 'Harvest Labor',
          time: 'Oct 12, 2023',
          amount: r'-$1,250.00',
          category: 'Labor',
          positive: false,
        ),
      ],
    );
  }
}
