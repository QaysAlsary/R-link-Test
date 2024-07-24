const baseUrl = 'https://test.quantumgate.io';
const registerPath = '/api/auth/register';
const loginPath = '/api/auth/login';
String getServiceProvidersPath({
  required page
}){
  return '$baseUrl/api/service-providers?page=$page';
}
String getServiceProviderDetailsPath({
  required id
}){
  return '$baseUrl/api/service-providers/$id';
}

String token = '';

