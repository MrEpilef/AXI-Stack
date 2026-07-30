package br.com.axi.stack_api.controller;

import br.com.axi.stack_api.model.OrdemServicoModel;
import br.com.axi.stack_api.repository.OrdemServicoRepository;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/ordens_servico")
@CrossOrigin(origins = "*")
public class OrdemServicoController {

    @Autowired
    private OrdemServicoRepository ordemServicoRepository;

    @PostMapping
    public ResponseEntity<OrdemServicoModel> salvarOrdemServico(@RequestBody OrdemServicoModel ordemServico){
        OrdemServicoModel ordemServicoSalva = ordemServicoRepository.save(ordemServico);
        return ResponseEntity.status(HttpStatus.CREATED).body(ordemServicoSalva);
    }
}
