-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-11-2021 a las 19:37:09
-- Versión del servidor: 10.4.18-MariaDB
-- Versión de PHP: 8.0.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `lab2_turnos`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `INSERTARTURNOS` (IN `P_IDCAL` INT, IN `P_HINICIO` TIME, IN `P_HFIN` TIME, IN `P_TIEMPOTURNO` TIME)  BEGIN
	DECLARE V_CANT INT;
    DECLARE V_HTURNO TIME;
    SELECT round(((time_to_sec(P_HFIN) - time_to_sec(P_HINICIO)) / 60) / (time_to_sec(P_TIEMPOTURNO) / 60)) INTO V_CANT;
    SET V_HTURNO = P_HINICIO;
    MYLOOP:LOOP
    SET V_CANT = V_CANT - 1;
    INSERT INTO turnos (calendarioid, hora_turno, estadoturnoid, createdAt, updatedAt) VALUES (P_IDCAL, V_HTURNO, 1, NOW(), NOW());
    SET V_HTURNO = ADDTIME(V_HTURNO, P_TIEMPOTURNO);
    IF(V_CANT = 0)THEN
    	LEAVE MYLOOP;
    END IF;
    END LOOP;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `TURNOAUSENTE` (IN `P_IDTURN` INT)  BEGIN
 UPDATE turnos SET estadoturnoid = 5 WHERE id = P_IDTURN;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `agendas`
--

CREATE TABLE `agendas` (
  `id` int(11) NOT NULL,
  `personaid` int(11) NOT NULL,
  `clinicaid` int(11) NOT NULL,
  `medicoid` int(11) DEFAULT NULL,
  `procedimientoid` int(11) DEFAULT NULL,
  `nombre` varchar(50) NOT NULL,
  `tiempo_turno` time NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `agendas`
--

INSERT INTO `agendas` (`id`, `personaid`, `clinicaid`, `medicoid`, `procedimientoid`, `nombre`, `tiempo_turno`, `createdAt`, `updatedAt`) VALUES
(1, 1, 4, 1, NULL, 'Agenda Doctor Messi', '00:30:00', '2021-11-08 00:00:48', '2021-11-08 00:00:48'),
(2, 1, 1, 2, NULL, 'Agenda Doctor Cristiano', '00:17:00', '2021-11-08 00:00:48', '2021-11-08 00:00:48'),
(3, 1, 4, NULL, 3, 'Agenda para Ecografia', '00:45:00', '2021-11-08 00:02:49', '2021-11-08 00:02:49'),
(4, 1, 3, NULL, 2, 'Agenda para Electrocardiograma', '00:30:00', '2021-11-08 00:02:49', '2021-11-08 00:02:49'),
(5, 18, 4, 2, NULL, 'Agenda de cristiano ronaldo', '00:30:00', '2021-11-20 21:39:15', '2021-11-20 21:39:15'),
(6, 18, 4, NULL, 1, 'Agenda de Radiologia', '00:45:00', '2021-11-20 21:40:55', '2021-11-20 21:40:55'),
(7, 18, 2, NULL, 4, 'Agenda de Endoscopia', '00:30:00', '2021-11-21 17:44:41', '2021-11-21 17:44:41'),
(8, 18, 5, 3, NULL, 'Agenda de kevin paredes', '00:30:00', '2021-11-22 23:59:06', '2021-11-22 23:59:06'),
(9, 18, 3, NULL, 6, 'Agenda de procedimientoPrueba2', '00:45:00', '2021-11-24 15:48:35', '2021-11-24 15:48:35'),
(10, 18, 6, NULL, 7, 'Agenda de procedimientoPureba3', '01:00:00', '2021-11-25 14:37:18', '2021-11-25 14:37:18');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `calendarios`
--

CREATE TABLE `calendarios` (
  `id` int(11) NOT NULL,
  `agendaid` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `calendarios`
--

INSERT INTO `calendarios` (`id`, `agendaid`, `fecha`, `hora_inicio`, `hora_fin`, `createdAt`, `updatedAt`) VALUES
(1, 1, '2021-11-01', '08:00:00', '10:00:00', '2021-11-08 00:04:20', '2021-11-08 00:04:20'),
(2, 1, '2021-11-03', '08:00:00', '21:00:00', '2021-11-08 00:04:20', '2021-11-08 00:04:20'),
(3, 1, '2021-11-05', '09:00:00', '10:00:00', '2021-11-08 00:05:31', '2021-11-08 00:05:31'),
(4, 2, '2021-11-04', '12:00:00', '18:00:00', '2021-11-08 00:05:31', '2021-11-08 00:05:31'),
(5, 3, '2021-11-09', '17:00:00', '21:00:00', '2021-11-08 00:06:33', '2021-11-08 00:06:33'),
(6, 4, '2021-11-19', '13:00:00', '14:00:00', '2021-11-08 00:06:33', '2021-11-08 00:06:33'),
(7, 4, '2021-11-22', '08:00:00', '15:00:00', '2021-11-19 19:53:45', '2021-11-19 19:53:45'),
(8, 7, '2021-11-23', '15:00:00', '16:30:00', '2021-11-21 18:50:03', '2021-11-21 18:50:03'),
(9, 7, '2021-11-24', '10:00:00', '12:00:00', '2021-11-21 18:53:27', '2021-11-21 18:53:27'),
(10, 8, '2021-11-24', '08:00:00', '10:00:00', '2021-11-23 00:00:32', '2021-11-23 00:00:32'),
(11, 8, '2021-11-25', '16:00:00', '17:30:00', '2021-11-23 16:09:31', '2021-11-23 16:09:31'),
(12, 9, '2021-11-26', '14:00:00', '16:30:00', '2021-11-24 15:49:13', '2021-11-24 15:49:13'),
(13, 9, '2021-11-27', '08:00:00', '12:00:00', '2021-11-24 17:01:38', '2021-11-24 17:01:38'),
(14, 10, '2021-11-26', '17:00:00', '19:00:00', '2021-11-25 14:37:53', '2021-11-25 14:37:53');

--
-- Disparadores `calendarios`
--
DELIMITER $$
CREATE TRIGGER `CREARTURNOS` AFTER INSERT ON `calendarios` FOR EACH ROW BEGIN
	DECLARE V_TIEMPOTURNO TIME;
    SELECT TIEMPO_TURNO INTO V_TIEMPOTURNO FROM agendas a WHERE A.id = new.agendaid;
    CALL INSERTARTURNOS(new.id, new.hora_inicio, new.hora_fin, V_TIEMPOTURNO);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clinicas`
--

CREATE TABLE `clinicas` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `direccion` varchar(250) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `clinicas`
--

INSERT INTO `clinicas` (`id`, `nombre`, `direccion`, `createdAt`, `updatedAt`) VALUES
(1, 'Rivadavia', 'Rivadavia 456 San Luis', '2021-11-07 23:58:23', '2021-11-07 23:58:23'),
(2, 'Santa Rita', 'Falucho 454 San Luis', '2021-11-07 23:58:23', '2021-11-07 23:58:23'),
(3, 'San Jose', 'Perderna 222 San luis', '2021-11-07 23:59:36', '2021-11-07 23:59:36'),
(4, 'Maria becker', 'la punta norte 123', '2021-11-07 23:59:36', '2021-11-07 23:59:36'),
(5, 'Quilmes', 'el sabor del encuentro', '2021-11-21 20:02:41', '2021-11-21 20:02:41'),
(6, 'clinicaprueba1', 'clinicaprueba1', '2021-11-25 14:35:52', '2021-11-25 14:35:52');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especialidads`
--

CREATE TABLE `especialidads` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `detalles` varchar(250) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `especialidads`
--

INSERT INTO `especialidads` (`id`, `nombre`, `detalles`, `createdAt`, `updatedAt`) VALUES
(1, 'Cardiologia', 'Cardiología', '2021-11-07 23:53:26', '2021-11-07 23:53:26'),
(2, 'Pediatria', 'Pediatria', '2021-11-07 23:53:26', '2021-11-07 23:53:26'),
(3, 'Neurologia', 'Neurología', '2021-11-07 23:54:06', '2021-11-07 23:54:06'),
(4, 'Gastroenterologia', 'Gastroenterología', '2021-11-07 23:54:06', '2021-11-07 23:54:06'),
(5, 'pruebaEsp', 'purebaEsp', '2021-11-23 18:54:26', '2021-11-23 18:54:26');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_turnos`
--

CREATE TABLE `estado_turnos` (
  `id` tinyint(4) NOT NULL,
  `descripcion` varchar(250) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `estado_turnos`
--

INSERT INTO `estado_turnos` (`id`, `descripcion`, `createdAt`, `updatedAt`) VALUES
(1, 'Disponible', '2021-11-07 23:45:13', '2021-11-07 23:45:13'),
(2, 'Reservado', '2021-11-07 23:45:13', '2021-11-07 23:45:13'),
(3, 'Cancelado', '2021-11-07 23:45:31', '2021-11-07 23:45:31'),
(4, 'Confirmado', '2021-11-07 23:45:31', '2021-11-07 23:45:31'),
(5, 'Ausente', '2021-11-07 23:45:56', '2021-11-07 23:45:56');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medicos`
--

CREATE TABLE `medicos` (
  `id` int(11) NOT NULL,
  `personaid` int(11) NOT NULL,
  `matricula` int(11) NOT NULL,
  `especialidadid` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `medicos`
--

INSERT INTO `medicos` (`id`, `personaid`, `matricula`, `especialidadid`, `createdAt`, `updatedAt`) VALUES
(1, 5, 39123, 1, '2021-11-08 17:12:05', '2021-11-08 16:11:14'),
(2, 6, 123321, 2, '2021-11-08 16:11:21', '2021-11-08 16:10:28'),
(3, 1, 3123123, 2, '2021-11-12 00:49:42', '2021-11-12 00:49:42'),
(4, 20, 999333111, 5, '2021-11-23 19:02:40', '2021-11-23 19:02:40');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personas`
--

CREATE TABLE `personas` (
  `id` int(11) NOT NULL,
  `dni` int(11) NOT NULL,
  `usuarioid` int(11) DEFAULT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `celular` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `domicilio` varchar(250) NOT NULL,
  `riesgoso` int(11) NOT NULL DEFAULT 0,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `personas`
--

INSERT INTO `personas` (`id`, `dni`, `usuarioid`, `nombre`, `apellido`, `celular`, `email`, `domicilio`, `riesgoso`, `createdAt`, `updatedAt`) VALUES
(1, 39137254, 1, 'kevin', 'paredes', 1231233, 'kevinenriquep26@gmail.com', 'la punta', 0, '2021-11-07 23:47:38', '2021-11-07 23:47:38'),
(2, 39137255, 2, 'enrique', 'ramirez', 26643321, 'enrique@gmail.com', 'San luis', 3, '2021-11-07 23:47:38', '2021-11-22 17:41:40'),
(3, 39137256, 3, 'juan', 'perez', 264412322, 'jaunp@gmail.com', 'san luis', 0, '2021-11-07 23:49:36', '2021-11-07 23:49:36'),
(4, 39137257, NULL, 'pepe', 'pupu', 3234234, 'pepe@gmail.com', 'san luis', 0, '2021-11-07 23:49:36', '2021-11-07 23:49:36'),
(5, 39137258, NULL, 'leo', 'messi', 31233122, 'messi@gmail.com', 'san luis', 0, '2021-11-07 23:50:58', '2021-11-07 23:50:58'),
(6, 39137259, NULL, 'cristiano', 'ronaldo', 3322111, 'cristiano@gmail.com', 'san luis', 0, '2021-11-07 23:50:58', '2021-11-07 23:50:58'),
(17, 39137253, 13, 'kevin', 'Ramirez', 1233254366, 'kramirez224@gmail.com', 'la punta', 6, '2021-11-14 22:29:53', '2021-11-25 14:57:11'),
(18, 1231231233, 14, 'administrador', 'administrador', 1231231233, 'administrador@gmail.com', 'adminland', 0, '2021-11-20 19:50:35', '2021-11-20 19:50:35'),
(19, 2147483647, 15, 'secretario', 'secretario', 11223300, 'secretario@gmail.com', 'secretarioland', 0, '2021-11-21 23:09:36', '2021-11-21 23:09:36'),
(20, 883312283, NULL, 'windows', 'nueve', 932315923, 'windows@gmail.com', 'windowsland', 0, '2021-11-23 18:49:15', '2021-11-23 18:49:15'),
(21, 93929199, 16, 'paciente4', 'pacienteee4', 3929199, 'paciente4@gmail.com', 'paciente4land', 0, '2021-11-23 22:02:25', '2021-11-23 22:02:25'),
(22, 123456789, 17, 'jorge', 'buscarolo', 884455666, 'jbuscarolo@gmail.com', 'san luis', 1, '2021-11-24 15:37:16', '2021-11-24 15:44:54'),
(23, 39393923, 18, 'paciente5', 'paciente5', 29394856, 'paciente5@gmail.com', 'pacienteland', 0, '2021-11-25 14:30:32', '2021-11-25 14:30:32'),
(24, 39384321, 19, 'miky', 'pazini', 392848312, 'paciente6@gmail.com', 'san luis', 0, '2021-11-25 15:13:03', '2021-11-25 15:13:03'),
(25, 29939491, 20, 'michael', 'jaxx', 31233123, 'jaxx@gmail.com', 'jaxxland', 0, '2021-11-25 15:20:36', '2021-11-25 15:20:36'),
(26, 39292938, 21, 'nahuel', 'piñoe', 3923945, 'pinoe@gmail.com', 'san luis', 0, '2021-11-25 15:23:55', '2021-11-25 15:23:55'),
(27, 39393262, 22, 'javier', 'mascherano', 31235671, 'masche@gmail.com', 'la punta', 0, '2021-11-25 15:29:17', '2021-11-25 15:29:17'),
(28, 32112342, 23, 'maxi', 'maxiel', 3212312, 'maxiel@gmail.com', 'la punta', 0, '2021-11-25 15:32:37', '2021-11-25 15:32:37'),
(29, 49248365, 24, 'manu', 'gino', 123151233, 'manu@gmail.com', 'san luis', 0, '2021-11-25 15:35:25', '2021-11-25 15:35:25');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `procedimientos`
--

CREATE TABLE `procedimientos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(250) NOT NULL,
  `indicaciones` varchar(250) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `procedimientos`
--

INSERT INTO `procedimientos` (`id`, `nombre`, `descripcion`, `indicaciones`, `createdAt`, `updatedAt`) VALUES
(1, 'Radiologia', 'Radiología general', 'sin objetos metalicos', '2021-11-07 23:56:14', '2021-11-07 23:56:14'),
(2, 'Electrocardiograma', 'electrocardiograma', 'traer toalla', '2021-11-07 23:56:14', '2021-11-07 23:56:14'),
(3, 'Ecografia', 'Ecografía general', 'traer toalla', '2021-11-07 23:57:19', '2021-11-07 23:57:19'),
(4, 'Endoscopia', 'Endoscopia', 'ayunas 12h', '2021-11-07 23:57:19', '2021-11-07 23:57:19'),
(5, 'procedimientoPrueba', 'prueba1', 'prueba2', '2021-11-21 20:06:01', '2021-11-21 20:06:01'),
(6, 'procedimientoPrueba2', 'prueba1', 'prueba1', '2021-11-23 14:45:24', '2021-11-23 14:45:24'),
(7, 'procedimientoPureba3', 'procedimiento de prueba', 'prueba 1', '2021-11-25 14:36:56', '2021-11-25 14:36:56');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `informacion` varchar(250) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `nombre`, `informacion`, `createdAt`, `updatedAt`) VALUES
(1, 'Administrador', 'Administrador del sistema, crea agendas.', '2021-11-07 23:42:39', '2021-11-07 23:42:39'),
(2, 'Admision', 'Recepcionista, puede asignar turnos y cambiarles el estado.', '2021-11-07 23:42:39', '2021-11-07 23:42:39'),
(3, 'Paciente', 'Paciente puede agendar turnos, cancelar turno.', '2021-11-07 23:44:21', '2021-11-07 23:44:21');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `turnos`
--

CREATE TABLE `turnos` (
  `id` int(11) NOT NULL,
  `personaid` int(11) DEFAULT NULL,
  `calendarioid` int(11) NOT NULL,
  `fecha_reserva` datetime DEFAULT NULL,
  `hora_turno` time NOT NULL,
  `estadoturnoid` tinyint(4) NOT NULL DEFAULT 1,
  `comentario` varchar(250) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `turnos`
--

INSERT INTO `turnos` (`id`, `personaid`, `calendarioid`, `fecha_reserva`, `hora_turno`, `estadoturnoid`, `comentario`, `createdAt`, `updatedAt`) VALUES
(9, 17, 1, '2021-11-18 23:01:43', '08:00:00', 5, '', '2021-11-10 00:30:18', '2021-11-18 23:01:43'),
(10, 17, 1, '2021-11-18 23:04:58', '08:30:00', 5, '', '2021-11-10 00:30:18', '2021-11-18 23:04:58'),
(12, 17, 1, NULL, '09:30:00', 3, '', '2021-11-10 00:31:35', '2021-11-19 19:34:10'),
(13, 2, 6, NULL, '13:00:00', 5, NULL, '2021-11-19 15:31:44', '2021-11-22 18:26:50'),
(14, 2, 6, NULL, '13:30:00', 5, NULL, '2021-11-19 15:31:44', '2021-11-22 18:29:26'),
(15, 17, 7, '2021-11-19 23:04:20', '08:00:00', 5, NULL, '2021-11-19 15:54:39', '2021-11-19 23:04:20'),
(16, 17, 7, '2021-11-19 23:06:58', '08:30:00', 5, NULL, '2021-11-19 15:54:39', '2021-11-19 23:06:58'),
(17, 17, 7, '2021-11-19 23:08:48', '09:00:00', 5, NULL, '2021-11-19 15:54:39', '2021-11-19 23:08:48'),
(18, 17, 7, '2021-11-19 23:11:10', '09:30:00', 5, NULL, '2021-11-19 15:54:39', '2021-11-19 23:11:10'),
(19, 17, 7, '2021-11-19 23:11:21', '10:00:00', 5, NULL, '2021-11-19 15:54:39', '2021-11-19 23:11:21'),
(20, 17, 7, '2021-11-19 23:13:39', '10:30:00', 5, NULL, '2021-11-19 15:54:39', '2021-11-19 23:13:39'),
(21, 17, 7, '2021-11-19 23:14:05', '11:00:00', 3, NULL, '2021-11-19 15:54:39', '2021-11-22 00:52:07'),
(22, 19, 7, NULL, '11:30:00', 5, NULL, '2021-11-19 15:54:39', '2021-11-22 18:39:44'),
(23, 19, 7, NULL, '12:00:00', 5, NULL, '2021-11-19 15:54:39', '2021-11-22 18:41:30'),
(24, 17, 7, '2021-11-22 19:05:48', '12:30:00', 5, NULL, '2021-11-19 15:54:39', '2021-11-22 19:05:48'),
(25, 17, 7, '2021-11-22 23:56:56', '13:00:00', 5, NULL, '2021-11-19 15:54:39', '2021-11-22 23:56:56'),
(26, 21, 7, '2021-11-23 22:04:01', '13:30:00', 5, NULL, '2021-11-19 15:54:39', '2021-11-23 22:04:02'),
(27, NULL, 7, NULL, '14:00:00', 5, NULL, '2021-11-19 15:54:39', '2021-11-19 15:54:39'),
(28, NULL, 7, NULL, '14:30:00', 5, NULL, '2021-11-19 15:54:39', '2021-11-19 15:54:39'),
(29, NULL, 8, NULL, '15:00:00', 5, NULL, '2021-11-21 18:50:03', '2021-11-21 18:50:03'),
(30, 23, 8, '2021-11-25 14:31:58', '15:30:00', 2, NULL, '2021-11-21 18:50:03', '2021-11-25 14:31:58'),
(31, NULL, 8, NULL, '16:00:00', 1, NULL, '2021-11-21 18:50:03', '2021-11-21 18:50:03'),
(32, NULL, 9, NULL, '10:00:00', 5, NULL, '2021-11-21 18:53:27', '2021-11-21 18:53:27'),
(33, NULL, 9, NULL, '10:30:00', 5, NULL, '2021-11-21 18:53:27', '2021-11-21 18:53:27'),
(34, NULL, 9, NULL, '11:00:00', 5, NULL, '2021-11-21 18:53:27', '2021-11-21 18:53:27'),
(35, NULL, 9, NULL, '11:30:00', 5, NULL, '2021-11-21 18:53:27', '2021-11-21 18:53:27'),
(36, NULL, 10, NULL, '08:00:00', 5, NULL, '2021-11-23 00:00:32', '2021-11-23 00:00:32'),
(37, NULL, 10, NULL, '08:30:00', 5, NULL, '2021-11-23 00:00:32', '2021-11-23 00:00:32'),
(38, NULL, 10, NULL, '09:00:00', 5, NULL, '2021-11-23 00:00:32', '2021-11-23 00:00:32'),
(39, NULL, 10, NULL, '09:30:00', 5, NULL, '2021-11-23 00:00:32', '2021-11-23 00:00:32'),
(40, NULL, 11, NULL, '16:00:00', 1, NULL, '2021-11-23 16:09:31', '2021-11-23 16:09:31'),
(41, NULL, 11, NULL, '16:30:00', 1, NULL, '2021-11-23 16:09:31', '2021-11-23 16:09:31'),
(42, 22, 11, '2021-11-24 15:42:15', '17:00:00', 3, NULL, '2021-11-23 16:09:31', '2021-11-24 15:44:54'),
(43, 17, 12, '2021-11-25 14:28:46', '14:00:00', 2, NULL, '2021-11-24 15:49:13', '2021-11-25 14:28:46'),
(44, NULL, 12, NULL, '14:45:00', 1, NULL, '2021-11-24 15:49:13', '2021-11-24 15:49:13'),
(45, NULL, 12, NULL, '15:30:00', 1, NULL, '2021-11-24 15:49:13', '2021-11-24 15:49:13'),
(46, 17, 13, '2021-11-24 21:12:59', '08:00:00', 2, NULL, '2021-11-24 17:01:38', '2021-11-24 21:12:59'),
(47, NULL, 13, NULL, '08:45:00', 1, NULL, '2021-11-24 17:01:38', '2021-11-24 17:01:38'),
(48, NULL, 13, NULL, '09:30:00', 1, NULL, '2021-11-24 17:01:38', '2021-11-24 17:01:38'),
(49, NULL, 13, NULL, '10:15:00', 1, NULL, '2021-11-24 17:01:38', '2021-11-24 17:01:38'),
(50, NULL, 13, NULL, '11:00:00', 1, NULL, '2021-11-24 17:01:38', '2021-11-24 17:01:38'),
(51, NULL, 14, NULL, '17:00:00', 1, NULL, '2021-11-25 14:37:53', '2021-11-25 14:37:53'),
(52, NULL, 14, NULL, '18:00:00', 1, NULL, '2021-11-25 14:37:53', '2021-11-25 14:37:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `usuario` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `roleid` int(11) NOT NULL DEFAULT 3,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `usuario`, `password`, `roleid`, `createdAt`, `updatedAt`) VALUES
(1, 'admin', '1234', 1, '2021-11-07 23:46:23', '2021-11-07 23:46:23'),
(2, 'secretario', '1234', 2, '2021-11-07 23:46:23', '2021-11-07 23:46:23'),
(3, 'paciente', '1234', 3, '2021-11-07 23:47:11', '2021-11-07 23:47:11'),
(13, 'prueba', '$2b$10$lYozT6nPo2saM/u7Cjlxe.tvqMiIhbiH/0KtssVaJjpcFp1LlTi52', 3, '2021-11-14 22:29:53', '2021-11-25 14:57:11'),
(14, 'prueba2', '$2b$10$VsZeQdGWbstUiE3B9aPknuFiefB9Cxf2LrtrMItbvEJsz0rtuUoGK', 1, '2021-11-20 19:50:35', '2021-11-20 19:50:35'),
(15, 'prueba3', '$2b$10$QhMPerSf58w6jIRovim1NuSOzWSfGCulq5foJrgPw679JKxK.FMRi', 2, '2021-11-21 23:09:36', '2021-11-21 23:09:36'),
(16, 'paciente4', '$2b$10$ejbLw5r2pfpLy35M/5E0FeZXY9Ek4KWkUlyhh/2hjm321gtkk0Usi', 3, '2021-11-23 22:02:25', '2021-11-23 22:02:25'),
(17, 'jbuscarolo', '$2b$10$RUBjihXogIXiGKMqF0dsk.RXgegaGvrAkzipwlT1kMi7I2btTDfZu', 3, '2021-11-24 15:37:16', '2021-11-24 15:37:16'),
(18, 'paciente5', '$2b$10$aZecdDXmgbvrCcdgQhEphOtV5tWxRLd2lB1HztULWDnmnkpnIeARO', 3, '2021-11-25 14:30:32', '2021-11-25 14:30:32'),
(19, 'paciente6', '$2b$10$gHVtB5Jhet78iBSOJa3J..lP1BddtsLIGuNkyJxdUoiLUuFcdI8A2', 3, '2021-11-25 15:13:03', '2021-11-25 15:13:03'),
(20, 'paciente7', '$2b$10$uvloV/owbA2NqiVzs2fFNe5iZSrJ7yGGTu9rvtRCsN4XL7Npxvba2', 3, '2021-11-25 15:20:36', '2021-11-25 15:20:36'),
(21, 'paciente8', '$2b$10$388mH2l4x9RwqbPs9UnknOGNiTV07agIbR8mgtaqQdjxqStdZTZH2', 3, '2021-11-25 15:23:55', '2021-11-25 15:23:55'),
(22, 'paciente9', '$2b$10$9JpRHYUpibWy0mhfRLMfF.U13Ig5yX95yzah9BbKjjy3pywB8MgHu', 3, '2021-11-25 15:29:17', '2021-11-25 15:29:17'),
(23, 'paciente10', '$2b$10$m5Oey5ehkErQeTVk5iQBke4THzlTZYStkMnJM0NnvI4L9HVn1oySm', 3, '2021-11-25 15:32:37', '2021-11-25 15:32:37'),
(24, 'paciente11', '$2b$10$MGuqXrUT9LdG6NzC68Ds5.naJL9qBYJWKRVpIPXzrv744.x90xzHa', 3, '2021-11-25 15:35:25', '2021-11-25 15:35:25');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `agendas`
--
ALTER TABLE `agendas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_AGD_PER` (`personaid`),
  ADD KEY `FK_AGD_CNC` (`clinicaid`),
  ADD KEY `FK_AGD_MDC` (`medicoid`),
  ADD KEY `FK_AGD_PCT` (`procedimientoid`);

--
-- Indices de la tabla `calendarios`
--
ALTER TABLE `calendarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_CLD_AGD` (`agendaid`);

--
-- Indices de la tabla `clinicas`
--
ALTER TABLE `clinicas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `especialidads`
--
ALTER TABLE `especialidads`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `estado_turnos`
--
ALTER TABLE `estado_turnos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `medicos`
--
ALTER TABLE `medicos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `matricula` (`matricula`),
  ADD KEY `FK_MDC_PER` (`personaid`),
  ADD KEY `FK_MDC_ESP` (`especialidadid`);

--
-- Indices de la tabla `personas`
--
ALTER TABLE `personas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `dni` (`dni`),
  ADD KEY `FK_PER_USU` (`usuarioid`);

--
-- Indices de la tabla `procedimientos`
--
ALTER TABLE `procedimientos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `turnos`
--
ALTER TABLE `turnos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_TRN_CLD` (`calendarioid`),
  ADD KEY `FK_TRN_ESTT` (`estadoturnoid`),
  ADD KEY `paciente` (`personaid`) USING BTREE;

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `usuario` (`usuario`),
  ADD KEY `FK_USU_ROL` (`roleid`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `agendas`
--
ALTER TABLE `agendas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `calendarios`
--
ALTER TABLE `calendarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `clinicas`
--
ALTER TABLE `clinicas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `especialidads`
--
ALTER TABLE `especialidads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `estado_turnos`
--
ALTER TABLE `estado_turnos`
  MODIFY `id` tinyint(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `medicos`
--
ALTER TABLE `medicos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `personas`
--
ALTER TABLE `personas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT de la tabla `procedimientos`
--
ALTER TABLE `procedimientos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `turnos`
--
ALTER TABLE `turnos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `agendas`
--
ALTER TABLE `agendas`
  ADD CONSTRAINT `FK_AGD_CNC` FOREIGN KEY (`clinicaid`) REFERENCES `clinicas` (`id`),
  ADD CONSTRAINT `FK_AGD_MDC` FOREIGN KEY (`medicoid`) REFERENCES `medicos` (`id`),
  ADD CONSTRAINT `FK_AGD_PCT` FOREIGN KEY (`procedimientoid`) REFERENCES `procedimientos` (`id`),
  ADD CONSTRAINT `FK_AGD_PER` FOREIGN KEY (`personaid`) REFERENCES `personas` (`id`);

--
-- Filtros para la tabla `calendarios`
--
ALTER TABLE `calendarios`
  ADD CONSTRAINT `FK_CLD_AGD` FOREIGN KEY (`agendaid`) REFERENCES `agendas` (`id`);

--
-- Filtros para la tabla `medicos`
--
ALTER TABLE `medicos`
  ADD CONSTRAINT `FK_MDC_ESP` FOREIGN KEY (`especialidadid`) REFERENCES `especialidads` (`id`),
  ADD CONSTRAINT `FK_MDC_PER` FOREIGN KEY (`personaid`) REFERENCES `personas` (`id`);

--
-- Filtros para la tabla `personas`
--
ALTER TABLE `personas`
  ADD CONSTRAINT `FK_PER_USU` FOREIGN KEY (`usuarioid`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `turnos`
--
ALTER TABLE `turnos`
  ADD CONSTRAINT `FK_TRN_CLD` FOREIGN KEY (`calendarioid`) REFERENCES `calendarios` (`id`),
  ADD CONSTRAINT `FK_TRN_ESTT` FOREIGN KEY (`estadoturnoid`) REFERENCES `estado_turnos` (`id`),
  ADD CONSTRAINT `FK_TRN_PER_PAC` FOREIGN KEY (`personaid`) REFERENCES `personas` (`id`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `FK_USU_ROL` FOREIGN KEY (`roleid`) REFERENCES `roles` (`id`);

DELIMITER $$
--
-- Eventos
--
CREATE DEFINER=`root`@`localhost` EVENT `CAMBIARTURNOAUNSENTE` ON SCHEDULE EVERY 1 DAY STARTS '2021-11-23 00:00:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
            DECLARE IDTURNO INT;
            DECLARE DONE INT;
            DECLARE TURNOS_CAMBIAR CURSOR FOR
                SELECT t.id FROM turnos t JOIN calendarios c ON(t.calendarioid = c.id) 
                    WHERE (c.fecha <= CURRENT_DATE) AND (t.hora_turno < SUBTIME(CURRENT_TIME, '00:01:00')) AND (t.estadoturnoid IN (1,2));
            DECLARE CONTINUE HANDLER FOR NOT FOUND SET DONE = 1;
            SET DONE = 0;

            OPEN TURNOS_CAMBIAR;
            MYLOOP: LOOP
                FETCH TURNOS_CAMBIAR INTO IDTURNO;
                IF DONE THEN
                    LEAVE MYLOOP;
                END IF;
                CALL TURNOAUSENTE(IDTURNO);
            END LOOP MYLOOP;
            CLOSE TURNOS_CAMBIAR;
        END$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
