import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'recipe_model.dart';

class AddRecipePage extends StatefulWidget {
  final Function(Recipe) onAdd;

  AddRecipePage({required this.onAdd});

  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final _nameController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _methodController = TextEditingController();
  List<XFile> _images = [];

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImages() async {
    if (_images.length >= 5) return;

    final picked = await _picker.pickMultiImage();
    if (picked != null && picked.length + _images.length <= 5) {
      setState(() {
        _images.addAll(picked);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("You can only select up to 5 images."),
      ));
    }
  }

  void _saveRecipe() {
    final recipe = Recipe(
      name: _nameController.text,
      ingredients: _ingredientsController.text,
      method: _methodController.text,
      imagePaths: _images.map((img) => img.path).toList(),
    );
    widget.onAdd(recipe);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      appBar: AppBar(title: Text("Add Recipe", style: TextStyle(color: Colors.white),),centerTitle: true,backgroundColor: Colors.deepPurple[300],),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(controller: _nameController, decoration: InputDecoration(labelText: "Recipe Name")),
            TextField(controller: _ingredientsController, decoration: InputDecoration(labelText: "Ingredients")),
            TextField(controller: _methodController, decoration: InputDecoration(labelText: "Method")),
            SizedBox(height: 10),
            ElevatedButton.icon(
              icon: Icon(Icons.image),
              label: Text("Pick Images (${_images.length}/5)"),
              onPressed: _pickImages,
            ),
            Wrap(
              children: _images.map((img) => Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.file(File(img.path), height: 60, width: 60, fit: BoxFit.cover),
              )).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _saveRecipe, child: Text("Save Recipe")),
          ],
        ),
      ),
    );
  }
}
