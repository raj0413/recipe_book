class Recipe {
  String name;
  String ingredients;
  String method;
  List<String> imagePaths; // Local image file paths

  Recipe({
    required this.name,
    required this.ingredients,
    required this.method,
    required this.imagePaths,
  });
}
