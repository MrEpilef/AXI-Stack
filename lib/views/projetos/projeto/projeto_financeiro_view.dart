import 'package:flutter/material.dart';

class Lancamento {
  final String destino;
  final double valor;
  final String categoria;
  final DateTime data;
  final bool temAnexo;

  Lancamento({
    required this.destino,
    required this.valor,
    required this.categoria,
    required this.data,
    required this.temAnexo,
  });
}

class ProjetoFinanceiroView extends StatelessWidget {
  ProjetoFinanceiroView({super.key});

  final List<Lancamento> lancamentos = [
    Lancamento(
      destino: 'Hotel AB',
      valor: 2560.00,
      categoria: 'Hotel',
      data: DateTime(2026, 7, 21),
      temAnexo: true,
    ),
    Lancamento(
      destino: 'Restaurante porta aberta',
      valor: 25.60,
      categoria: 'Alimentação',
      data: DateTime(2026, 7, 19),
      temAnexo: true,
    ),
    Lancamento(
      destino: 'Posto Ipiranga',
      valor: 215.63,
      categoria: 'Combustível',
      data: DateTime(2026, 7, 18),
      temAnexo: false,
    ),
    Lancamento(
      destino: 'Restaurante Porta Aberta',
      valor: 75.60,
      categoria: 'Alimentação',
      data: DateTime(2026, 7, 22),
      temAnexo: true,
    ),
    Lancamento(
      destino: 'Pedágio',
      valor: 15.80,
      categoria: 'Pedágio',
      data: DateTime(2026, 7, 24),
      temAnexo: false,
    ),
    Lancamento(
      destino: 'Diária Hotel AB',
      valor: 250.00,
      categoria: 'Hotel',
      data: DateTime(2026, 6, 30),
      temAnexo: true,
    ),
  ];
@override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(32.0),
      itemCount: lancamentos.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = lancamentos[index];
        return _construirItemLista(item);
      },
    );
  }

  // 3. O VISUAL ATUALIZADO
  Widget _construirItemLista(Lancamento item) {
    IconData iconeCategoria;
    Color corIcone;

    switch (item.categoria) {
      case 'Hotel':
        iconeCategoria = Icons.hotel;
        corIcone = const Color(0xFF3498DB);
        break;
      case 'Abastecimento':
        iconeCategoria = Icons.local_gas_station;
        corIcone = const Color(0xFFF39C12);
        break;
      case 'Alimentação':
        iconeCategoria = Icons.restaurant;
        corIcone = const Color(0xFF2ECC71);
        break;
      default:
        iconeCategoria = Icons.receipt_long;
        corIcone = Colors.grey;
    }

    // FORMATAÇÃO DO VALOR
    String valorFormatado = 'R\$ ${item.valor.toStringAsFixed(2).replaceAll('.', ',')}';

    // FORMATAÇÃO DA DATA (Padrão DD/MM/AAAA)
    // O padLeft(2, '0') garante que o dia 5 vire '05', por exemplo.
    String dia = item.data.day.toString().padLeft(2, '0');
    String mes = item.data.month.toString().padLeft(2, '0');
    String ano = item.data.year.toString();
    String dataFormatada = '$dia/$mes/$ano';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF001B29),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // ÍCONE DA CATEGORIA
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: corIcone.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(iconeCategoria, color: corIcone, size: 24),
          ),
          
          const SizedBox(width: 16),

          // INFORMAÇÕES DO DESTINO + DATA
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.destino,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                
                // Agrupando a Categoria e a Data na mesma linha
                Row(
                  children: [
                    Text(
                      item.categoria,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      ' • $dataFormatada', // O pontinho separando a categoria da data
                      style: TextStyle(
                        color: Colors.grey[600], // Um cinza um pouquinho mais escuro
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // VALOR E INDICADOR DE ANEXO
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                valorFormatado,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              
              Row(
                children: [
                  Text(
                    item.temAnexo ? 'Comprovante' : 'Sem anexo',
                    style: TextStyle(
                      color: item.temAnexo ? Colors.grey[400] : Colors.grey[600],
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    item.temAnexo ? Icons.attach_file : Icons.attachment_outlined,
                    color: item.temAnexo ? const Color(0xFFF14004) : Colors.grey.withValues(alpha: 0.3),
                    size: 14,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}