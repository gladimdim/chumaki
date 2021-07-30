import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/wagons/wagon.dart';

class ActiveWagon {
  final City from;
  final City to;
  final Wagon wagon;

  ActiveWagon({required this.wagon, required this.to, required this.from});
}
