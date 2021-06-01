enum RESOURCE_CATEGORY { MILITARY, CLOTHS, RESOURCES, LUXURY, FOOD }

String resourceCategoryToString(RESOURCE_CATEGORY cat) {
  switch (cat) {
    case RESOURCE_CATEGORY.MILITARY:
      return "military";
    case RESOURCE_CATEGORY.CLOTHS:
      return "cloths";
    case RESOURCE_CATEGORY.RESOURCES:
      return "resources";
    case RESOURCE_CATEGORY.LUXURY:
      return "luxury";
    case RESOURCE_CATEGORY.FOOD:
      return "food";
  }
}

RESOURCE_CATEGORY resourceCategoryFromString(String input) {
  switch (input) {
    case "military": return RESOURCE_CATEGORY.MILITARY;
    case "cloths": return RESOURCE_CATEGORY.CLOTHS;
    case "resources": return RESOURCE_CATEGORY.RESOURCES;
    case "luxury": return RESOURCE_CATEGORY.LUXURY;
    case "food": return RESOURCE_CATEGORY.FOOD;
  }

  throw "Resource category $input is not recognized";
}


String categoryToImagePath(RESOURCE_CATEGORY category) {
  final catName = category.toString().split(".")[1].toLowerCase();
  return "images/icons/$catName/$catName.png";
}

List<RESOURCE_CATEGORY> DEFAULT_CATEGORIES = [RESOURCE_CATEGORY.FOOD, RESOURCE_CATEGORY.RESOURCES];