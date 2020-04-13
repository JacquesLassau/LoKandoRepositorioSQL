USE [DB_LOKANDO]
GO

/****** Object:  StoredProcedure [dbo].[SP_SelecionarLocadorEmailV1]    Script Date: 27/12/2019 08:09:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <27/12/2019>
-- Description:	<Selecionar Locador por e-mail>
-- =============================================
CREATE PROCEDURE [dbo].[SP_SelecionarLocadorEmailV1] 
	@LCEMAILLOK varchar(100)
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select LCEMAILLOK From DB_LOKANDO..TBLOCLOK With(nolock) Where LCEMAILLOK = @LCEMAILLOK And LCSITLOK <> 'I')
	BEGIN			
		PRINT 'E-mail do locador inválido. Não foi possível realizar a consulta.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Select * from  DB_LOKANDO..TBLOCLOK With(nolock) Where LCEMAILLOK = @LCEMAILLOK;
		PRINT 'Locador foi selecionado com sucesso.'
		COMMIT
	END
END
GO




