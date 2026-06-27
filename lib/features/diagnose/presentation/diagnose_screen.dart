import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../models/brakshaa_models.dart';
import '../../../services/ai/ai_service.dart';
import '../../../services/camera/camera_service.dart';
import '../../../utils/snackbar.dart';
import '../../../widgets/assistant_sheet.dart';
import '../../../widgets/brakshaa_top_bar.dart';
import '../../../widgets/glass_card.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/status_chip.dart';

final diagnosisControllerProvider =
    StateNotifierProvider<DiagnosisController, DiagnosisState>(
  (ref) => DiagnosisController(
    aiService: ref.watch(aiServiceProvider),
    cameraService: ref.watch(cameraServiceProvider),
  ),
);

class DiagnosisController extends StateNotifier<DiagnosisState> {
  DiagnosisController({
    required AiService aiService,
    required CameraService cameraService,
  })  : _aiService = aiService,
        _cameraService = cameraService,
        super(const DiagnosisState());

  final AiService _aiService;
  final CameraService _cameraService;

  Future<void> capture() async {
    final photo = await _cameraService.capturePhoto();
    if (photo == null) return;
    final compressed = await _cameraService.compressForUpload(photo);
    state = state.copyWith(selectedImage: compressed, analyzed: false);
  }

  Future<void> pickFromGallery() async {
    final file = await _cameraService.pickFromGallery();
    if (file == null) return;
    final compressed = await _cameraService.compressForUpload(file);
    state = state.copyWith(selectedImage: compressed, analyzed: false);
  }

  Future<void> analyze() async {
    state = state.copyWith(isAnalyzing: true);
    final result = await _aiService.analyzePlantImage(
      imagePath: state.selectedImage?.path,
    );
    state = state.copyWith(
      isAnalyzing: false,
      analyzed: true,
      result: result,
    );
  }

  void resetImage() {
    state = state.copyWith(clearSelectedImage: true, analyzed: false);
  }
}

class DiagnosisState {
  const DiagnosisState({
    this.selectedImage,
    this.result,
    this.isAnalyzing = false,
    this.analyzed = false,
  });

  final XFile? selectedImage;
  final DiagnosisResult? result;
  final bool isAnalyzing;
  final bool analyzed;

  DiagnosisState copyWith({
    XFile? selectedImage,
    DiagnosisResult? result,
    bool? isAnalyzing,
    bool? analyzed,
    bool clearSelectedImage = false,
  }) {
    return DiagnosisState(
      selectedImage: clearSelectedImage ? null : selectedImage ?? this.selectedImage,
      result: result ?? this.result,
      isAnalyzing: isAnalyzing ?? this.isAnalyzing,
      analyzed: analyzed ?? this.analyzed,
    );
  }
}

class DiagnoseScreen extends ConsumerWidget {
  const DiagnoseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(diagnosisControllerProvider);
    final controller = ref.read(diagnosisControllerProvider.notifier);
    final theme = Theme.of(context);
    final result = state.result;

    return Scaffold(
      appBar: BrakshaaTopBar(
        title: 'Brakshaa 3.0',
        showBack: true,
        onBack: () => context.go('/home'),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 136),
          children: [
            Text(
              l10n.t('plant_disease_detection'),
              style: theme.textTheme.headlineMedium?.copyWith(fontSize: 23),
            ),
            const SizedBox(height: 6),
            Text(
              l10n.t('diagnose_intro'),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 22),
            GlassCard(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(
                      'assets/images/diagnose_leaf_hero.png',
                      height: 164,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.t('ai_disease_scanner'),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.t('ai_disease_copy'),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface.withValues(alpha: 0.48),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: theme.colorScheme.primary.withValues(alpha: 0.35),
                  width: 1.4,
                  strokeAlign: BorderSide.strokeAlignInside,
                ),
              ),
              child: Column(
                children: [
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      SizedBox(
                        width: 136,
                        child: PrimaryButton(
                          label: l10n.t('capture_photo'),
                          icon: Icons.camera_alt_outlined,
                          onPressed: controller.capture,
                        ),
                      ),
                      SizedBox(
                        width: 136,
                        child: PrimaryButton(
                          label: l10n.t('upload_gallery'),
                          icon: Icons.image_outlined,
                          outlined: true,
                          onPressed: controller.pickFromGallery,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    state.selectedImage?.name ?? l10n.t('supported_formats'),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            GlassCard(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.asset(
                          'assets/images/diagnose_wheat_rust.png',
                          width: double.infinity,
                          height: 240,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        right: 12,
                        bottom: 12,
                        child: Row(
                          children: [
                            _OverlayIconButton(
                              icon: Icons.refresh_rounded,
                              onPressed: controller.resetImage,
                            ),
                            const SizedBox(width: 8),
                            _OverlayIconButton(
                              icon: Icons.edit_rounded,
                              onPressed: () => showBrakshaaSnack(context, 'Crop editor ready for native integration.'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  PrimaryButton(
                    label: l10n.t('analyze_image'),
                    icon: Icons.auto_awesome_rounded,
                    loading: state.isAnalyzing,
                    onPressed: controller.analyze,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 26),
            Text(
              l10n.t('analysis_results'),
              style: theme.textTheme.headlineMedium?.copyWith(fontSize: 21),
            ),
            const SizedBox(height: 16),
            _DiagnosisSummary(result: result),
            const SizedBox(height: 16),
            _SymptomsCard(result: result),
            const SizedBox(height: 14),
            _CauseCard(result: result),
            const SizedBox(height: 14),
            _TreatmentCard(result: result),
            const SizedBox(height: 14),
            _PreventionCard(result: result),
            const SizedBox(height: 20),
            PrimaryButton(
              label: l10n.t('download_report'),
              icon: Icons.picture_as_pdf_outlined,
              outlined: true,
              onPressed: () => showBrakshaaSnack(context, 'PDF report generated locally.'),
            ),
            const SizedBox(height: 16),
            GlassCard(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  Text(l10n.t('need_more_help'), style: theme.textTheme.titleLarge),
                  const SizedBox(height: 6),
                  Text(
                    'Get personalized advice from our AI Agronomist.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 14),
                  PrimaryButton(
                    label: l10n.t('ask_ai'),
                    icon: Icons.smart_toy_outlined,
                    outlined: true,
                    onPressed: () => showAssistantSheet(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OverlayIconButton extends StatelessWidget {
  const _OverlayIconButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      style: IconButton.styleFrom(
        backgroundColor: Colors.black.withValues(alpha: 0.32),
        foregroundColor: Colors.white,
      ),
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
    );
  }
}

class _DiagnosisSummary extends StatelessWidget {
  const _DiagnosisSummary({required this.result});

  final DiagnosisResult? result;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final diagnosis = result ?? _fallbackDiagnosis;

    return GlassCard(
      borderColor: theme.colorScheme.error.withValues(alpha: 0.36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.t('diagnosis').toUpperCase(),
            style: theme.textTheme.labelSmall?.copyWith(letterSpacing: 1.4),
          ),
          const SizedBox(height: 8),
          Text(
            diagnosis.disease,
            style: theme.textTheme.headlineMedium?.copyWith(fontSize: 22),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              StatusChip(label: l10n.t('confidence'), icon: Icons.verified_outlined),
              StatusChip(
                label: l10n.t('severity'),
                icon: Icons.circle,
                color: theme.colorScheme.error,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

const _fallbackDiagnosis = DiagnosisResult(
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
      description: 'Apply triazole or strobilurin-based fungicides immediately to halt spread.',
      iconName: 'science',
    ),
    TreatmentRecommendation(
      title: 'Organic Remedies',
      description: 'Neem oil spray can help suppress early stages, though less effective for severe outbreaks.',
      iconName: 'eco',
    ),
  ],
  prevention: [
    'Use rust-resistant wheat varieties.',
    'Practice crop rotation.',
    'Ensure proper field drainage.',
  ],
);

class _SymptomsCard extends ConsumerWidget {
  const _SymptomsCard({required this.result});

  final DiagnosisResult? result;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final symptoms = result?.symptoms ??
        const [
          'Yellow or orange powdery blisters on leaves.',
          'Stunted growth and reduced yield.',
        ];
    return _ListCard(
      icon: Icons.coronavirus_outlined,
      title: l10n.t('symptoms'),
      items: symptoms,
    );
  }
}

class _CauseCard extends ConsumerWidget {
  const _CauseCard({required this.result});

  final DiagnosisResult? result;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: _TitleBody(
        icon: Icons.science_outlined,
        title: l10n.t('causes'),
        body: result?.causes ??
            'Caused by the fungus Puccinia triticina. Thrives in warm, humid conditions with frequent dew.',
      ),
    );
  }
}

class _TreatmentCard extends ConsumerWidget {
  const _TreatmentCard({required this.result});

  final DiagnosisResult? result;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final items = result?.treatments ??
        const [
          TreatmentRecommendation(
            title: 'Fungicides',
            description: 'Apply triazole or strobilurin-based fungicides immediately to halt spread.',
            iconName: 'science',
          ),
          TreatmentRecommendation(
            title: 'Organic Remedies',
            description: 'Neem oil spray can help suppress early stages, though less effective for severe outbreaks.',
            iconName: 'eco',
          ),
        ];

    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(icon: Icons.medical_services_outlined, title: l10n.t('treatment')),
          const SizedBox(height: 14),
          for (final item in items) ...[
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.42),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.22)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.12),
                    foregroundColor: theme.colorScheme.primary,
                    child: Icon(item.iconName == 'eco' ? Icons.eco_outlined : Icons.vaccines_outlined),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.title, style: theme.textTheme.labelLarge),
                        const SizedBox(height: 4),
                        Text(item.description, style: theme.textTheme.bodySmall),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (item != items.last) const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _PreventionCard extends ConsumerWidget {
  const _PreventionCard({required this.result});

  final DiagnosisResult? result;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final prevention = result?.prevention ??
        const [
          'Use rust-resistant wheat varieties.',
          'Practice crop rotation.',
          'Ensure proper field drainage.',
        ];
    return _ListCard(
      icon: Icons.shield_outlined,
      title: l10n.t('prevention'),
      items: prevention,
      check: true,
    );
  }
}

class _ListCard extends StatelessWidget {
  const _ListCard({
    required this.icon,
    required this.title,
    required this.items,
    this.check = false,
  });

  final IconData icon;
  final String title;
  final List<String> items;
  final bool check;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(icon: icon, title: title),
          const SizedBox(height: 12),
          for (final item in items) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  check ? Icons.check_circle_outline : Icons.circle_outlined,
                  size: check ? 18 : 11,
                  color: check ? theme.colorScheme.primary : theme.colorScheme.outline,
                ),
                const SizedBox(width: 8),
                Expanded(child: Text(item, style: theme.textTheme.bodySmall)),
              ],
            ),
            if (item != items.last) const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

class _TitleBody extends StatelessWidget {
  const _TitleBody({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CardTitle(icon: icon, title: title),
        const SizedBox(height: 12),
        Text(
          body,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _CardTitle extends StatelessWidget {
  const _CardTitle({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, color: theme.colorScheme.primary, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
        ),
      ],
    );
  }
}
