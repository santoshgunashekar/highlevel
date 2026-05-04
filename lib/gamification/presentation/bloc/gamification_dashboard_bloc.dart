import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlevel/gamification/domain/gamification_dashboard_event_applier.dart';
import 'package:highlevel/gamification/domain/model/gamification_event.dart';
import 'package:highlevel/gamification/domain/use_case/load_gamification_dashboard_use_case.dart';
import 'package:highlevel/gamification/domain/use_case/record_gamification_event_use_case.dart';
import 'package:highlevel/gamification/presentation/bloc/gamification_dashboard_event.dart';
import 'package:highlevel/gamification/presentation/bloc/gamification_dashboard_state.dart';

final class GamificationDashboardBloc extends Bloc<GamificationDashboardEvent, GamificationDashboardState> {
  GamificationDashboardBloc({
    required LoadGamificationDashboardUseCase loadDashboard,
    required RecordGamificationEventUseCase recordEvent,
    required GamificationDashboardEventApplier dashboardEventApplier,
    required String userId,
  })  : _loadDashboard = loadDashboard,
        _recordEvent = recordEvent,
        _dashboardEventApplier = dashboardEventApplier,
        _userId = userId,
        super(const GamificationDashboardInitial()) {
    on<GamificationDashboardLoadRequested>(_onLoadRequested);
    on<GamificationDashboardMockEventTriggered>(_onMockEvent);
  }

  final LoadGamificationDashboardUseCase _loadDashboard;
  final RecordGamificationEventUseCase _recordEvent;
  final GamificationDashboardEventApplier _dashboardEventApplier;
  final String _userId;

  Future<void> _onLoadRequested(
    GamificationDashboardLoadRequested event,
    Emitter<GamificationDashboardState> emit,
  ) async {
    emit(const GamificationDashboardLoading());
    try {
      final dashboard = await _loadDashboard(_userId);
      emit(GamificationDashboardReady(dashboard: dashboard));
    } catch (e, st) {
      assert(() {
        debugPrint('$e\n$st');
        return true;
      }());
      emit(GamificationDashboardFailure(e));
    }
  }

  Future<void> _onMockEvent(
    GamificationDashboardMockEventTriggered event,
    Emitter<GamificationDashboardState> emit,
  ) async {
    final current = state;
    if (current is! GamificationDashboardReady) {
      return;
    }
    final snapshot = current.dashboard;
    try {
      final id = '${DateTime.now().microsecondsSinceEpoch}-${event.type.name}';
      final gamificationEvent = GamificationEvent(
        id: id,
        type: event.type,
        createdAt: DateTime.now(),
      );

      final optimistic = _dashboardEventApplier.apply(
        dashboard: snapshot,
        event: gamificationEvent,
      );
      emit(
        GamificationDashboardReady(
          dashboard: optimistic,
          lastRecordWasDuplicate: false,
        ),
      );

      final result = await _recordEvent(
        userId: _userId,
        event: gamificationEvent,
        optimisticDashboard: optimistic,
      );

      if (result.wasDuplicate) {
        emit(
          GamificationDashboardReady(
            dashboard: snapshot,
            lastRecordWasDuplicate: true,
          ),
        );
      } else {
        emit(
          GamificationDashboardReady(
            dashboard: result.dashboard,
            lastRecordWasDuplicate: false,
          ),
        );
      }
    } catch (e, st) {
      assert(() {
        debugPrint('$e\n$st');
        return true;
      }());
      emit(
        GamificationDashboardReady(
          dashboard: snapshot,
          lastRecordWasDuplicate: false,
        ),
      );
    }
  }
}
