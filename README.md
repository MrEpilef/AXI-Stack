# Axiom Stack

Solução fullstack multiplataforma voltada para gestão de projetos, ordens de serviço, clientes e analistas, integrando um cliente reativo em Flutter a uma API robusta em Java Spring Boot com persistência em MySQL.

---

## 🏛️ Arquitetura da Solução

O ecossistema é dividido em camadas desacopladas para garantir escalabilidade, manutenibilidade e portabilidade:

* **Front-end (Client):** Interface multiplataforma construída em Flutter, consumindo serviços RESTful com tipagem estrita e reatividade.
* **Back-end (API):** Aplicação Java Spring Boot estruturada em arquitetura em camadas (Controller, Service, Repository), gerenciando regras de negócio e validações.
* **Persistência:** Banco de dados relacional MySQL 8, com mapeamento objeto-relacional (ORM) gerenciado via Spring Data JPA / Hibernate.
* **Infraestrutura & Deploy:** Contêineres orquestrados via Docker Compose em máquina virtual Linux (Ubuntu) na Oracle Cloud Infrastructure (OCI).

---

## 🛠️ Tecnologias Utilizadas

### Front-end
* **Linguagem:** Dart
* **Framework:** Flutter (v3.x)
* **Comunicação HTTP:** Biblioteca nativa/HTTP client consumindo endpoints REST

### Back-end
* **Linguagem:** Java
* **Framework:** Spring Boot
* **Persistência:** Spring Data JPA & Hibernate
* **Servidor Embutido:** Apache Tomcat

### Infraestrutura & Dados
* **SGBD:** MySQL 8.0
* **Contêineres:** Docker & Docker Compose
* **Ambiente de Nuvem:** Oracle Cloud Infrastructure (OCI) / VM Ubuntu

---

## 🚀 Como Executar o Projeto

### Pré-requisitos
* [Git](https://git-scm.com/)
* [Docker](https://www.docker.com/) e [Docker Compose](https://docs.docker.com/compose/)
* [Flutter SDK](https://docs.flutter.dev/get-started/install)

---

### 1. Clonar o Repositório
```bash
git clone [https://github.com/MrEpilef/AXI-Stack.git](https://github.com/MrEpilef/AXI-Stack.git)
cd AXI-Stack
