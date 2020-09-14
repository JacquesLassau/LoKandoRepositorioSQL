USE [DBLOKANDO]
GO

/****** Object:  StoredProcedure [dbo].[SP_ListarVeiculoV1]    Script Date: 17/02/2020 14:07:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <04/08/2019>
-- Description:	<Lista de CVeiculos>
-- =============================================
CREATE PROCEDURE [dbo].[SP_ListarVeiculoV1]
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select * From DBLOKANDO..TBVEICLOK)
	BEGIN			
		PRINT 'Não foi possível listar veiculos. Não existe nenhum registro na base de dados.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Select * From DBLOKANDO..TBVEICLOK Where VCSITLOK <> 'I';
		COMMIT
	END
END
GO


