import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:axi_stack/models/analista_model.dart';

class AnalistaService {
  
  final String baseUrl = 'http://localhost:8080/api/analistas';

  Future<Analista?> salvarAnalista(Analista analista) async {
    final pacoteJson = jsonEncode(analista.toJson());

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: pacoteJson,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final retornoBackend = jsonDecode(response.body);
        return Analista.fromJson(retornoBackend);
      } else {
        print('Erro no servidor: ${response.statusCode}');
        return null;
      }
     
    } catch (e) {
      print('Erro ao conectar: $e');
      return null;
    }
  }
}