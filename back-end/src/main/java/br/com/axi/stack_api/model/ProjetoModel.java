package br.com.axi.stack_api.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.CreationTimestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "projeto")
public class ProjetoModel {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long codigoProjeto;

	private String nomeProjeto;

	@Column(columnDefinition = "TEXT")
	private String descricaoEscopo;

	private String statusProjeto;
	private String prioridade;

	@JsonFormat(pattern = "dd/MM/yyyy")
	private LocalDate dataInicioPrevista;

	@JsonFormat(pattern = "dd/MM/yyyy")
	private LocalDate dataTerminoPrevista;
	
	private Double orcamentoHoras;
	
	private Boolean isAtivo = true;
	
	@CreationTimestamp
	@Column(updatable = false)
	private LocalDateTime dataCriacao;
	
	@ManyToOne
	@JoinColumn(name = "codigo_cliente_fk", foreignKey = @ForeignKey(name = "fk_projeto_clientes"))
	private ClienteModel cliente;
}
