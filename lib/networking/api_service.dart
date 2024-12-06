import 'package:products/models/categaries_model.dart';
import 'package:products/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:products/models/productwithid_model.dart';

class ApiService {
  Future<List<ProductModel>> fetchProduct() async {
    List<ProductModel> list = [];
    String url = "https://fakestoreapi.com/products";
    var res = await http.get(Uri.parse(url));
    list = productModelFromJson(res.body);
    return list;
  }

  // Categaries
  Future<List<String>> fetchCategaries() async {
    List<String> clist = [];
    String url2 = "https://fakestoreapi.com/products/categories";
    var res = await http.get(Uri.parse(url2));
    clist = categariesModelFromJson(res.body);
    return clist;
  }

  // Product with Id
  Future<ProductWithIdModel> fetchProductWithId(int id) async {
    ProductWithIdModel ilist;
    String url3 = "https://fakestoreapi.com/products/$id";
    var res = await http.get(Uri.parse(url3));
    ilist = productWithIdModelFromJson(res.body);
    return ilist;
  }
}
