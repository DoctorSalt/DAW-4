CREATE DATABASE  IF NOT EXISTS `tiendalibros` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `tiendalibros`;
-- MySQL dump 10.13  Distrib 8.0.17, for Win64 (x86_64)
--
-- Host: localhost    Database: tiendalibros
-- ------------------------------------------------------
-- Server version	8.0.17

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `autores`
--

DROP TABLE IF EXISTS `autores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `autores` (
  `idAutor` int(11) NOT NULL AUTO_INCREMENT,
  `nombreAutor` varchar(45) DEFAULT NULL,
  `apellidosAutor` varchar(45) DEFAULT NULL,
  `fechaAutor` date DEFAULT NULL,
  `paisAutor` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idAutor`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autores`
--

LOCK TABLES `autores` WRITE;
/*!40000 ALTER TABLE `autores` DISABLE KEYS */;
INSERT INTO `autores` VALUES (1,'Bruce','Bueno de Mesquita','1946-11-24','EEUU'),(2,'Federico','Garcia Lorca','1898-06-05','España'),(3,'MIGUEL ','CORTÉS ARRESE','1970-02-02','España');
/*!40000 ALTER TABLE `autores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `editoriales`
--

DROP TABLE IF EXISTS `editoriales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `editoriales` (
  `idEditorial` int(11) NOT NULL AUTO_INCREMENT,
  `nombreEditorial` varchar(45) DEFAULT NULL,
  `fechaEditorial` date DEFAULT NULL,
  PRIMARY KEY (`idEditorial`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `editoriales`
--

LOCK TABLES `editoriales` WRITE;
/*!40000 ALTER TABLE `editoriales` DISABLE KEYS */;
INSERT INTO `editoriales` VALUES (1,'PublicAfairs','1997-01-01'),(2,'REINO DE CORDELIA','2000-01-01');
/*!40000 ALTER TABLE `editoriales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `libros`
--

DROP TABLE IF EXISTS `libros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `libros` (
  `idLibro` int(11) NOT NULL AUTO_INCREMENT,
  `nombreLibro` varchar(90) DEFAULT NULL,
  `precioLibro` float(9,2) DEFAULT NULL,
  `cantidadLibro` int(11) DEFAULT NULL,
  `fechaLibro` date DEFAULT NULL,
  `idAutorFK` int(11) NOT NULL,
  `idEditorialFK` int(11) NOT NULL,
  PRIMARY KEY (`idLibro`),
  KEY `idAutorFK1_idx` (`idAutorFK`),
  KEY `idEditorialFK1_idx` (`idEditorialFK`),
  CONSTRAINT `idAutorFK1` FOREIGN KEY (`idAutorFK`) REFERENCES `autores` (`idAutor`),
  CONSTRAINT `idEditorialFK1` FOREIGN KEY (`idEditorialFK`) REFERENCES `editoriales` (`idEditorial`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `libros`
--

LOCK TABLES `libros` WRITE;
/*!40000 ALTER TABLE `libros` DISABLE KEYS */;
INSERT INTO `libros` VALUES (1,'SAsa',12.10,5,'2020-02-12',1,1),(2,'Poeta en Nueva York',25.56,5,'1929-01-01',2,2),(3,'Las mil caras de Teodora',22.75,7,'2020-01-01',3,2);
/*!40000 ALTER TABLE `libros` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `idPedido` int(11) NOT NULL AUTO_INCREMENT,
  `fechaPedido` date DEFAULT NULL,
  `idUsuarioFK` int(11) NOT NULL,
  `enviadoPedido` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`idPedido`),
  KEY `idUsuarioFK1_idx` (`idUsuarioFK`),
  CONSTRAINT `idUsuarioFK1` FOREIGN KEY (`idUsuarioFK`) REFERENCES `usuarios` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (1,'2020-01-01',1,1),(4,'2021-02-27',1,0),(17,'2021-03-03',1,0),(18,'2021-03-03',1,1),(19,'2021-03-03',1,0),(20,'2021-03-04',1,0),(21,'2021-03-05',1,0),(22,'2021-03-05',1,0),(23,'2021-03-05',1,0),(24,'2021-03-05',1,0),(25,'2021-03-05',1,0),(26,'2021-03-05',1,0),(27,'2021-03-05',1,0),(28,'2021-03-05',1,0),(29,'2021-03-05',1,0),(30,'2021-03-05',1,0),(31,'2021-03-05',1,0);
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidoslibros`
--

DROP TABLE IF EXISTS `pedidoslibros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidoslibros` (
  `idPedidoLibro` int(11) NOT NULL AUTO_INCREMENT,
  `idPedidoFK` int(11) NOT NULL,
  `idLibroFK` int(11) NOT NULL,
  `cantidadLibros` int(11) DEFAULT NULL,
  PRIMARY KEY (`idPedidoLibro`),
  KEY `idPedidoFK1_idx` (`idPedidoFK`),
  KEY `idLibroFK1_idx` (`idLibroFK`),
  CONSTRAINT `idLibroFK1` FOREIGN KEY (`idLibroFK`) REFERENCES `libros` (`idLibro`),
  CONSTRAINT `idPedidoFK1` FOREIGN KEY (`idPedidoFK`) REFERENCES `pedidos` (`idPedido`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidoslibros`
--

LOCK TABLES `pedidoslibros` WRITE;
/*!40000 ALTER TABLE `pedidoslibros` DISABLE KEYS */;
INSERT INTO `pedidoslibros` VALUES (1,1,1,1),(2,4,1,1),(3,4,2,1),(26,17,2,2),(28,18,2,1),(29,19,2,2),(30,19,1,1),(31,20,1,2),(32,20,3,2),(33,20,2,1),(34,21,2,3),(35,21,3,1),(36,22,2,2),(37,23,1,2),(38,23,3,1),(39,24,1,5),(40,25,1,2),(41,26,1,2),(42,27,1,1),(43,27,2,1),(44,28,1,2),(45,29,1,2),(46,30,1,2),(47,31,1,2);
/*!40000 ALTER TABLE `pedidoslibros` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `idUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombreUsuario` varchar(90) DEFAULT NULL,
  `apellidosUsuario` varchar(90) DEFAULT NULL,
  `dniUsuario` varchar(9) DEFAULT NULL,
  `loginUsuario` varchar(60) DEFAULT NULL,
  `passwordUsuario` varchar(90) DEFAULT NULL,
  `fechaUsuario` date DEFAULT NULL,
  `tipoUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Oliver','Ferreira','06325744P','oliv','e3399cd27501aae3143bb67e925c7f55','1980-05-16','usuario'),(2,'Jesus','Cristo','38942156','lolM2K','b8c677ec6b669671db8dcce42b1262a7','1990-01-01','admin');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-05 13:21:18
