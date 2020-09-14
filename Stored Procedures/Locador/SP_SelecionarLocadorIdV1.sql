USE [DBLOKANDO]
GO

/****** Object:  StoredProcedure [dbo].[SP_SelecionarLocadorIdV1]    Script Date: 28/01/2020 07:40:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <27/12/2019>
-- Description:	<Selecionar Locador por Código>
-- =============================================
CREATE PROCEDURE [dbo].[SP_SelecionarLocadorIdV1] 
	@LCIDLOCLOK int
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select LCIDLOCLOK From DBLOKANDO..TBLOCLOK With(nolock) Where LCIDLOCLOK = @LCIDLOCLOK And LCSITLOK <> 'I')
	BEGIN			
		PRINT 'Código do locador inválido. Não foi possível realizar a consulta.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Select * from  DBLOKANDO..TBLOCLOK With(nolock) Where LCIDLOCLOK = @LCIDLOCLOK;
		PRINT 'Locador foi selecionado com sucesso.'
		COMMIT
	END
END
GO


