import 'dart:io';
import 'package:flutter/material.dart';
import 'package:recipe_app/addrecipe.dart';
import 'recipe_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Recipe> _recipes = [];

  void _addRecipe(Recipe recipe) {
    setState(() {
      _recipes.add(recipe);
    });
  }

  void _deleteRecipe(int index) {
    setState(() {
      _recipes.removeAt(index);
    });
  }

  void _showImagesDialog(List<String> images) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text("Recipe Images"),
            content: SizedBox(
              width: double.maxFinite,
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children:
                    images
                        .map(
                          (path) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.file(
                              File(path),
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Close"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      appBar: AppBar(
        title: Text("Recipe Book", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple[300],
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _recipes.length,
        itemBuilder: (context, index) {
          final recipe = _recipes[index];
          return Card(
            color: Colors.deepPurple[100],
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(recipe.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Ingredients: ${recipe.ingredients}"),
                  Text("Method: ${recipe.method}"),
                  if (recipe.imagePaths.isNotEmpty)
                    TextButton.icon(
                      icon: Icon(Icons.image),
                      label: Text("View Images"),
                      onPressed: () => _showImagesDialog(recipe.imagePaths),
                    ),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => _deleteRecipe(index),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddRecipePage(onAdd: _addRecipe)),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
