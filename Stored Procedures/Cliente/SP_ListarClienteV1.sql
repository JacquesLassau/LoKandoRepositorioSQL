USE [DBLOKANDO]
GO
/****** Object:  StoredProcedure [dbo].[SP_ListarClienteV1]    Script Date: 04/08/2019 16:52:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <04/08/2019>
-- Description:	<Lista de Clientes>
-- =============================================
CREATE PROCEDURE [dbo].[SP_ListarClienteV1]
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select * From DBLOKANDO..TBCLIENTLOK)
	BEGIN			
		PRINT 'Não foi possível listar clientes. Não existe nenhum registro na base de dados.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Select * From DBLOKANDO..TBCLIENTLOK Where CLSITLOK <> 'I';
		COMMIT
	END
END
GO


