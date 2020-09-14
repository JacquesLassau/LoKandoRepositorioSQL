USE [DBLOKANDO]
GO

/****** Object:  StoredProcedure [dbo].[SP_SelecionarLocadorDocV1]    Script Date: 13/01/2020 07:54:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <27/12/2019>
-- Description:	<Selecionar Locador por documento>
-- =============================================
CREATE PROCEDURE [dbo].[SP_SelecionarLocadorDocV1] 
	@LCPFPJLOK varchar(100)
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select LCPFPJLOK From DBLOKANDO..TBLOCLOK With(nolock) Where LCPFPJLOK = @LCPFPJLOK And LCSITLOK <> 'I')
	BEGIN			
		PRINT 'Documento do locador inválido. Não foi possível realizar a consulta.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Select * from  DBLOKANDO..TBLOCLOK With(nolock) Where LCPFPJLOK = @LCPFPJLOK;
		PRINT 'Locador foi selecionado com sucesso.'
		COMMIT
	END
END
GO


