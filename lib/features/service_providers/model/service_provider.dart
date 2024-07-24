class ServiceProvider {
  final int id;
  final String name;
  final String image;
  final int rate;
  final String serviceTitle;

  ServiceProvider({
    required this.id,
    required this.name,
    required this.image,
    required this.rate,
    required this.serviceTitle,
  });

  factory ServiceProvider.fromJson(Map<String, dynamic> json) {
    return ServiceProvider(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      rate: json['rate'],
      serviceTitle: json['service_title'],
    );
  }
}
class Pagination {
  final int currentPage;
  final String? nextPageUrl;

  Pagination({
    required this.currentPage,
    required this.nextPageUrl,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['current_page'],
      nextPageUrl: json['next_page_url'],
    );
  }
}


class ServiceProviderResponse {
  final List<ServiceProvider> serviceProviders;
  final Pagination pagination;

  ServiceProviderResponse({
    required this.serviceProviders,
    required this.pagination,
  });

  factory ServiceProviderResponse.fromJson(Map<String, dynamic> json) {
    return ServiceProviderResponse(
      serviceProviders: (json['service_providers'] as List)
          .map((i) => ServiceProvider.fromJson(i))
          .toList(),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }
}
