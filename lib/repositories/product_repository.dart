import '../core/services/api_service.dart';
import '../models/product_model.dart';

class ProductRepository {
  final ApiService _api;

  ProductRepository(this._api);

  Future<List<ProductModel>> fetchAll() async {
    final json = await _api.get('https://fakestoreapi.com/products');
    if (json is List) {
      return json.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      throw Exception('Formato de dados inesperado');
    }
  }
}
