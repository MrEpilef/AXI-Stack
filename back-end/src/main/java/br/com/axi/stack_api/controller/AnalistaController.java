package br.com.axi.stack_api.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.com.axi.stack_api.model.AnalistaModel;
import br.com.axi.stack_api.repository.AnalistaRepository;

@RestController
@RequestMapping("/api/analistas")
@CrossOrigin(origins = "*")
public class AnalistaController {
    
    @Autowired
    private AnalistaRepository analistaRepository;

    @PostMapping
    public ResponseEntity<AnalistaModel> salvarAnalista(@RequestBody AnalistaModel analista) {
        AnalistaModel analistaSalvo = analistaRepository.save(analista);
        return ResponseEntity.status(HttpStatus.CREATED).body(analistaSalvo);
    }

    
}
