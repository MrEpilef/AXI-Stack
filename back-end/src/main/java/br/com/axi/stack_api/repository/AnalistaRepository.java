package br.com.axi.stack_api.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import br.com.axi.stack_api.model.AnalistaModel;

@Repository
public interface AnalistaRepository extends JpaRepository<AnalistaModel, Long>{

}
