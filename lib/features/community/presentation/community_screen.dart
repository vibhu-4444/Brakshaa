import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../models/brakshaa_models.dart';
import '../../../repositories/brakshaa_repository.dart';
import '../../../utils/snackbar.dart';
import '../../../widgets/brakshaa_top_bar.dart';
import '../../../widgets/glass_card.dart';
import '../../../widgets/status_chip.dart';

final communityControllerProvider =
    StateNotifierProvider<CommunityController, List<CommunityPost>>((ref) {
  return CommunityController(ref.watch(brakshaaRepositoryProvider).communityPosts());
});

class CommunityController extends StateNotifier<List<CommunityPost>> {
  CommunityController(super.state);

  void likePost(int index) {
    final posts = [...state];
    posts[index] = posts[index].copyWith(likes: posts[index].likes + 1);
    state = posts;
  }

  void addDemoPost() {
    state = [
      const CommunityPost(
        author: 'Ramesh Kumar',
        meta: 'Just now • Wheat Farmer',
        body:
            'Sharing a field update: moisture is stable after evening irrigation. Watching yellow rust alerts closely.',
        likes: 0,
        comments: 0,
        avatarAsset: 'assets/images/farmer_avatar.png',
      ),
      ...state,
    ];
  }
}

class CommunityScreen extends ConsumerWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final posts = ref.watch(communityControllerProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: BrakshaaTopBar(title: 'Brakshaa 3.0'),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 24, 18, 136),
          children: [
            Text(l10n.t('community'), style: theme.textTheme.headlineLarge?.copyWith(fontSize: 28)),
            const SizedBox(height: 6),
            Text(
              l10n.t('community_subtitle'),
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            GlassCard(
              padding: const EdgeInsets.all(18),
              onTap: ref.read(communityControllerProvider.notifier).addDemoPost,
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 22,
                    backgroundImage: AssetImage('assets/images/farmer_avatar.png'),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      l10n.t('share_update'),
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.08),
                    foregroundColor: theme.colorScheme.primary,
                    child: const Icon(Icons.image_outlined),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 42,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _FilterChip(label: l10n.t('all_posts'), selected: true),
                  _FilterChip(label: l10n.t('expert_advice')),
                  _FilterChip(label: l10n.t('market_trends')),
                  _FilterChip(label: l10n.t('pest_control')),
                ],
              ),
            ),
            const SizedBox(height: 24),
            for (var index = 0; index < posts.length; index++) ...[
              _CommunityPostCard(
                post: posts[index],
                onLike: () => ref.read(communityControllerProvider.notifier).likePost(index),
              ),
              const SizedBox(height: 24),
            ],
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, this.selected = false});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: ChoiceChip(
        selected: selected,
        label: Text(label),
        onSelected: (_) => showBrakshaaSnack(context, '$label selected'),
        labelStyle: theme.textTheme.labelLarge?.copyWith(
          color: selected ? Colors.white : theme.colorScheme.onSurface,
        ),
        selectedColor: theme.colorScheme.primary,
        backgroundColor: theme.colorScheme.surface.withValues(alpha: 0.64),
        shape: StadiumBorder(
          side: BorderSide(
            color: selected ? theme.colorScheme.primary : theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }
}

class _CommunityPostCard extends StatelessWidget {
  const _CommunityPostCard({
    required this.post,
    required this.onLike,
  });

  final CommunityPost post;
  final VoidCallback onLike;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GlassCard(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _PostAvatar(post: post),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(post.author, style: theme.textTheme.titleMedium),
                    Text(
                      post.meta,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'More',
                onPressed: () => showBrakshaaSnack(context, 'Post menu opened.'),
                icon: const Icon(Icons.more_horiz_rounded),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(post.body, style: theme.textTheme.bodyLarge?.copyWith(height: 1.45)),
          if (post.imageAsset != null) ...[
            const SizedBox(height: 18),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(
                    post.imageAsset!,
                    width: double.infinity,
                    height: 236,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 12,
                  bottom: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.56),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.psychology_outlined, color: Colors.white, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          'AI SCANNED',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
          if (post.pollOptions.isNotEmpty) ...[
            const SizedBox(height: 18),
            for (final option in post.pollOptions) ...[
              _PollBar(option: option),
              const SizedBox(height: 10),
            ],
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '142 VOTES',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
          const SizedBox(height: 18),
          Divider(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.24)),
          Row(
            children: [
              _PostAction(
                icon: Icons.thumb_up_alt_outlined,
                label: '${post.likes}',
                onTap: onLike,
              ),
              _PostAction(
                icon: Icons.chat_bubble_outline_rounded,
                label: '${post.comments}',
                onTap: () => showBrakshaaSnack(context, 'Comments opened.'),
              ),
              const Spacer(),
              IconButton(
                tooltip: 'Share',
                onPressed: () => showBrakshaaSnack(context, 'Share link copied.'),
                icon: const Icon(Icons.share_outlined),
              ),
            ],
          ),
          if (post.expertReply != null) ...[
            const SizedBox(height: 16),
            _ExpertReplyCard(reply: post.expertReply!),
          ],
        ],
      ),
    );
  }
}

class _PostAvatar extends StatelessWidget {
  const _PostAvatar({required this.post});

  final CommunityPost post;

  @override
  Widget build(BuildContext context) {
    if (post.avatarAsset != null) {
      return CircleAvatar(radius: 22, backgroundImage: AssetImage(post.avatarAsset!));
    }
    return CircleAvatar(
      radius: 22,
      backgroundColor: BrakshaaColors.primaryFixed.withValues(alpha: 0.56),
      foregroundColor: BrakshaaColors.primary,
      child: Text(post.author.substring(0, 1)),
    );
  }
}

class _PollBar extends StatelessWidget {
  const _PollBar({required this.option});

  final PollOption option;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.28)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            FractionallySizedBox(
              widthFactor: option.percent / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      option.title,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelLarge,
                    ),
                  ),
                  Text(
                    '${option.percent}%',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w900,
                    ),
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

class _PostAction extends StatelessWidget {
  const _PostAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(label),
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}

class _ExpertReplyCard extends StatelessWidget {
  const _ExpertReplyCard({required this.reply});

  final ExpertReply reply;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.045),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.22)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.verified_outlined, color: theme.colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(reply.name, style: theme.textTheme.titleMedium),
                    StatusChip(label: reply.role, compact: true),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  reply.message,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
