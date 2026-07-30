package br.com.axi.stack_api.controller;

import br.com.axi.stack_api.model.ProjetoModel;
import br.com.axi.stack_api.repository.ProjetoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/projetos")
@CrossOrigin(origins = "*")
public class ProjetoController {

        @Autowired
        private ProjetoRepository projetoRepository;

        @PostMapping
        public ResponseEntity<ProjetoModel> salvarProjeto(@RequestBody ProjetoModel projeto){
            ProjetoModel projetoSalvo = projetoRepository.save(projeto);
            return ResponseEntity.status(HttpStatus.CREATED).body(projetoSalvo);
        }
}
