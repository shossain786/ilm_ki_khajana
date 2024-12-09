// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilm_ki_khajana/modules/irshadaat/bloc/irshadate_bloc.dart';
import 'package:ilm_ki_khajana/modules/irshadaat/bloc/irshadate_event.dart';

class AddIrshadatePage extends StatefulWidget {
  const AddIrshadatePage({super.key});

  @override
  _AddIrshadatePageState createState() => _AddIrshadatePageState();
}

class _AddIrshadatePageState extends State<AddIrshadatePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Irshadate"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Content Field
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: "Content",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter content";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              // Category Field
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(
                  labelText: "Category",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter category";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Collect data from the form
                    final content = _contentController.text;
                    final category = _categoryController.text;

                    // Dispatch event to add new Irshadate data
                    context.read<IrshadateBloc>().add(
                          AddIrshadateEvent(
                            content: content,
                            category: category,
                            date:
                                "", // Date is handled automatically on the server
                          ),
                        );

                    // Clear fields after submission
                    _contentController.clear();
                    _categoryController.clear();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Data added successfully!")),
                    );
                  }
                },
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _contentController.dispose();
    _categoryController.dispose();
    super.dispose();
  }
}
