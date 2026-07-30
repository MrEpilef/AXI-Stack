import 'package:flutter/material.dart';
import 'package:axi_stack/models/projeto_model.dart';

enum TelaProjeto {
  lista,
  detalheProjeto,
  novoProjeto,
  editarProjeto,
  visualizarProjeto,
}

class ProjetoController extends ChangeNotifier {
  TelaProjeto _telaAtual = TelaProjeto.lista;
  TelaProjeto get telaAtual => _telaAtual;

  Projeto? projetoAtivo;

  void mudarTela(TelaProjeto novaTela) {
    _telaAtual = novaTela;
    notifyListeners();
  }

  void setProjetoAtivo(Projeto projeto) {
    projetoAtivo = projeto;
    notifyListeners();
  }
}
