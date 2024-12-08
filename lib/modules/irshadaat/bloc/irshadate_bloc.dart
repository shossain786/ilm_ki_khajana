import 'package:bloc/bloc.dart';
import 'package:ilm_ki_khajana/modules/irshadaat/services/database_helper.dart';
import 'package:ilm_ki_khajana/modules/irshadaat/services/network_service.dart';

import 'irshadate_event.dart';
import 'irshadate_state.dart';

class IrshadateBloc extends Bloc<IrshadateEvent, IrshadateState> {
  final IrshadateDbHelper dbHelper;
  final NetworkService networkService;

  IrshadateBloc({
    required this.dbHelper,
    required this.networkService,
  }) : super(IrshadateInitial()) {
    // Register event handlers
    on<FetchIrshadate>(_onFetchIrshadate);
    on<AddIrshadateEvent>(_onAddIrshadateEvent);
    on<SyncIrshadate>(_onSyncIrshadate);
  }

  // Handler for FetchIrshadate event
  Future<void> _onFetchIrshadate(
      FetchIrshadate event, Emitter<IrshadateState> emit) async {
    emit(IrshadateLoading());
    try {
      final data = await dbHelper.getAllData(); // Fetch data from DB
      emit(IrshadateLoaded(data)); // Pass the data to the Loaded state
    } catch (e) {
      emit(IrshadateError('Failed to fetch data: ${e.toString()}'));
    }
  }

  // Handler for AddIrshadateEvent
  Future<void> _onAddIrshadateEvent(
      AddIrshadateEvent event, Emitter<IrshadateState> emit) async {
    emit(IrshadateLoading());
    try {
      // Insert the data into the DB
      await dbHelper.insertData(
        content: event.content,
        category: event.category,
        date: event.date,
      );
      // After insertion, fetch the updated data
      final updatedData = await dbHelper.getAllData();
      emit(IrshadateLoaded(updatedData)); // Yield the updated data
    } catch (e) {
      emit(IrshadateError('Failed to add data: ${e.toString()}'));
    }
  }

  // Handler for SyncIrshadate event
  Future<void> _onSyncIrshadate(
      SyncIrshadate event, Emitter<IrshadateState> emit) async {
    emit(IrshadateLoading());
    try {
      // Handle sync logic here (e.g., API call or database sync)
      // Example:
      // final syncData = await networkService.fetchData();
      emit(const IrshadateLoaded([])); // Emit the synced data
    } catch (e) {
      emit(IrshadateError('Failed to sync data: ${e.toString()}'));
    }
  }
}
