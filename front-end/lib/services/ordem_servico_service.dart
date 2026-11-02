import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:axi_stack/models/ordem_servico_model.dart';

class OrdemServicoService {
  // Mantenha o mesmo IP configurado em cliente_service.dart e projeto_service.dart
  final String baseUrl = 'http://163.176.58.249:3030/api/ordem_servico';
  // final String baseUrl = 'http://localhost:3030/api/ordem_servico';

  Future<OrdemServico?> salvarOrdemServico(OrdemServico ordemServico) async {
    print('Iniciando comunicação com o servidor...');

    final pacoteJson = jsonEncode(ordemServico.toJson());
    print('Pacote JSON gerado: $pacoteJson');

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: pacoteJson,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> retornoBackend =
            jsonDecode(utf8.decode(response.bodyBytes));

        // Mescla os códigos gerados pelo banco na O.S. atual para usar na tela e no PDF
        return ordemServico.copyWith(
          codigoOS: retornoBackend['codigoOS'],
          numeroIdentificador: retornoBackend['numeroIdentificador'],
          statusOs: retornoBackend['statusOs'],
          dataCriacao: retornoBackend['dataCriacao']?.toString(),
        );
      } else {
        print('Erro no servidor: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Erro ao conectar: $e');
      return null;
    }
  }

  Future<List<OrdemServico>> buscarListaOrdensServico() async {
    print('Buscando Ordens de Serviço no servidor...');

    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        List<dynamic> retornoBackend =
            jsonDecode(utf8.decode(response.bodyBytes));
        return retornoBackend
            .map((json) => OrdemServico.fromJson(json))
            .toList();
      } else {
        print('Erro no servidor ao buscar O.S.: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Erro de conexão ao buscar O.S.: $e');
      return [];
    }
  }
}