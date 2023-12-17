import'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';
enum Filter{
  glutenFree,
  lactoseFree,
  vegeterian,
  vegan,

}
class filtersNotifier extends StateNotifier<Map<Filter,bool>>{

  filtersNotifier():super({
    Filter.glutenFree:false,
    Filter.lactoseFree:false,
    Filter.vegeterian:false,
    Filter.vegan:false,
  });
  void setFilters(Map<Filter,bool>choosenFilters){
    state=choosenFilters;
  }
  void setFilter(Filter filter,bool isActive){
   // state[filter]=isActive;
   state={
    ...state,
    filter:isActive,
   };
  }
}


final filtersProvider=StateNotifierProvider
<filtersNotifier,
Map<Filter,bool>>((ref) =>filtersNotifier(),
);
final filteredMealsProvider= Provider((ref) {
 final meals= ref.watch(mealsProvider);
 final activeFilters=ref.watch(filtersProvider);
      return meals.where((meal){
      if(activeFilters[Filter.glutenFree]! && !meal.isGlutenFree){
        return false;
      }
       if(activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree){
        return false;
      }
       if(activeFilters[Filter.vegeterian]! && !meal.isVegetarian){
        return false;
      }
       if(activeFilters[Filter.vegan]! && !meal.isVegan){
        return false;
      }
      return true;
    }).toList();
});
