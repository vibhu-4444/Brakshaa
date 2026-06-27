import 'package:flutter_riverpod/flutter_riverpod.dart';

final offlineSyncServiceProvider = Provider<OfflineSyncService>(
  (ref) => OfflineSyncService(),
);

class OfflineSyncService {
  OfflineTask createTask(String description) {
    return OfflineTask(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      description: description,
      createdAt: DateTime.now(),
    );
  }

  Future<void> flush(List<OfflineTask> tasks) async {
    await Future<void>.delayed(Duration(milliseconds: 300 + tasks.length * 80));
  }
}

class OfflineSyncState {
  const OfflineSyncState({
    this.pendingItems = const [],
    this.isSyncing = false,
  });

  final List<OfflineTask> pendingItems;
  final bool isSyncing;

  OfflineSyncState copyWith({
    List<OfflineTask>? pendingItems,
    bool? isSyncing,
  }) {
    return OfflineSyncState(
      pendingItems: pendingItems ?? this.pendingItems,
      isSyncing: isSyncing ?? this.isSyncing,
    );
  }
}

class OfflineTask {
  const OfflineTask({
    required this.id,
    required this.description,
    required this.createdAt,
  });

  final String id;
  final String description;
  final DateTime createdAt;
}
