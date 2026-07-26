import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gestorsofttec/models/analista_model.dart';

class AnalistaService {
  // A URL que o Spring Boot vai usar no seu computador depois
  final String baseUrl = 'http://localhost:8080/api/analista';

  Future<Analista?> salvarAnalista(Analista analista) async {
    print('Iniciando comunicação com o servidor...');
    
    // Converte a sua classe Cliente para o formato JSON
    final pacoteJson = jsonEncode(analista.toJson());
    
    // Imprime no console para você ver como o dado está indo perfeito
    print('Pacote JSON gerado: $pacoteJson');

    try {
      /* 
       === CÓDIGO REAL PARA O FUTURO ===
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
      */

      // === SIMULADOR PARA TESTAR O FRONTEND AGORA ===
      // Simulando que a internet demorou 2 segundos para responder
      await Future.delayed(const Duration(seconds: 2));
      
      
      print('Simulação: Spring Boot salvou e gerou o código 101');
      return Analista(
        codigoAnalista: 205, // O ID simulado que o banco gerou
        nome: analista.nome,
        email: analista.email,
        telefone: analista.telefone,
        cargo: analista.cargo,
      );
      
    } catch (e) {
      print('Erro ao conectar: $e');
      return null;
    }
  }
}