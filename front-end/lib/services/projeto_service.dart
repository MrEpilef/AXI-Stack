import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:axi_stack/models/projeto_model.dart';

// ------------------------------
//        INTERFACE
// ------------------------------
abstract class IProjetoService {
  Future<Projeto?> salvarProjeto(Projeto projeto);
  Future<List<Projeto>> buscarListaProjetos();
}

class ProjetoServiceHttp implements IProjetoService {
  final String baseUrl = 'http://localhost:8080/api/projetos';

  @override
  Future<Projeto?> salvarProjeto(Projeto projeto) async {
    print('Iniciando comunicação com o servidor...');
    final pacoteJson = jsonEncode(projeto.toJson());

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: pacoteJson,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final retornoBackend = jsonDecode(response.body);
        return Projeto.fromJson(retornoBackend);
      } else {
        print('Erro no servidor: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erro ao conectar: $e');
      return null;
    }
  }

  @override
  Future<List<Projeto>> buscarListaProjetos() async {
    final url = Uri.parse(baseUrl);

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> retornoBackend = jsonDecode(response.body);
        return retornoBackend.map((json) => Projeto.fromJson(json)).toList();
      } else {
        throw Exception('Falha ao carregar os projetos');
      }
    } catch (e) {
      print('Erro ao buscar projetos: $e');
      return [];
    }
  }
}

// ====================================
//  LISTA FALSA DE CLIENTES PARA TESTE
// ====================================
class ProjetoServiceMock implements IProjetoService {
  final String _jsonDeExemplo = '''
    [
      {
        "codigoProjeto": 1,
        "nomeProjeto": "Implantação de PDV",
        "descricaoEscopo": "Implantação completa do PDV nas frentes de caixa",
        "prioridade": "Alta",
        "dataInicioPrevista": "10/08/2026",
        "dataTerminoPrevista": "30/08/2026",
        "statusProjeto": "Em Andamento",
        "isAtivo": true,
        "cliente": {
          "codigoCliente": 1,
          "razaoSocial": "Mega São Luís",
          "cnpj": "11.111.111/0001-11",
          "endereco": "Avenida dos Holandeses, 1000",
          "cidade": "São Luís",
          "uf": "MA",
          "contato": "Roberto Carlos",
          "telefone": "(98) 99999-1111",
          "email": "contato@megasaoluis.com.br"
        }
      },
      {
        "codigoProjeto": 2,
        "nomeProjeto": "Auditoria e Migração Firebird",
        "descricaoEscopo": "Migração completa de dados para Oracle",
        "prioridade": "Alta",
        "dataInicioPrevista": "05/08/2026",
        "dataTerminoPrevista": "10/09/2026",
        "statusProjeto": "Pendente",
        "isAtivo": true,
        "cliente": {
          "codigoCliente": 2,
          "razaoSocial": "Supermercado Central",
          "cnpj": "33.333.333/0001-33",
          "endereco": "Rua 10, 789",
          "cidade": "Goiânia",
          "uf": "GO",
          "contato": "Ana Silva",
          "telefone": "(62) 97777-3333",
          "email": "comercial@comprebem.com.br"
        }
      }
    ]
    '''; 
  @override
  Future<Projeto?> salvarProjeto(Projeto projeto) async {
    print('MOCK: Fingindo que salvou o projeto ${projeto.nomeProjeto}');
    // SIMULAÇÃO DE TEMPO DE RESPOSTA
    await Future.delayed(const Duration(seconds: 1));
    return projeto;
  }

  @override
  Future<List<Projeto>> buscarListaProjetos() async {
    print('MOCK: Carregando projetos de mentira...');
    // SIMULAÇÃO DE TEMPO DE RESPOSTA
    await Future.delayed(const Duration(seconds: 1));

    List<dynamic> lista = jsonDecode(_jsonDeExemplo);
    return lista.map((item) => Projeto.fromJson(item)).toList();
  }
}
