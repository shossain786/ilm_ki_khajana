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
    on<FetchIrshadate>(_onFetchIrshadate);
    on<AddIrshadateEvent>(_onAddIrshadateEvent);
    on<SyncIrshadate>(_onSyncIrshadate);
  }

  Future<void> _onFetchIrshadate(
      FetchIrshadate event, Emitter<IrshadateState> emit) async {
    emit(IrshadateLoading());
    try {
      final data = await dbHelper.getAllData(); // Fetch from local DB
      emit(IrshadateLoaded(data));
    } catch (e) {
      emit(IrshadateError('Failed to fetch data: ${e.toString()}'));
    }
  }

  Future<void> _onAddIrshadateEvent(
      AddIrshadateEvent event, Emitter<IrshadateState> emit) async {
    emit(IrshadateLoading());
    try {
      // Insert data locally
      await dbHelper.insertData(
        content: event.content,
        category: event.category,
        date: DateTime.now().toString(),
      );

      // Fetch updated data
      final updatedData = await dbHelper.getAllData();
      emit(IrshadateLoaded(updatedData));
    } catch (e) {
      emit(IrshadateError('Failed to add data: ${e.toString()}'));
    }
  }

  Future<void> _onSyncIrshadate(
      SyncIrshadate event, Emitter<IrshadateState> emit) async {
    emit(IrshadateLoading());
    try {
      final apiData = await networkService.fetchData();
      await dbHelper.insertBatchData(apiData); // Save API data to local DB

      final localData = await dbHelper.getAllData(); // Get updated data
      emit(IrshadateLoaded(localData));
    } catch (e) {
      emit(IrshadateError('Failed to sync data: ${e.toString()}'));
    }
  }
}
