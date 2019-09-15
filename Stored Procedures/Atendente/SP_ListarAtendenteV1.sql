USE [DB_LOKANDO]
GO
/****** Object:  StoredProcedure [dbo].[SP_ListarAtendenteV1]    Script Date: 31/07/2019 05:50:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <23/07/2019>
-- Description:	<Lista de Atendente>
-- =============================================
CREATE PROCEDURE [dbo].[SP_ListarAtendenteV1]	
AS
BEGIN												
	BEGIN TRAN 
	IF NOT EXISTS (Select * From DB_LOKANDO..TBATNDLOK)
	BEGIN			
		PRINT 'Não foi possível listar atendentes. Não existe nenhum registro na base de dados.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Select * From DB_LOKANDO..TBATNDLOK Where ATSITATLOK <> 'I';
		COMMIT
	END
END
GO


