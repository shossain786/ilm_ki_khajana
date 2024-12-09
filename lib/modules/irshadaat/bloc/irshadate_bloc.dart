import 'package:bloc/bloc.dart';
import 'package:ilm_ki_khajana/modules/irshadaat/services/network_service.dart';
import 'irshadate_event.dart';
import 'irshadate_state.dart';

class IrshadateBloc extends Bloc<IrshadateEvent, IrshadateState> {
  final NetworkService networkService;

  IrshadateBloc({
    required this.networkService,
  }) : super(IrshadateInitial()) {
    // Register event handlers
    on<FetchIrshadate>(_onFetchIrshadate);
    on<SyncIrshadate>(_onSyncIrshadate);
  }
  Future<void> _onFetchIrshadate(
      FetchIrshadate event, Emitter<IrshadateState> emit) async {
    emit(IrshadateLoading());
    try {
      final data = await networkService.fetchData(); // Fetch data from API
      emit(IrshadateLoaded(data)); // Pass the fetched data to the Loaded state
    } catch (e) {
      emit(IrshadateError('Failed to fetch data from API: ${e.toString()}'));
    }
  }

  Future<void> _onSyncIrshadate(
      SyncIrshadate event, Emitter<IrshadateState> emit) async {
    emit(IrshadateLoading());
    try {
      final data = await networkService.fetchData(); // Fetch data from API
      emit(IrshadateLoaded(data)); // Emit the synced data
    } catch (e) {
      emit(IrshadateError('Failed to sync data from API: ${e.toString()}'));
    }
  }
}
