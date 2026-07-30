package br.com.axi.stack_api.model;

import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.UUID;

@Data
@Entity
@Table(name = "ordens_servico")
public class OrdemServicoModel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long codigoOS;

    @Column(unique = true, updatable = false)
    private String numeroIdentificador;

    private LocalDate dataServico;
    private LocalTime horaInicio;
    private LocalTime horaFim;
    private Double horasTrabalhadas;

    private String tipoServico;
    private String statusOs;

    @Column(columnDefinition = "TEXT")
    private String descricaoAtividade;

    private Boolean isFaturada = false;

    @CreationTimestamp
    @Column(updatable = false)
    private LocalDateTime dataCriacao;


    @ManyToOne
    @JoinColumn(
            name = "codigo_projeto_fk",
            foreignKey = @ForeignKey(name = "fk_ordens_servico_projetos")
    )
    private ProjetoModel projeto;

    @ManyToOne
    @JoinColumn(
            name = "codigo_analista_fk",
            foreignKey = @ForeignKey(name = "fk_ordens_servico_analistas")
    )
    private AnalistaModel analista;

    @PrePersist
    private void gerarNumeroIdentificador(){
        if(numeroIdentificador == null){
            numeroIdentificador = "OS-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
        }
    }
}
