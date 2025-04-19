import 'coordinates.dart';

/// Represents a location with optional coordinates, address, and identifier.
class Location {
  /// The geographical coordinates.
  final Coordinates? coordinates;

  /// The address of the location.
  final String? address;

  /// The identifier of the location.
  final String? id;

  /// Creates a [Location] instance.
  const Location({
    this.coordinates,
    this.address,
    this.id,
  });

  /// Creates a [Location] instance from a JSON map.
  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      coordinates: json['coordinates'] != null
          ? Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>)
          : null,
      address: json['address'] as String?,
      id: json['id'] as String?,
    );
  }

  /// Converts the [Location] instance into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'coordinates': coordinates?.toJson(),
      'address': address,
      'id': id,
    };
  }
}
