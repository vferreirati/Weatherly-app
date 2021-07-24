import 'package:equatable/equatable.dart';

/// Represents a location that the application is able to retrieve
/// forecasts from.
class Location extends Equatable {
  /// ID value of this location.
  final int id;

  /// The name of this location.
  final String name;

  /// Creates a new `Location` instance.
  const Location({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
