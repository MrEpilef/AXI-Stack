package br.com.axi.stack_api.repository;

import br.com.axi.stack_api.model.ProjetoModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProjetoRepository extends JpaRepository<ProjetoModel, Long> {

}
