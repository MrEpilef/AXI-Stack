package br.com.axi.stack_api;

import java.util.TimeZone;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import jakarta.annotation.PostConstruct;

@SpringBootApplication
public class AxiStackApplication {

	public static void main(String[] args) {
		SpringApplication.run(AxiStackApplication.class, args);
	}


	@PostConstruct
    public void init() {
        // Força o horário de Brasilia
        TimeZone.setDefault(TimeZone.getTimeZone("America/Sao_Paulo"));
    }

}
