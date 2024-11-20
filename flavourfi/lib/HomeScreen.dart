import 'package:flutter/material.dart';

// Home Screen
class HomeScreen extends StatefulWidget {
  final List<String> selectedDiets;

  const HomeScreen({Key? key, required this.selectedDiets}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> mealTypes = [
    'Breakfast', 'Lunch', 'Dinner', 'Snack'
  ];

  final List<String> nutritionalFilters = [
    'High Protein', 'Low Carb', 'Low Fat'
  ];

  String? selectedMealType;
  String? selectedNutritionalFilter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlavorFi'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterModal,
          )
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                  hintText: 'Search ingredients or recipes',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () => _searchController.clear(),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                  )
              ),
              onSubmitted: (value) {
                // Implement recipe search
              },
            ),
          ),

          // Quick Diet Filters
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: widget.selectedDiets.map((diet) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Chip(
                    label: Text(diet),
                    backgroundColor: Colors.blue.shade100,
                    deleteIcon: Icon(Icons.cancel),
                    onDeleted: () {
                      // Remove diet filter
                    },
                  ),
                );
              }).toList(),
            ),
          ),

          // Recipe Results (Placeholder)
          Expanded(
            child: Center(
              child: Text('Your recipes will appear here'),
            ),
          )
        ],
      ),
    );
  }

  void _showFilterModal() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    'Filters',
                    style: Theme.of(context).textTheme.headlineSmall
                ),

                // Meal Type Filter
                DropdownButton<String>(
                  hint: Text('Select Meal Type'),
                  value: selectedMealType,
                  items: mealTypes.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedMealType = value;
                    });
                    Navigator.pop(context);
                  },
                ),

                // Nutritional Filter
                DropdownButton<String>(
                  hint: Text('Nutritional Filter'),
                  value: selectedNutritionalFilter,
                  items: nutritionalFilters.map((filter) {
                    return DropdownMenuItem(
                      value: filter,
                      child: Text(filter),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedNutritionalFilter = value;
                    });
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          );
        }
    );
  }
}
