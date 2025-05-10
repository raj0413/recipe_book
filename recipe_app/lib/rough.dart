// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:share/share.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Hive.initFlutter();
//   await Hive.openBox('recipes');
//   runApp(RecipeBookApp());
// }

// class RecipeBookApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(primarySwatch: Colors.orange),
//       home: SplashScreen(),
//     );
//   }
// }

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration(seconds: 2), () {
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (context) => HomeScreen()));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text('Recipe Book', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//       ),
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final _recipeBox = Hive.box('recipes');
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Recipe Book')),
//       body: ValueListenableBuilder(
//         valueListenable: _recipeBox.listenable(),
//         builder: (context, box, _) {
//           if (box.isEmpty) return Center(child: Text('No recipes added.'));
//           return ListView.builder(
//             itemCount: box.length,
//             itemBuilder: (context, index) {
//               final recipe = box.getAt(index);
//               return ListTile(
//                 title: Text(recipe['title']),
//                 subtitle: Text(recipe['ingredients']),
//                 trailing: IconButton(
//                   icon: Icon(Icons.share),
//                   onPressed: () async {
//                     final pdf = pw.Document();
//                     pdf.addPage(
//                       pw.Page(
//                         build: (pw.Context context) => pw.Center(
//                           child: pw.Text('Recipe: ${recipe['title']}\n\nIngredients: ${recipe['ingredients']}\n\nMethod: ${recipe['method']}'),
//                         ),
//                       ),
//                     );
//                     final dir = await getApplicationDocumentsDirectory();
//                     final file = File('${dir.path}/recipe.pdf');
//                     await file.writeAsBytes(await pdf.save());
//                     Share.shareFiles([file.path], text: 'Sharing Recipe: ${recipe['title']}');
//                   },
//                 ),
//                 onTap: () {},
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => AddRecipeScreen()),
//           );
//         },
//       ),
//     );
//   }
// }

// class AddRecipeScreen extends StatelessWidget {
//   final titleController = TextEditingController();
//   final ingredientsController = TextEditingController();
//   final methodController = TextEditingController();
//   final _recipeBox = Hive.box('recipes');

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Add Recipe')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(controller: titleController, decoration: InputDecoration(labelText: 'Title')),
//             TextField(controller: ingredientsController, decoration: InputDecoration(labelText: 'Ingredients')),
//             TextField(controller: methodController, decoration: InputDecoration(labelText: 'Method')),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 final recipe = {
//                   'title': titleController.text,
//                   'ingredients': ingredientsController.text,
//                   'method': methodController.text,
//                 };
//                 _recipeBox.add(recipe);
//                 Navigator.pop(context);
//               },
//               child: Text('Save Recipe'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
