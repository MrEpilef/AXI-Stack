package br.com.axi.stack_api.model;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "Analista")
public class AnalistaModel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long codigoAnalista;

    private String nome;
    private String cargo;
    private String email;
    private String telefone;
}
