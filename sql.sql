SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Base de datos: `bitacoradb`
--
CREATE DATABASE IF NOT EXISTS `bitacoradb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `bitacoradb`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `acc_accesslog`
--

DROP TABLE IF EXISTS `acc_accesslog`;
CREATE TABLE IF NOT EXISTS `acc_accesslog` (
  `id` int(11) NOT NULL,
  `idPerson` int(11) NOT NULL,
  `idPlace` int(11) NOT NULL,
  `accessType` char(3) NOT NULL,
  `date` datetime NOT NULL,
  `updatedBy` int(11) NOT NULL,
  `updatedOn` datetime NOT NULL,
  `comments` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
--
-- Estructura de tabla para la tabla `acc_person`
--

DROP TABLE IF EXISTS `acc_person`;
CREATE TABLE IF NOT EXISTS `acc_person` (
  `id` int(11) NOT NULL,
  `number` varchar(10) NOT NULL,
  `fullname` varchar(200) NOT NULL,
  `birth` date NOT NULL,
  `expiry` date NOT NULL,
  `gender` varchar(10) NOT NULL,
  `comments` varchar(255) NOT NULL,
  `isSystemUser` tinyint(1) NOT NULL COMMENT 'Admin = 1, Supervisor = 2, Operator = 3',
  `updatedBy` int(11) NOT NULL,
  `updatedOn` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `acc_person`
--

INSERT INTO `acc_person` (`id`, `number`, `fullname`, `birth`, `expiry`, `gender`, `comments`, `isSystemUser`, `updatedBy`, `updatedOn`) VALUES
(1, '1111', 'admin', '2015-06-22', '2015-06-22', 'M', 'usuario administrador', 1, 1, '2015-06-22 00:00:00')
,(2, '2222', 'supervisor', '2015-06-22', '2015-06-22', 'M', 'usuario supervisor', 2, 1, '2015-06-22 00:00:00')
,(3, '3333', 'operador', '2015-06-22', '2015-06-22', 'M', 'usuario operador', 3, 1, '2015-06-22 00:00:00');
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `acc_place`
--

DROP TABLE IF EXISTS `acc_place`;
CREATE TABLE IF NOT EXISTS `acc_place` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `comments` varchar(255) NOT NULL,
  `updatedBy` int(11) NOT NULL,
  `updatedOn` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `acc_place`
--

INSERT INTO `acc_place` (`id`, `name`, `comments`, `updatedBy`, `updatedOn`) VALUES
(1, 'SYSTEM', 'SYSTEM', 1, '0000-00-00 00:00:00');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `acc_accesslog`
--
ALTER TABLE `acc_accesslog`
  ADD PRIMARY KEY (`id`), ADD KEY `idPerson` (`idPerson`,`idPlace`,`updatedBy`), ADD KEY `updatedBy` (`updatedBy`), ADD KEY `idPlace` (`idPlace`);

--
-- Indices de la tabla `acc_person`
--
ALTER TABLE `acc_person`
  ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `number` (`number`);

--
-- Indices de la tabla `acc_place`
--
ALTER TABLE `acc_place`
  ADD PRIMARY KEY (`id`), ADD KEY `updatedBy` (`updatedBy`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `acc_accesslog`
--
ALTER TABLE `acc_accesslog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1;
--
-- AUTO_INCREMENT de la tabla `acc_person`
--
ALTER TABLE `acc_person`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `acc_place`
--
ALTER TABLE `acc_place`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `acc_accesslog`
--
ALTER TABLE `acc_accesslog`
ADD CONSTRAINT `acc_accesslog_ibfk_1` FOREIGN KEY (`idPerson`) REFERENCES `acc_person` (`id`),
ADD CONSTRAINT `acc_accesslog_ibfk_2` FOREIGN KEY (`idPlace`) REFERENCES `acc_place` (`id`),
ADD CONSTRAINT `acc_accesslog_ibfk_3` FOREIGN KEY (`updatedBy`) REFERENCES `acc_person` (`id`);

--
-- Filtros para la tabla `acc_place`
--
ALTER TABLE `acc_place`
ADD CONSTRAINT `acc_place_ibfk_1` FOREIGN KEY (`updatedBy`) REFERENCES `acc_person` (`id`);


--
-- USUARIO 
--
GRANT USAGE ON *.* TO 'bitacorausrdos'@'localhost' IDENTIFIED BY PASSWORD '*E2D086B0906C8217A48779C3FEF5862E7F926ABA';

GRANT SELECT, INSERT, UPDATE, DELETE ON `bitacoradb`.* TO 'bitacorausrdos'@'localhost';
