import 'package:flutter/material.dart';
import'package:flutter_riverpod/flutter_riverpod.dart';

//import 'package:meals/data/dummy_data.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/widgets/main_drawer.dart';
//import 'package:meals/providers/meals_provider.dart';
import 'package:meals/providers/favorites_povider.dart';
import 'package:meals/providers/filters_provider.dart';

//import '../models/meal.dart';
import 'meals.dart';
const kInitialFilters={
    Filter.glutenFree:false,
    Filter.lactoseFree:false,
    Filter.vegeterian:false,
    Filter.vegan:false,

  };

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {

  int _selectedPageIndex = 0;
  // ignore: unused_field
  final Map<Filter,bool>_selectedFilters=kInitialFilters;
  

  void _selectedpage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });

  }
 
  void _setScreen(String Identifier)async{
      Navigator.of(context).pop();

    if(Identifier=='filters'){
    await Navigator.of(context).push<Map<Filter,bool>>(
      MaterialPageRoute(
      builder: (ctx)=> const FiltersScreen(),
     ),
     );
    //  setState(() {
    //         _selectedFilters=result ??kInitialFilters;

    //  });
    }

  }

  @override
  Widget build(BuildContext context) {
    
    final availableMeals=ref.watch(filteredMealsProvider);
    Widget activePage =
        CategoriesScreen(
          availableMeals:availableMeals,
        );
    var activePageTitle = 'Categories';
    if (_selectedPageIndex == 1) {
      final favoriteMeals=ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
          meals: favoriteMeals, 
         );
      activePageTitle = 'Your Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
        
      ),
      drawer: MainDrawer(onSelectScreen:_setScreen),
      body: activePage,

      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectedpage,
          currentIndex: _selectedPageIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.set_meal), label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
          ]),
    );
  }
}
