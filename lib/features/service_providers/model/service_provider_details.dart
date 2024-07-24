
import 'dart:convert';

ServiceProviderDetailsModel serviceProviderDetailsModelFromJson(Map<String, dynamic> str) => ServiceProviderDetailsModel.fromJson(str);

String serviceProviderDetailsModelToJson(ServiceProviderDetailsModel data) => json.encode(data.toJson());

class ServiceProviderDetailsModel {
  bool? success;
  String? message;
  ServiceProviders? serviceProviders;

  ServiceProviderDetailsModel({
    this.success,
    this.message,
    this.serviceProviders,
  });

  factory ServiceProviderDetailsModel.fromJson(Map<String, dynamic> json) => ServiceProviderDetailsModel(
    success: json["success"],
    message: json["message"],
    serviceProviders: json["service_providers"] == null ? null : ServiceProviders.fromJson(json["service_providers"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "service_providers": serviceProviders?.toJson(),
  };
}

class ServiceProviders {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? description;
  String? image;
  int? rate;
  Service? service;

  ServiceProviders({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.description,
    this.image,
    this.rate,
    this.service,
  });

  factory ServiceProviders.fromJson(Map<String, dynamic> json) => ServiceProviders(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    description: json["description"],
    image: json["image"],
    rate: json["rate"],
    service: json["service"] == null ? null : Service.fromJson(json["service"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "description": description,
    "image": image,
    "rate": rate,
    "service": service?.toJson(),
  };
}

class Service {
  int? id;
  String? title;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  Service({
    this.id,
    this.title,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
