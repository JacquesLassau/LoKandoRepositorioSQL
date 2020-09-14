USE [DBLOKANDO]
GO

/****** Object:  StoredProcedure [dbo].[SP_ListarClienteV1]    Script Date: 28/01/2020 08:23:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <04/08/2019>
-- Description:	<Lista de Clientes>
-- =============================================
CREATE PROCEDURE [dbo].[SP_ListarLocadorV1]
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select * From DBLOKANDO..TBLOCLOK)
	BEGIN			
		PRINT 'Não foi possível listar locadores. Não existe nenhum registro na base de dados.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Select * From DBLOKANDO..TBLOCLOK Where LCSITLOK <> 'I';
		COMMIT
	END
END
GO


