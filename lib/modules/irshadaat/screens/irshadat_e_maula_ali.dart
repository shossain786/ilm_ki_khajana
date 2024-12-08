import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilm_ki_khajana/modules/irshadaat/bloc/irshadate_bloc.dart';
import 'package:ilm_ki_khajana/modules/irshadaat/bloc/irshadate_event.dart';
import 'package:ilm_ki_khajana/modules/irshadaat/bloc/irshadate_state.dart';
import 'package:ilm_ki_khajana/modules/irshadaat/screens/add_irshadate_page.dart';

class IrshadateAliPage extends StatelessWidget {
  const IrshadateAliPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Irshadate Ali"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Trigger the sync event to refresh data
              context.read<IrshadateBloc>().add(SyncIrshadate());
            },
          ),
          IconButton(
            onPressed: () {
              // Navigate to the Add Irshadate Page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddIrshadatePage(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<IrshadateBloc, IrshadateState>(
        builder: (context, state) {
          if (state is IrshadateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is IrshadateLoaded) {
            if (state.irshadate.isEmpty) {
              return const Center(
                child: Text(
                  "No data available. Please refresh to load data.",
                  style: TextStyle(fontSize: 16),
                ),
              );
            }
            return ListView.builder(
              itemCount: state.irshadate.length,
              itemBuilder: (context, index) {
                final item = state.irshadate[index];
                return ListTile(
                  title: Text(item['content'] ?? "No Content"),
                  subtitle: Text(
                    "${item['category'] ?? "Unknown Category"} - ${item['date'] ?? "Unknown Date"}",
                  ),
                );
              },
            );
          } else if (state is IrshadateError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const Center(child: Text("No data available"));
        },
      ),
    );
  }
}
