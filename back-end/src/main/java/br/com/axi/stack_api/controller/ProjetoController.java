package br.com.axi.stack_api.controller;

import br.com.axi.stack_api.model.ProjetoModel;
import br.com.axi.stack_api.repository.ProjetoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/projeto")
@CrossOrigin(origins = "*")
public class ProjetoController {

    @Autowired
    private ProjetoRepository projetoRepository;

    @PostMapping
    public ResponseEntity<ProjetoModel> salvarProjeto(@RequestBody ProjetoModel projeto){
        ProjetoModel projetoSalvo = projetoRepository.save(projeto);
        return ResponseEntity.status(HttpStatus.CREATED).body(projetoSalvo);
    }

    @GetMapping
    public ResponseEntity<List<ProjetoModel>> listarProjetos() {
        List<ProjetoModel> lista = projetoRepository.findAll();
        return ResponseEntity.ok(lista);
    }

    @GetMapping("/{id}")
    public ResponseEntity<ProjetoModel> buscarProjetoPorId(@PathVariable Long id) {
        return projetoRepository.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PutMapping("/{id}")
    public ResponseEntity<ProjetoModel> atualizarProjeto(@PathVariable Long id, @RequestBody ProjetoModel projetoAtualizado) {
        if (!projetoRepository.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        projetoAtualizado.setCodigoProjeto(id);
        ProjetoModel projetoSalvo = projetoRepository.save(projetoAtualizado);
        return ResponseEntity.ok(projetoSalvo);
    }

    @PatchMapping("{id}/inativar")
    public ResponseEntity<ProjetoModel> inativarProjeto(@PathVariable Long id){
        return projetoRepository.findById(id)
                .map(projeto -> {
                    projeto.setIsAtivo(false);
                    projetoRepository.save(projeto);
                    return ResponseEntity.ok(projeto);
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @PatchMapping("{id}/concluir")
    public ResponseEntity<ProjetoModel> concluirProjeto(@PathVariable Long id){
        return projetoRepository.findById(id)
                .map(projeto -> {
                    projeto.setIsAtivo(false);
                    projetoRepository.save(projeto);
                    return ResponseEntity.ok(projeto);
                })
                .orElse(ResponseEntity.notFound().build());
    }



}
