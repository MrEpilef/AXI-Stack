package br.com.axi.stack_api.repository;

import br.com.axi.stack_api.model.OrdemServicoModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OrdemServicoRepository extends JpaRepository<OrdemServicoModel, Long>{

}
