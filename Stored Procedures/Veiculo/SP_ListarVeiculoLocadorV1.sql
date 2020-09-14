USE [DBLOKANDO]
GO

/****** Object:  StoredProcedure [dbo].[SP_ListarVeiculoLocadorV1]    Script Date: 24/02/2020 08:59:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <04/08/2019>
-- Description:	<Lista de Veiculos do Locador>
-- =============================================
CREATE PROCEDURE [dbo].[SP_ListarVeiculoLocadorV1]
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select * From DBLOKANDO..TBVEICLOK)
	BEGIN			
		PRINT 'Não foi possível listar veículos. Não existe nenhum registro na base de dados.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Select * From DBLOKANDO..TBVEICLOK 
			INNER JOIN TBLOCLOK ON VCCODLCDLOK = LCIDLOCLOK
		where VCSITLOK <> 'I' order by VCCODLCDLOK desc
		COMMIT
	END
END
GO





