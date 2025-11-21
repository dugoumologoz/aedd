-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: projetobanco
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `eleicao`
--

DROP TABLE IF EXISTS `eleicao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `eleicao` (
  `id_eleicao` int(11) NOT NULL AUTO_INCREMENT,
  `titulo_eleicao` varchar(200) NOT NULL,
  `descricao_eleicao` varchar(100) NOT NULL,
  `data_registro_eleicao` datetime NOT NULL,
  `data_inicio_eleicao` datetime NOT NULL,
  `data_fim_eleicao` datetime NOT NULL,
  `ativo_eleicao` tinyint(1) DEFAULT 1,
  `status_eleicao` enum('agendada','andamento','encerrada','cancelada') DEFAULT 'agendada',
  `permite_voto_branco` tinyint(1) DEFAULT 1,
  `eleicao_fk` int(11) NOT NULL,
  PRIMARY KEY (`id_eleicao`),
  KEY `eleicao_fk` (`eleicao_fk`),
  CONSTRAINT `eleicao_ibfk_1` FOREIGN KEY (`eleicao_fk`) REFERENCES `eleicao` (`id_eleicao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eleicao`
--

LOCK TABLES `eleicao` WRITE;
/*!40000 ALTER TABLE `eleicao` DISABLE KEYS */;
/*!40000 ALTER TABLE `eleicao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `nome_usuario` varchar(100) NOT NULL,
  `sobrenome_usuario` varchar(100) NOT NULL,
  `email_usuario` varchar(150) NOT NULL,
  `senha_usuario` varchar(100) NOT NULL,
  `data_nascimento_usuario` date NOT NULL,
  `data_contratacao_usuario` date NOT NULL,
  `ativo_usuario` tinyint(1) DEFAULT 1,
  `adm_usuario` tinyint(1) DEFAULT 1,
  `matricula_usuario` varchar(20) NOT NULL,
  `cpf_usuario` varchar(14) NOT NULL,
  `telefone_usuario` varchar(20) DEFAULT NULL,
  `codigo_voto_usuario` varchar(100) NOT NULL,
  `data_codigo_expiracao` datetime DEFAULT NULL,
  `ultimo_acesso` datetime DEFAULT NULL,
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'projetobanco'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-13  4:31:19




















































create database projetocipaT3
USE projetocipaT3;


CREATE TABLE usuario (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome_usuario VARCHAR(100) NOT NULL,
    sobrenome_usuario VARCHAR(100) NOT NULL,
    email_usuario VARCHAR(150) NOT NULL,
    senha_usuario VARCHAR(100) NOT NULL,
    data_nascimento_usuario DATE NOT NULL,
    data_contratacao_usuario DATE NOT NULL,
    ativo_usuario BOOLEAN DEFAULT TRUE,
    adm_usuario BOOLEAN DEFAULT TRUE,
    matricula_usuario VARCHAR(20) NOT NULL,
    cpf_usuario VARCHAR(14) NOT NULL,
    telefone_usuario VARCHAR(20),
    codigo_voto_usuario VARCHAR(100) NOT NULL,
    ultimo_acesso DATETIME NULL
);

CREATE TABLE eleicao (
    id_eleicao INT PRIMARY KEY AUTO_INCREMENT,
    titulo_eleicao VARCHAR(200) NOT NULL,
    descricao_eleicao VARCHAR(100) NOT NULL,
    data_registro_eleicao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_inicio_eleicao DATETIME NOT NULL,
    data_fim_eleicao DATETIME NOT NULL,
    ativo_eleicao BOOLEAN DEFAULT TRUE,
    status_eleicao ENUM('agendada','andamento','encerrada','cancelada') DEFAULT 'agendada',
);


CREATE TABLE candidato (
    id_candidato INT PRIMARY KEY AUTO_INCREMENT,
    funcionario_fk INT NOT NULL,
    foto_candidato VARCHAR(255) NOT NULL,
    numero_candidato INT NOT NULL,
    data_registro_candidato DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (funcionario_fk) REFERENCES usuario(id_usuario),
    FOREIGN KEY (vice_fk) REFERENCES usuario(id_usuario),
    FOREIGN KEY (eleicao_fk) REFERENCES eleicao(id_eleicao)
);

ALTER TABLE candidato ADD UNIQUE KEY uk_numero_eleicao (numero_candidato, eleicao_fk);


CREATE TABLE documentos (
    id_documento INT PRIMARY KEY AUTO_INCREMENT,
    titulo_documento VARCHAR(200) NOT NULL,
    data_registro_documento DATETIME DEFAULT CURRENT_TIMESTAMP,
    arquivo_documento VARCHAR(255) NOT NULL,
    tipo_documento ENUM('edital','ata','regulamento','outros') NOT NULL,
    data_inicio_documento DATE NOT NULL,
    data_fim_documento DATE NOT NULL,
    FOREIGN KEY (eleicao_fk) REFERENCES eleicao(id_eleicao)
);


CREATE TABLE lista_candidatos (
    id_lista_candidato INT PRIMARY KEY AUTO_INCREMENT,
    candidato_fk INT NOT NULL,
    eleicao_fk INT NOT NULL,
    status_lista_candidato ENUM('pendente','aprovada','rejeitada','desclassificada') DEFAULT 'pendente',
    data_registro_lista_candidato DATETIME DEFAULT CURRENT_TIMESTAMP,
    quantidade_votos_lista_candidato INT NOT NULL DEFAULT 0,
    FOREIGN KEY (candidato_fk) REFERENCES candidato(id_candidato),
    FOREIGN KEY (eleicao_fk) REFERENCES eleicao(id_eleicao),
    UNIQUE KEY uk_chapa (candidato_fk, eleicao_fk)
);


CREATE TABLE voto (
    id_voto INT PRIMARY KEY AUTO_INCREMENT,
    funcionario_fk INT NOT NULL,
    eleicao_fk INT NOT NULL,
    data_hora_voto DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ip_voto VARCHAR(45),
    FOREIGN KEY (funcionario_fk) REFERENCES usuario(id_usuario),
    FOREIGN KEY (eleicao_fk) REFERENCES eleicao(id_eleicao),
    FOREIGN KEY (lista_candidato_fk) REFERENCES lista_candidatos(id_lista_candidato),
    UNIQUE KEY uk_voto_unico (funcionario_fk, eleicao_fk)
);

CREATE TABLE branco_nulo (
    id_branco_nulo 		INT PRIMARY KEY AUTO_INCREMENT,
    quantidade_branco 	INT DEFAULT 0,
    quantidade_nulo 	INT DEFAULT 0,
    eleicao_fk 			INT NOT NULL,
    FOREIGN KEY (eleicao_fk) REFERENCES eleicao(id_eleicao),
    UNIQUE KEY uk_eleicao (eleicao_fk)
);





