import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/ai/ai_service.dart';
import 'glass_card.dart';
import 'primary_button.dart';

Future<void> showAssistantSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    builder: (context) => const AssistantSheet(),
  );
}

class AssistantSheet extends ConsumerStatefulWidget {
  const AssistantSheet({super.key});

  @override
  ConsumerState<AssistantSheet> createState() => _AssistantSheetState();
}

class _AssistantSheetState extends ConsumerState<AssistantSheet> {
  final _controller = TextEditingController();
  var _answer = 'Ask about disease, irrigation, fertilizer, weather or market timing.';
  var _loading = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _ask() async {
    setState(() => _loading = true);
    final response = await ref.read(aiServiceProvider).answerQuestion(_controller.text);
    if (!mounted) return;
    setState(() {
      _answer = response;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.viewInsetsOf(context).bottom;
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, bottom + 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Brakshaa AI',
            style: theme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Voice-ready assistant interface with local placeholder intelligence.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 20),
          GlassCard(
            padding: const EdgeInsets.all(18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.auto_awesome_rounded, color: theme.colorScheme.primary),
                const SizedBox(width: 12),
                Expanded(child: Text(_answer)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            minLines: 1,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Ask Brakshaa AI...',
              prefixIcon: Icon(Icons.mic_none_rounded),
            ),
            onSubmitted: (_) => _ask(),
          ),
          const SizedBox(height: 14),
          PrimaryButton(
            label: 'Ask AI',
            icon: Icons.send_rounded,
            loading: _loading,
            onPressed: _ask,
          ),
        ],
      ),
    );
  }
}
