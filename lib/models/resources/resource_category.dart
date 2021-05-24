enum RESOURCE_CATEGORY { MILITARY, CLOTHS, RESOURCES, LUXURY, FOOD }

String resourceCategoryToString(RESOURCE_CATEGORY cat) {
  switch (cat) {
    case RESOURCE_CATEGORY.MILITARY:
      return "military";
    case RESOURCE_CATEGORY.CLOTHS:
      return "cloth";
    case RESOURCE_CATEGORY.RESOURCES:
      return "resources";
    case RESOURCE_CATEGORY.LUXURY:
      return "luxury";
    case RESOURCE_CATEGORY.FOOD:
      return "food";
  }
}
