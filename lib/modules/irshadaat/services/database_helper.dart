class IrshadateDbHelper {
  // Define your database methods (e.g., SQLite or Isar)
  Future<void> insertData({
    required String content,
    required String category,
    required String date,
  }) async {
    // Insert data into local DB
  }

  Future<List<Map<String, dynamic>>> getAllData() async {
    // Retrieve data from local DB
    return [];
  }

  Future<void> insertBatchData(List<Map<String, dynamic>> dataList) async {
    // Insert multiple rows of data into the database
    for (var data in dataList) {
      await insertData(
        content: data['content'],
        category: data['category'],
        date: data['date'],
      );
    }
  }
}
