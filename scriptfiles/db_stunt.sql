-- phpMyAdmin SQL Dump
-- version 4.1.8
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: 15-Abr-2014 às 13:30
-- Versão do servidor: 5.5.36-cll
-- PHP Version: 5.4.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `brasilm1_stunt`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `areas`
--

CREATE TABLE IF NOT EXISTS `areas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Nome` varchar(128) NOT NULL,
  `Gang` int(11) NOT NULL,
  `Localizacao` varchar(200) NOT NULL,
  `Centro` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=27 ;

--
-- Extraindo dados da tabela `areas`
--

INSERT INTO `areas` (`id`, `Nome`, `Gang`, `Localizacao`, `Centro`) VALUES
(4, '#1', 1, ' 122.27,-310.06, 346.22,  12.26', ' 239.61,-126.43,   1.57'),
(5, '', 0, ' 600.39,-652.70, 852.47,-470.42', ' 713.96,-539.67,  16.33'),
(6, '', 0, ' 805.48,-1158.93, 967.11,-954.37', ' 884.85,-1072.88,  24.36'),
(7, '', 0, ' 968.96,-1156.18,1095.64,-939.78', '1025.84,-1049.20,  31.72'),
(8, '', 0, ' 642.77,-1328.51, 801.90,-1035.80', ' 703.90,-1231.80,  16.64'),
(10, '', 0, '1074.30,-2094.04,1283.97,-1982.10', '1179.42,-2037.15,  69.00'),
(11, '#2', 1, '1688.23,-2175.00,1828.15,-1992.54', '1746.35,-2112.16,  13.47'),
(12, '', 0, '1826.30,-2173.48,1968.28,-1963.36', '1885.10,-2002.94,  13.54'),
(13, '', 0, '1812.00,-1941.96,1951.97,-1746.29', '1858.08,-1849.44,  13.58'),
(14, '', 0, '1957.14,-1941.44,2084.25,-1745.14', '2014.91,-1817.67,  13.54'),
(15, '', 0, '1991.00,-1743.69,2097.48,-1548.84', '2042.27,-1687.76,  13.54'),
(16, '', 0, '2197.09,-1757.12,2539.07,-1629.46', '2495.33,-1686.83,  13.51'),
(17, '', 0, '2191.30,-1978.11,2422.18,-1755.26', '2299.61,-1822.28,  13.54'),
(19, '', 0, '2059.32,-1388.07,2268.56,-1069.01', '2144.36,-1208.57,  23.90'),
(20, '', 0, '-1762.44,-197.58,-1454.37, 236.41', '-1646.31,  92.46, -11.15'),
(21, '', 0, '-2246.13,-198.01,-2157.19,  40.02', '-2186.17, -75.82,  35.32'),
(22, '', 0, '-2157.66, -75.85,-2073.44,  35.89', '-2115.22,  -6.36,  35.32'),
(24, '', 0, '-2246.53,  46.47,-2114.74, 206.66', '-2204.40, 116.78,  35.41'),
(25, '', 0, '-2373.02,-191.20,-2247.06,  61.12', '-2308.57, -52.18,  35.71'),
(26, '', 0, '-365.34, 970.20,  96.97,1236.32', '-116.35,1138.92,  19.74');

-- --------------------------------------------------------

--
-- Estrutura da tabela `corridas`
--

CREATE TABLE IF NOT EXISTS `corridas` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CorridaNome` varchar(128) NOT NULL,
  `CorridaTipo` int(11) NOT NULL,
  `CorridaPremio` int(11) NOT NULL,
  `CorridaRecord` int(11) NOT NULL,
  `RecordBy` int(11) NOT NULL,
  `CheckpointsX` longtext NOT NULL,
  `CheckpointsY` longtext NOT NULL,
  `CheckpointsZ` longtext NOT NULL,
  `InicioX` float NOT NULL,
  `InicioY` float NOT NULL,
  `InicioZ` float NOT NULL,
  `MaximoParticipantes` int(11) NOT NULL,
  `Veiculo` int(11) NOT NULL,
  `MaxCheckpoints` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Sistema de Corrida by NicK' AUTO_INCREMENT=17 ;

--
-- Extraindo dados da tabela `corridas`
--

INSERT INTO `corridas` (`ID`, `CorridaNome`, `CorridaTipo`, `CorridaPremio`, `CorridaRecord`, `RecordBy`, `CheckpointsX`, `CheckpointsY`, `CheckpointsZ`, `InicioX`, `InicioY`, `InicioZ`, `MaximoParticipantes`, `Veiculo`, `MaxCheckpoints`) VALUES
(1, 'Twister', 1, 150000, 0, 0, ' 763.33, 935.16, 845.01, 910.48, 887.94, 916.57, 843.53, 938.29, 861.40,1025.05,', ' 476.25, 457.12, 376.29, 486.54, 358.36, 373.93, 495.50, 392.77, 504.26, 611.40,', ' 617.57, 611.71, 600.06, 587.71, 574.02, 549.39, 536.74, 525.03, 512.54, 511.33,', 738.09, 465.45, 620.45, 10, 0, 10),
(2, 'Drag 1', 1, 100000, 0, 0, '2487.63,2155.02,1970.23,1832.45,', '-222.86,-155.30,-117.44, -89.21,', '  70.77,  70.77,  70.77,  70.77,', 2534.14, -232.44, 70.97, 2, 411, 4),
(3, 'Hydra', 2, 250000, 0, 0, '1470.00,1569.28,1337.18, 816.02, 414.92, 149.36,-108.27,-143.26, 131.84, 435.02, 904.53,1762.07,2421.60,2712.28,2716.86,2281.25,2056.06,1751.97,1444.17,', '1645.19,1965.15,2360.26,2624.08,2609.48,2503.99,2331.62,1917.30,1627.89,1481.26,1270.98,1083.89,1053.51,1655.53,2198.87,2577.39,2438.61,2164.47,1629.52,', '  49.46,  64.29, 116.28,  69.52, 109.63, 175.43, 124.33,  46.36,  36.30,  37.66,  36.73,  58.79,  69.73,  38.40,  28.00,  58.66, 169.34,  99.40,  11.57,', 1475.49, 1414.7, 11.77, 6, 520, 19),
(4, 'Nascar', 1, 200000, 0, 0, '1928.56,1789.67,1822.20,1820.13,1814.67,1871.30,1788.44,', '-2458.72,-2428.25,-2347.65,-2464.22,-2457.86,-2327.99,-2453.43,', ' 474.60, 466.31, 448.67, 429.38, 413.89, 408.63, 393.58,', 1784.94, -2392.84, 486.14, 4, 503, 7),
(5, 'Circuito LV', 1, 150000, 0, 0, '3215.23,3242.27,3393.56,3592.58,3657.83,3553.75,3462.69,3451.73,3511.82,3460.57,3413.49,3292.79,3175.01,3238.28,3600.21,3644.46,3553.40,3450.79,3516.49,3413.46,3299.36,3172.25,3215.43,', '1198.55,1087.57,1098.54,1152.40,1276.79,1609.57,1658.67,1533.08,1338.53,1240.67,1385.48,1473.82,1365.94,1099.80,1156.39,1318.22,1612.94,1537.76,1328.61,1333.45,1474.26,1380.07,1198.39,', '  12.49,  12.49,  12.49,  12.49,  12.49,  12.49,  12.49,  12.49,  12.49,  12.49,  12.49,  12.47,  12.49,  12.49,  12.49,  12.49,  12.49,  12.49,  12.49,  12.49,  12.48,  12.49,  12.49,', 3276.48, 1264.62, 18.04, 10, 502, 23),
(6, 'Deserto LV', 1, 350000, 0, 0, ' 649.37, 662.78, 650.85, 765.27, 455.39, 281.79, -75.57,-276.05,-488.22,-763.39,-1193.47,-1325.15,-1435.27,-1341.90,-1221.54,-1112.37,-886.29,-823.68,-668.78,-480.34,-195.29, 119.81, 218.20, 185.84, 340.94, 485.66, 628.43,', '1800.50,1987.57,2331.71,2626.15,2662.26,2734.50,2637.03,2633.93,2716.99,2730.19,2689.95,2647.63,2456.23,2105.66,1874.17,1757.89,1662.23,1375.64,1225.75,1055.52, 806.11, 888.17, 966.61,1140.47,1383.21,1652.65,1744.18,', '   5.19,   6.87,  26.81,  17.13,  55.49,  59.56,  63.56,  62.38,  64.97,  45.28,  45.59,  49.74,  60.16,  49.10,  40.84,  33.72,  26.82,  13.33,  12.12,  10.75,  20.70,  21.36,  27.92,  14.39,   6.86,  14.21,   4.93,', 646.45, 1780.89, 4.97, 10, 411, 27),
(7, 'Drag 2', 1, 100000, 0, 0, '-1987.33,-1987.99,', '-859.96,-724.34,', '  31.77,  31.77,', -1987.61, -1003.62, 31.78, 2, 0, 2),
(8, 'Drag 3', 1, 100000, 0, 0, '-2261.13,-2260.97,-2260.59,', ' 620.15, 934.50,1180.76,', '  44.83,  66.25,  55.32,', -2260.78, 521.75, 34.84, 4, 0, 3),
(9, 'Drag 4', 1, 100000, 0, 0, '-2681.60,', '2144.86,', '  55.31,', -2680.01, 1244.46, 55.36, 4, 0, 1),
(10, 'Drift 1', 1, 85000, 0, 0, '-295.54,-340.36,-329.82,-389.00,-438.12,', '1426.18,1444.15,1353.47,1403.09,1437.58,', '  72.30,  66.16,  54.90,  40.83,  32.99,', -301.89, 1517.08, 75.02, 2, 562, 5),
(11, 'Drag 5', 1, 100000, 0, 0, '1787.11,1788.27,1787.27,', '2020.08,1442.99, 863.25,', '   3.71,   6.46,  10.37,', 1787.92, 2292.54, 5.46, 3, 411, 3),
(12, 'Corrida Teste', 1, 300000, 0, 0, '-298.18,-295.20,-312.82,-335.00,-362.07,-373.75,-334.17,-325.02,-361.24,-385.89,-418.66,-445.65,-449.84,-434.07,-396.70,-381.89,-389.10,-423.04,-432.02,-422.70,-451.94,-468.71,-477.49,-454.29,-401.54,-382.12,-419.67,-462.60,-522.62,-618.83,-790.44,-873.74,', '1456.72,1419.73,1399.76,1435.10,1463.10,1432.40,1364.67,1319.25,1345.86,1396.01,1444.70,1484.50,1529.93,1647.95,1747.19,1841.00,1890.34,1917.27,1868.39,1800.49,1761.98,1822.22,1901.24,1981.65,2033.89,2078.13,2067.01,2020.46,1985.49,2042.77,2046.64,1932.32,', '  73.79,  72.15,  71.73,  67.31,  63.38,  60.27,  55.65,  52.77,  48.24,  41.81,  34.72,  34.09,  35.89,  35.61,  42.16,  51.36,  56.09,  57.10,  62.46,  69.29,  71.78,  77.88,  84.54,  79.13,  65.30,  60.51,  61.22,  60.10,  60.11,  60.00,  60.10,  59.90,', -301.84, 1502.76, 75.27, 15, 411, 32),
(13, 'Corrida Drag', 1, 300000, 0, 0, '2443.24,2345.02,2236.78,2069.78,1938.30,1857.86,', '-213.65,-193.60,-171.51,-137.73,-111.17, -94.79,', '  70.77,  70.77,  70.77,  70.77,  70.77,  70.77,', 2521.91, -229.76, 70.94, 15, 411, 6),
(14, 'Circuito', 1, 500000, 0, 0, '3235.60,3289.80,3378.74,3479.20,3566.28,3670.48,3644.63,3606.68,3564.45,3510.16,3434.88,3455.77,3492.74,3516.68,3505.08,3415.76,3413.09,3345.52,3233.39,3165.73,3198.60,', '1114.67,1070.21,1094.46,1122.21,1146.63,1202.52,1323.60,1444.52,1571.83,1663.30,1634.46,1511.65,1399.99,1322.57,1255.92,1280.64,1398.06,1466.25,1478.35,1421.46,1268.51,', '  12.60,  12.60,  12.32,  12.32,  12.32,  12.32,  12.32,  12.32,  12.32,  12.32,  12.32,  12.32,  12.32,  12.32,  12.32,  12.32,  12.32,  12.32,  12.31,  12.32,  12.32,', 3213.81, 1205.18, 12.6, 15, 0, 21),
(15, 'Corrida Rural', 1, 700000, 0, 0, '1560.28,1560.18,1553.97,1523.54,1440.84,1372.37,1312.43,1276.70,1226.74,1187.18,1091.08, 984.22, 847.59, 790.86, 659.89, 557.84, 504.91, 412.05, 315.44,', '  -1.94, -45.77,-123.06,-176.97,-212.93,-211.76,-188.50,-163.34,-118.85, -87.22, -62.21, -83.77,-102.70,-127.02,-196.49,-204.60,-233.14,-304.79,-360.12,', '  22.76,  21.08,  18.47,  13.80,   8.83,   6.87,  20.03,  34.34,  39.37,  36.59,  18.37,  21.00,  26.31,  22.26,  12.80,  16.69,  13.00,   8.94,   9.55,', 1558.63, 12.86, 24.08, 20, 531, 19),
(16, 'Corrida de Jesus', 2, 500000, 0, 0, '1227.09,1226.17,1218.75,1170.98, 905.16, 645.11, 178.35, -16.65,-368.42,-569.35,-880.64,-1202.69,-1412.67,-1524.15,-1497.53,', '1601.05,1754.70,2042.18,2297.93,2507.66,2619.81,2631.91,2596.37,2547.41,2514.49,2433.03,2348.41,2233.25,1892.94,1603.63,', '  31.53,  69.59, 117.00, 146.05, 136.77, 140.29, 156.84, 139.79, 109.08, 111.91, 178.81, 184.51, 153.80,  89.57,  80.09,', 1222.75, 1414.62, 7.46, 20, 520, 15);

-- --------------------------------------------------------

--
-- Estrutura da tabela `gangs`
--

CREATE TABLE IF NOT EXISTS `gangs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Nome` varchar(128) NOT NULL,
  `Lider` int(11) NOT NULL,
  `SubLider` int(11) NOT NULL,
  `Cor` int(11) NOT NULL,
  `TAG` varchar(5) NOT NULL,
  `Membros` varchar(200) NOT NULL,
  `Areas` varchar(200) NOT NULL,
  `Descricao` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Extraindo dados da tabela `gangs`
--

INSERT INTO `gangs` (`id`, `Nome`, `Lider`, `SubLider`, `Cor`, `TAG`, `Membros`, `Areas`, `Descricao`) VALUES
(3, 'Grove Street', 15, 23, 640040, '[GS]', '', '1,7,', 'Gang oficial da Grove Street');

-- --------------------------------------------------------

--
-- Estrutura da tabela `gpci`
--

CREATE TABLE IF NOT EXISTS `gpci` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Serial` varchar(256) NOT NULL,
  `Nome` varchar(24) NOT NULL,
  `IP` varchar(16) NOT NULL,
  `Motivo` varchar(128) NOT NULL,
  `Data` varchar(50) NOT NULL,
  `DesbanAuto` int(11) NOT NULL,
  `Ignorar` varchar(200) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Extraindo dados da tabela `gpci`
--

INSERT INTO `gpci` (`ID`, `Serial`, `Nome`, `IP`, `Motivo`, `Data`, `DesbanAuto`, `Ignorar`) VALUES
(1, 'EFCF89D5CFED8C90ACE8988FD98C4FADF85CD89D', '_Krusher', '200.171.51.13', 'Teste #1', '22/03/2014', 1395957624, '');

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuarios`
--

CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Nome` varchar(24) NOT NULL,
  `Senha` varchar(50) NOT NULL,
  `Level` int(11) NOT NULL,
  `Dinheiro` int(11) NOT NULL,
  `Score` int(11) NOT NULL,
  `Gold` int(11) NOT NULL,
  `Morreu` int(11) NOT NULL,
  `Matou` int(11) NOT NULL,
  `Registrado` varchar(50) NOT NULL,
  `UltimoLogin` int(11) NOT NULL,
  `Mudo` int(11) NOT NULL,
  `TempoJogado` int(11) NOT NULL,
  `Email` varchar(128) NOT NULL,
  `VeiculoModelo` int(11) NOT NULL,
  `VeiculoCor1` int(11) NOT NULL,
  `VeiculoCor2` int(11) NOT NULL,
  `Neon` int(11) NOT NULL,
  `VeiculoPintura` int(11) NOT NULL,
  `Aerofolio` int(11) NOT NULL,
  `Capô` int(11) NOT NULL,
  `Teto` int(11) NOT NULL,
  `SaiasLaterais` int(11) NOT NULL,
  `Farois` int(11) NOT NULL,
  `Nitro` int(11) NOT NULL,
  `Descarga` int(11) NOT NULL,
  `Rodas` int(11) NOT NULL,
  `Stereo` int(11) NOT NULL,
  `Hidraulica` int(11) NOT NULL,
  `SaiaDianteira` int(11) NOT NULL,
  `SaiaTrazeira` int(11) NOT NULL,
  `VentDireito` int(11) NOT NULL,
  `VentEsquerdo` int(11) NOT NULL,
  `Corridas` int(11) NOT NULL,
  `PontosDrift` int(11) NOT NULL,
  `ModoDrift` int(11) NOT NULL,
  `Teclas` int(11) NOT NULL,
  `ExibirDano` int(11) NOT NULL,
  `Gang` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=93 ;


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
