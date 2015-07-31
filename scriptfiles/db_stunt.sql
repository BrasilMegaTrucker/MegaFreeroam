-- phpMyAdmin SQL Dump
-- version 4.4.10
-- http://www.phpmyadmin.net
--
-- Host: ip.brasilmegatrucker.com
-- Tempo de geração: 31/07/2015 às 11:33
-- Versão do servidor: 5.5.41-MariaDB
-- Versão do PHP: 5.4.35

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `mf_test`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `areas`
--

CREATE TABLE IF NOT EXISTS `areas` (
  `id` int(11) NOT NULL,
  `Nome` varchar(128) NOT NULL,
  `Gang` int(11) NOT NULL,
  `Localizacao` varchar(200) NOT NULL,
  `Centro` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `corridas`
--

CREATE TABLE IF NOT EXISTS `corridas` (
  `ID` int(11) NOT NULL,
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
  `MaxCheckpoints` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Sistema de Corrida by NicK';

-- --------------------------------------------------------

--
-- Estrutura para tabela `gangs`
--

CREATE TABLE IF NOT EXISTS `gangs` (
  `id` int(11) NOT NULL,
  `Nome` varchar(128) NOT NULL,
  `Lider` int(11) NOT NULL,
  `SubLider` int(11) NOT NULL,
  `Cor` int(11) NOT NULL,
  `TAG` varchar(5) NOT NULL,
  `Membros` varchar(200) NOT NULL,
  `Areas` varchar(200) NOT NULL,
  `Descricao` varchar(128) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `gpci`
--

CREATE TABLE IF NOT EXISTS `gpci` (
  `ID` int(11) NOT NULL,
  `Serial` varchar(256) NOT NULL,
  `Nome` varchar(24) NOT NULL,
  `IP` varchar(16) NOT NULL,
  `Motivo` varchar(128) NOT NULL,
  `Data` varchar(50) NOT NULL,
  `DesbanAuto` int(11) NOT NULL,
  `Ignorar` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios`
--

CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int(11) NOT NULL,
  `Nome` varchar(24) NOT NULL,
  `Senha` varchar(128) NOT NULL,
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
  `Colisao` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Índices de tabelas apagadas
--

--
-- Índices de tabela `areas`
--
ALTER TABLE `areas`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `corridas`
--
ALTER TABLE `corridas`
  ADD PRIMARY KEY (`ID`);

--
-- Índices de tabela `gangs`
--
ALTER TABLE `gangs`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `gpci`
--
ALTER TABLE `gpci`
  ADD PRIMARY KEY (`ID`);

--
-- Índices de tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de tabelas apagadas
--

--
-- AUTO_INCREMENT de tabela `areas`
--
ALTER TABLE `areas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de tabela `corridas`
--
ALTER TABLE `corridas`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de tabela `gangs`
--
ALTER TABLE `gangs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de tabela `gpci`
--
ALTER TABLE `gpci`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
