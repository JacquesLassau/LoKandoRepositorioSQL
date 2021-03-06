USE [master]
GO

CREATE DATABASE [DB_LOKANDO]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DB_LOKANDO', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\DB_LOKANDO.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DB_LOKANDO_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\DB_LOKANDO_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO

ALTER DATABASE [DB_LOKANDO] SET COMPATIBILITY_LEVEL = 140
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DB_LOKANDO].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [DB_LOKANDO] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [DB_LOKANDO] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [DB_LOKANDO] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [DB_LOKANDO] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [DB_LOKANDO] SET ARITHABORT OFF 
GO

ALTER DATABASE [DB_LOKANDO] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [DB_LOKANDO] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [DB_LOKANDO] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [DB_LOKANDO] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [DB_LOKANDO] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [DB_LOKANDO] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [DB_LOKANDO] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [DB_LOKANDO] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [DB_LOKANDO] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [DB_LOKANDO] SET  DISABLE_BROKER 
GO

ALTER DATABASE [DB_LOKANDO] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [DB_LOKANDO] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [DB_LOKANDO] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [DB_LOKANDO] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [DB_LOKANDO] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [DB_LOKANDO] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [DB_LOKANDO] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [DB_LOKANDO] SET RECOVERY FULL 
GO

ALTER DATABASE [DB_LOKANDO] SET  MULTI_USER 
GO

ALTER DATABASE [DB_LOKANDO] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [DB_LOKANDO] SET DB_CHAINING OFF 
GO

ALTER DATABASE [DB_LOKANDO] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [DB_LOKANDO] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [DB_LOKANDO] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [DB_LOKANDO] SET QUERY_STORE = OFF
GO

ALTER DATABASE [DB_LOKANDO] SET  READ_WRITE 
GO


