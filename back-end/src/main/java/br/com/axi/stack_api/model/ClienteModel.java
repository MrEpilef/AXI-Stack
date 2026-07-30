package br.com.axi.stack_api.model;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "clientes")
public class ClienteModel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long codigoCliente; 

    private String razaoSocial;
    private String cnpj;
    private String endereco;
    private String cidade;
    private String uf;
    private String contato;
    private String telefone;
    private String email;
}
