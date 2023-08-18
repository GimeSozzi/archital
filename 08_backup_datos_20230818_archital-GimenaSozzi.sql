-- DESAFIO ENTREGABLE: Backup de la base de datos
-- Curso: SQL
-- Alumna: Gimena Sozzi
-- Comision: #43425

-- EL BACKUP CONTIENE LOS DATOS DE TODAS LAS TABLAS DE LA BASE DE DATOS "archital"

-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: archital
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,1,1,'20123456781'),(2,2,2,'27876543213'),(3,3,2,'20234567892'),(4,4,3,'27345678901'),(5,5,4,'20456789013'),(6,6,1,'27567890122'),(7,7,1,'20678901234'),(8,8,1,'27789012343'),(9,9,2,'20890123455'),(10,10,2,'27901234563'),(11,11,1,'20123456786'),(12,12,2,'20234567890'),(13,13,3,'27345678900'),(14,14,2,'20456789017'),(15,15,1,'27567890124');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `condicionfiscal`
--

LOCK TABLES `condicionfiscal` WRITE;
/*!40000 ALTER TABLE `condicionfiscal` DISABLE KEYS */;
INSERT INTO `condicionfiscal` VALUES (3,'Exento'),(4,'No Inscripto'),(1,'Resp. Inscripto'),(2,'Resp. Monotributo');
/*!40000 ALTER TABLE `condicionfiscal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `contrato`
--

LOCK TABLES `contrato` WRITE;
/*!40000 ALTER TABLE `contrato` DISABLE KEYS */;
INSERT INTO `contrato` VALUES (1,1,1,'2023-08-18 17:08:41'),(2,2,1,'2023-08-18 17:08:41'),(3,3,2,'2023-08-18 17:08:41'),(4,4,1,'2023-08-18 17:08:41'),(5,5,1,'2023-08-18 17:08:41'),(6,6,2,'2023-08-18 17:08:41'),(7,7,2,'2023-08-18 17:08:41'),(8,8,1,'2023-08-18 17:08:41'),(9,9,1,'2023-08-18 17:08:41'),(10,10,1,'2023-08-18 17:08:41'),(11,11,1,'2023-08-18 17:08:41'),(12,12,1,'2023-08-18 17:08:41'),(13,13,2,'2023-08-18 17:08:41'),(14,14,2,'2023-08-18 17:08:41'),(15,15,1,'2023-08-18 17:08:41');
/*!40000 ALTER TABLE `contrato` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `especialidad`
--

LOCK TABLES `especialidad` WRITE;
/*!40000 ALTER TABLE `especialidad` DISABLE KEYS */;
INSERT INTO `especialidad` VALUES (3,'Arq. Comercial'),(4,'Arq. Corporativa'),(6,'Arq. Deportiva'),(2,'Arq. Hospitalaria'),(1,'Arq. Residencial'),(5,'Arq. Turistica'),(11,'Eficiencia Energetica'),(13,'Gestion BIM'),(12,'Infoarquitectura'),(9,'Interiorismo'),(7,'Paisajismo'),(10,'Restauracion'),(8,'Urbanismo');
/*!40000 ALTER TABLE `especialidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `estadocontrato`
--

LOCK TABLES `estadocontrato` WRITE;
/*!40000 ALTER TABLE `estadocontrato` DISABLE KEYS */;
INSERT INTO `estadocontrato` VALUES (2,'Firmado'),(1,'Pendiente');
/*!40000 ALTER TABLE `estadocontrato` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `estadopago`
--

LOCK TABLES `estadopago` WRITE;
/*!40000 ALTER TABLE `estadopago` DISABLE KEYS */;
INSERT INTO `estadopago` VALUES (2,'Completado'),(1,'Pendiente');
/*!40000 ALTER TABLE `estadopago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `estadopresupuesto`
--

LOCK TABLES `estadopresupuesto` WRITE;
/*!40000 ALTER TABLE `estadopresupuesto` DISABLE KEYS */;
INSERT INTO `estadopresupuesto` VALUES (3,'Aceptado'),(2,'Enviado'),(1,'No enviado'),(4,'Rechazado');
/*!40000 ALTER TABLE `estadopresupuesto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `estadoproyecto`
--

LOCK TABLES `estadoproyecto` WRITE;
/*!40000 ALTER TABLE `estadoproyecto` DISABLE KEYS */;
INSERT INTO `estadoproyecto` VALUES (3,'En proceso'),(4,'Finalizado'),(2,'Iniciado'),(1,'Pendiente');
/*!40000 ALTER TABLE `estadoproyecto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `habilidades`
--

LOCK TABLES `habilidades` WRITE;
/*!40000 ALTER TABLE `habilidades` DISABLE KEYS */;
INSERT INTO `habilidades` VALUES (4,'3DMax'),(13,'Allplan'),(3,'ArchiCAD'),(1,'AutoCAD'),(8,'Blender'),(9,'Corona'),(7,'Lumion'),(14,'Photoshop'),(2,'Revit'),(6,'Rhino'),(5,'Sketchup'),(11,'Unreal Engine'),(12,'Vectorworks'),(10,'Vray');
/*!40000 ALTER TABLE `habilidades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `logcliente`
--

LOCK TABLES `logcliente` WRITE;
/*!40000 ALTER TABLE `logcliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `logcliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `logprofesional`
--

LOCK TABLES `logprofesional` WRITE;
/*!40000 ALTER TABLE `logprofesional` DISABLE KEYS */;
/*!40000 ALTER TABLE `logprofesional` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `logproyecto`
--

LOCK TABLES `logproyecto` WRITE;
/*!40000 ALTER TABLE `logproyecto` DISABLE KEYS */;
/*!40000 ALTER TABLE `logproyecto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `logseguimiento`
--

LOCK TABLES `logseguimiento` WRITE;
/*!40000 ALTER TABLE `logseguimiento` DISABLE KEYS */;
/*!40000 ALTER TABLE `logseguimiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `mensajes`
--

LOCK TABLES `mensajes` WRITE;
/*!40000 ALTER TABLE `mensajes` DISABLE KEYS */;
INSERT INTO `mensajes` VALUES (1,1,3,'Consulta honorarios','Hola, antes que me envies el presupuesto. Quisiera saber si cobras por hora o proyecto. Saludos','2023-08-18 17:08:41'),(2,1,1,'Rta. Honorarios','Buenas tardes, mis honorarios son en base a los m2 del proyecto. Saludos Cordiales','2023-08-18 17:08:41'),(3,8,8,'','El proyecto quedo expectacular. Felicitaciones y muchas gracias! Saludos','2023-08-18 17:08:41'),(4,14,15,'Aumentar escala','Buen dia, descargué la imagen del anteproyecto peor la escala no me permite leer las cotas. Podrias enviarla en 1:20. Gracias','2023-08-18 17:08:41');
/*!40000 ALTER TABLE `mensajes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `metodopago`
--

LOCK TABLES `metodopago` WRITE;
/*!40000 ALTER TABLE `metodopago` DISABLE KEYS */;
INSERT INTO `metodopago` VALUES (4,'PayPal'),(3,'Tarjeta de Credito'),(2,'Tarjeta de Debito'),(1,'Transferencia');
/*!40000 ALTER TABLE `metodopago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `pagos`
--

LOCK TABLES `pagos` WRITE;
/*!40000 ALTER TABLE `pagos` DISABLE KEYS */;
INSERT INTO `pagos` VALUES (1,8,2,1,'2023-08-18 17:08:41'),(2,13,2,1,'2023-08-18 17:08:41'),(3,15,1,1,'2023-08-18 17:08:41');
/*!40000 ALTER TABLE `pagos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `persona`
--

LOCK TABLES `persona` WRITE;
/*!40000 ALTER TABLE `persona` DISABLE KEYS */;
INSERT INTO `persona` VALUES (1,'Juan','Pérez','01112345678','San Martín 456, Buenos Aires','juan.perez@netarq.com','12345678'),(2,'María','González','03511234567','Libertador 2345, Córdoba','maria.gonzalez@archital.com','87654321'),(3,'Luis','López','03411321456','9 de Julio 789, Rosario','luis.lopez@house.com','23456789'),(4,'Ana','Martínez','02611234567','Belgrano 567, Mendoza','ana.martinez@clients.com','34567890'),(5,'Diego','Rodríguez','03871567890','Corrientes 890, Salta','diego.rodriguez@dominio.com','45678901'),(6,'Carla','Hernández','03814123456','Sarmiento 123, Tucumán','carla.hernandez@arcdes.com','56789012'),(7,'Pedro','Gómez','02231567890','Mitre 456, Mar del Plata','pedro.gomez@email.com','67890123'),(8,'Sofía','Rivera','03815123456','Lavalle 234, San Miguel de Tucumán','sofia.rivera@person.com','78901234'),(9,'Alejandro','Silva','02211567890','San Juan 567, La Plata','alejandro.silva@correo.com','89012345'),(10,'Valentina','Torres','03431567890','Pellegrini 890, Rosario','valentina.torres@correo.com','90123456'),(11,'Gabriel','Rojas','03511567890','25 de Mayo 123, Córdoba','gabriel.rojas@correo.com','12345678'),(12,'Fernando','Vargas','02292567890','Belgrano 456, Tandil','fernando.vargas@correo.com','23456789'),(13,'Lucía','Peralta','03874567890','Corrientes 789, Salta','lucia.peralta@correo.com','34567890'),(14,'Matías','Guerrero','02231567890','Mendoza 234, Mar del Plata','matias.guerrero@dominio.com','45678901'),(15,'Renata','Mendoza','02991567890','9 de Julio 567, Neuquén','renata.mendoza@dominio.com','56789012'),(16,'Emilio','Cruz','02611567890','San Martín 890, Mendoza','emilio.cruz@archital.com','67890123'),(17,'Isabella','Orozco','03431567890','Libertador 2345, Rosario','isabella.orozco@netarq.com','78901234'),(18,'Santiago','Soto','03511567890','Belgrano 567, Córdoba','santiago.soto@house.com','89012345'),(19,'Camila','Luna','02236567890','Sarmiento 890, Mar del Plata','camila.luna@clients.com','90123456'),(20,'Nicolás','Mejía','01112345678','Mitre 123, Buenos Aires','nicolas.mejia@dominio.com','12345678'),(21,'Valeria','Castañeda','03431567890','Corrientes 456, Tucumán','valeria.castaneda@correo.com','23456789'),(22,'Maximiliano','Sánchez','02611567890','Lavalle 789, Mendoza','maximiliano.sanchez@arcdes.com','34567890'),(23,'Emilia','Delgado','03511567890','San Juan 234, Rosario','emilia.delgado@email.com','45678901'),(24,'Sebastián','Peña','02231567890','Pellegrini 567, Buenos Aires','sebastian.pena@person.com','56789012'),(25,'Antonella','Ríos','03431567890','25 de Mayo 890, Córdoba','antonella.rios@correo.com','67890123'),(26,'Benjamín','Morales','02231567890','Belgrano 234, Mendoza','benjamin.morales@correo.com','78901234'),(27,'Javiera','Cortés','03511567890','Corrientes 567, Rosario','javiera.cortes@dominio.com','89012345'),(28,'Matías','Herrera','03864567890','Mendoza 890, Tucumán','matias.herrera@correo.com','90123456'),(29,'Trinidad','Moya','03871567890','San Martín 123, Salta','trinidad.moya@correo.com','12345678'),(30,'Laura','Gómez','02991567890','Avenida 9 de Julio 456, Neuquén','laura.gomez@dominio.com','67890123');
/*!40000 ALTER TABLE `persona` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `presupuesto`
--

LOCK TABLES `presupuesto` WRITE;
/*!40000 ALTER TABLE `presupuesto` DISABLE KEYS */;
INSERT INTO `presupuesto` VALUES (1,1,1,NULL,'2023-08-18 17:08:41'),(2,2,2,250000.00,'2023-08-18 17:08:41'),(3,3,2,500000.00,'2023-08-18 17:08:41'),(4,4,2,100000.00,'2023-08-18 17:08:41'),(5,5,2,498200.00,'2023-08-18 17:08:41'),(6,6,2,169000.00,'2023-08-18 17:08:41'),(7,7,2,310000.00,'2023-08-18 17:08:41'),(8,8,3,805100.00,'2023-08-18 17:08:41'),(9,9,2,700000.00,'2023-08-18 17:08:41'),(10,10,2,253700.00,'2023-08-18 17:08:41'),(11,11,2,680000.00,'2023-08-18 17:08:41'),(12,12,1,NULL,'2023-08-18 17:08:41'),(13,13,3,450000.00,'2023-08-18 17:08:41'),(14,14,2,324000.00,'2023-08-18 17:08:41'),(15,15,2,128900.00,'2023-08-18 17:08:41');
/*!40000 ALTER TABLE `presupuesto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `profesional`
--

LOCK TABLES `profesional` WRITE;
/*!40000 ALTER TABLE `profesional` DISABLE KEYS */;
INSERT INTO `profesional` VALUES (1,16,'M32331A','/uploads/cv/cv_emiliocruz.pdf',9.2),(2,17,'B12343A','/uploads/cv/isabellaocv.pdf',8.0),(3,18,'E98756C','/uploads/cv/arqsotoscv.pdf',7.1),(4,19,'M25897D','/uploads/cv/cv_arq_camilaluna.pdf',6.8),(5,20,'C78651E','/uploads/cv/cvmejianicolas.pdf',6.2),(6,21,'D30694A','/uploads/cv/cvcastanedav.pdf',10.0),(7,22,'M89651A','/uploads/cv/cv_sanchezmax.pdf',9.3),(8,23,'F78923W','/uploads/cv/delgadoemilia_resume.pdf',7.6),(9,24,'R78965A','/uploads/cv/cv_pena.pdf',8.2),(10,25,'C01235P','/uploads/cv/ariosarqcv.pdf',7.9),(11,26,'M98635S','/uploads/cv/cv_moralesb.pdf',8.0),(12,27,'A04587D','/uploads/cv/cortezj_cv.pdf',5.7),(13,28,'A12985G','/uploads/cv/resume_herrera_arq.pdf',6.9),(14,29,'B55874V','/uploads/cv/cv_trinidadmoya23.pdf',9.1),(15,30,'D11335C','/uploads/cv/gomez_laura_cv.pdf',8.3);
/*!40000 ALTER TABLE `profesional` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `profespecialidad`
--

LOCK TABLES `profespecialidad` WRITE;
/*!40000 ALTER TABLE `profespecialidad` DISABLE KEYS */;
INSERT INTO `profespecialidad` VALUES (1,1,1),(2,1,9),(3,2,1),(4,2,3),(5,2,13),(6,3,1),(7,4,1),(8,4,5),(9,5,6),(10,6,1),(11,6,12),(12,7,1),(13,7,4),(14,7,9),(15,7,11),(16,8,1),(17,8,11),(18,8,13),(19,9,4),(20,9,2),(21,10,6),(22,11,1),(23,11,5),(24,11,7),(25,12,5),(26,13,3),(27,14,1),(28,14,8),(29,15,1),(30,15,10),(31,15,13);
/*!40000 ALTER TABLE `profespecialidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `profhabilidad`
--

LOCK TABLES `profhabilidad` WRITE;
/*!40000 ALTER TABLE `profhabilidad` DISABLE KEYS */;
INSERT INTO `profhabilidad` VALUES (1,1,1),(2,1,2),(3,2,1),(4,2,5),(5,3,1),(6,3,5),(7,3,14),(8,4,1),(9,4,7),(10,5,1),(11,5,2),(12,5,9),(13,6,1),(14,6,2),(15,6,4),(16,6,7),(17,6,10),(18,6,11),(19,6,14),(20,7,1),(21,7,5),(22,8,1),(23,8,2),(24,8,5),(25,9,1),(26,9,8),(27,10,1),(28,10,4),(29,10,9),(30,11,1),(31,12,1),(32,12,3),(33,12,7),(34,13,1),(35,14,1),(36,15,1),(37,15,6);
/*!40000 ALTER TABLE `profhabilidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `proyecto`
--

LOCK TABLES `proyecto` WRITE;
/*!40000 ALTER TABLE `proyecto` DISABLE KEYS */;
INSERT INTO `proyecto` VALUES (1,3,1,2,1,'Casa Moderna',180.50,2,'/uploads/plano/casa_moderna_plano.pdf','Una casa moderna con diseño minimalista.','2023-01-15',NULL),(2,5,2,1,2,'Edificio Comercial',850.75,5,'/uploads/plano/edificio_comercial_final.dwg','Edificio comercial de 5 plantas con locales y oficinas.','2023-02-10',NULL),(3,2,3,3,1,'Remodelación Residencial',120.25,1,'/uploads/plano/remodelacion_residencial_plan2.pdf','Remodelación de una casa antigua para adaptarla a un estilo moderno.','2023-03-05',NULL),(4,12,4,1,3,'Hotel de Lujo',1250.30,10,'/uploads/plano/hotel_de_lujo_terminado.dwg','Diseño y construcción de un hotel de lujo con vista al mar.','2023-04-20',NULL),(5,8,5,3,4,'Complejo Deportivo',3000.00,3,'/uploads/plano/complejo_deportivo_plan_1.pdf','Un complejo deportivo con canchas de tenis, piscina y gimnasio.','2023-05-12',NULL),(6,11,6,3,1,'Departamentos Urbanos',480.90,6,'/uploads/plano/departamentos_urbanos.dwg','Construcción de un edificio de departamentos en el centro de la ciudad.','2023-06-08',NULL),(7,14,7,3,5,'Centro Educativo',750.00,4,'/uploads/plano/centro_educativo_final2.pdf','Diseño y construcción de un centro educativo con salones y áreas recreativas.','2023-07-18',NULL),(8,10,8,4,1,'Viviendas Sustentables',320.45,2,'/uploads/plano/viviendas_sustentables.dwg','Proyecto de viviendas eco-friendly con sistemas de energía solar.','2023-08-03','2024-05-10'),(9,6,9,2,2,'Oficinas Corporativas',1620.70,7,'/uploads/plano/oficinas_corporativas_planta.pdf','Construcción de oficinas corporativas con diseño vanguardista.','2023-07-15',NULL),(10,7,10,3,6,'Centro Médico',900.80,5,'/uploads/plano/centro_medico_plan_1.dwg','Un moderno centro médico con tecnología de punta.','2023-01-22',NULL),(11,13,11,3,1,'Casa de Playa',200.00,1,'/uploads/plano/casa_de_playa_plan_2.pdf','Diseño de una casa de playa con acceso directo al mar.','2023-03-05',NULL),(12,9,12,1,7,'Complejo Turístico',1800.00,8,'/uploads/plano/complejo_turistico_planimetria.dwg','Proyecto de un complejo turístico con cabañas y áreas recreativas.','2023-06-10',NULL),(13,1,13,4,2,'Centro Comercial',1200.25,6,'/uploads/plano/centro_comercial_plantasyelevaciones.pdf','Construcción de un centro comercial con diversas tiendas y restaurantes.','2023-01-08','2023-05-20'),(14,15,14,3,4,'Estadio Deportivo',4500.00,1,'/uploads/plano/estadio_deportivo_finalll.dwg','Diseño y construcción de un estadio deportivo con capacidad para 30,000 personas.','2023-02-20',NULL),(15,4,15,4,1,'Torre Residencial',3560.60,15,'/uploads/plano/torre_residencial_planos.pdf','Proyecto de una torre residencial de lujo con impresionantes vistas.','2022-03-15','2023-06-10');
/*!40000 ALTER TABLE `proyecto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `seguimiento`
--

LOCK TABLES `seguimiento` WRITE;
/*!40000 ALTER TABLE `seguimiento` DISABLE KEYS */;
INSERT INTO `seguimiento` VALUES (1,5,'2023-08-18 17:08:41','Anteproyecto terminado. Se inicia Proyecto.'),(2,6,'2023-08-18 17:08:41','Plano de arquitectura finalizado. Se inicia estructura.'),(3,7,'2023-08-18 17:08:41','Plano de instalaciones eléctricas iniciado.'),(4,10,'2023-08-18 17:08:41','Anteproyecto iniciado.'),(5,11,'2023-08-18 17:08:41','Anteproyecto terminado.'),(6,14,'2023-08-18 17:08:41','Plano sistema contra incendios y señaletica terminado.');
/*!40000 ALTER TABLE `seguimiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tipologia`
--

LOCK TABLES `tipologia` WRITE;
/*!40000 ALTER TABLE `tipologia` DISABLE KEYS */;
INSERT INTO `tipologia` VALUES (2,'Comercial'),(8,'Corporativo'),(4,'Deportivo'),(5,'Educación'),(3,'Hotel'),(1,'Residencial'),(6,'Salud'),(7,'Turismo');
/*!40000 ALTER TABLE `tipologia` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-18 14:11:29
