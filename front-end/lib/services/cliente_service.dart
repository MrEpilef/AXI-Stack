import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:axi_stack/models/cliente_model.dart';

class ClienteService {
  final String baseUrl = 'http://localhost:8080/api/clientes';

  Future<Cliente?> salvarCliente(Cliente cliente) async {
    print('Iniciando comunicação com o servidor...');
    
    final pacoteJson = jsonEncode(cliente.toJson());
    
    print('Pacote JSON gerado: $pacoteJson');

    try {
      
        final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: pacoteJson,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final retornoBackend = jsonDecode(response.body);
        return Cliente.fromJson(retornoBackend);
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