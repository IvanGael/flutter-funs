
import 'package:flutter/material.dart';


class RecipeListScreen extends StatelessWidget {
  final List<String> recipes = ['Spaghetti Carbonara', 'Chicken Alfredo', 'Margherita Pizza'];

  RecipeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipes'),
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 8, right: 5, left: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white24)
            ),
            child: ListTile(
              title: Text(recipes[index]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecipeOrderScreen(recipeName: recipes[index])),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class RecipeOrderScreen extends StatelessWidget {
  final String recipeName;

  const RecipeOrderScreen({Key? key, required this.recipeName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipeName),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 250,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/spaghetti-carbonara.jpg'),
                  fit: BoxFit.contain,
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RecipeDetailWidget(
                    icon: Icons.timer,
                    label: 'Prep Time',
                    value: '15 mins',
                  ),
                  RecipeDetailWidget(
                    icon: Icons.restaurant,
                    label: 'Cook Time',
                    value: '20 mins',
                  ),
                  RecipeDetailWidget(
                    icon: Icons.local_dining,
                    label: 'Serving Size',
                    value: '4 servings',
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Ingredients',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  RecipeIngredientsWidget(),
                  SizedBox(height: 16),
                  Text(
                    'Instructions',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  RecipeInstructionsWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecipeDetailWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const RecipeDetailWidget({Key? key, required this.icon, required this.label, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(value, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ],
    );
  }
}

class RecipeIngredientsWidget extends StatelessWidget {
  const RecipeIngredientsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RecipeIngredientItemWidget(name: '400g spaghetti'),
        RecipeIngredientItemWidget(name: '150g pancetta'),
        RecipeIngredientItemWidget(name: '2 large eggs'),
        RecipeIngredientItemWidget(name: '50g Pecorino cheese'),
        RecipeIngredientItemWidget(name: 'Salt and black pepper to taste'),
      ],
    );
  }
}

class RecipeIngredientItemWidget extends StatelessWidget {
  final String name;

  const RecipeIngredientItemWidget({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.check, color: Colors.greenAccent),
          const SizedBox(width: 8),
          Text(name, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

class RecipeInstructionsWidget extends StatelessWidget {
  const RecipeInstructionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RecipeInstructionStepWidget(stepNumber: '1', instruction: 'Cook spaghetti according to package instructions.'),
        RecipeInstructionStepWidget(stepNumber: '2', instruction: 'In a pan, cook pancetta until crispy.'),
        RecipeInstructionStepWidget(stepNumber: '3', instruction: 'In a bowl, whisk together eggs and Pecorino cheese.'),
        RecipeInstructionStepWidget(stepNumber: '4', instruction: 'Drain spaghetti and mix with egg mixture.'),
        RecipeInstructionStepWidget(stepNumber: '5', instruction: 'Add cooked pancetta and season with salt and pepper.'),
      ],
    );
  }
}

class RecipeInstructionStepWidget extends StatelessWidget {
  final String stepNumber;
  final String instruction;

  const RecipeInstructionStepWidget({Key? key, required this.stepNumber, required this.instruction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            child: Center(
              child: Text(stepNumber, style: const TextStyle(color: Colors.white)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(instruction, style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}