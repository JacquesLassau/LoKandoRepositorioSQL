USE DB_LOKANDO
GO
/****** Object:  StoredProcedure [dbo].[SituacaoLocadorV1]    Script Date: 16/07/2019 13:01:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <16/07/2019>
-- Description:	<Alternar Situação do Locador>
-- =============================================
CREATE PROCEDURE [dbo].[SituacaoLocadorV1]		
	@LCIDLOCLOK int,	
	@LCSITLOK char(1)	
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select LCIDLOCLOK From DB_LOKANDO..TBLOCLOK With(nolock) Where LCIDLOCLOK = @LCIDLOCLOK)
	BEGIN			
		PRINT 'Código do locador inválido. Não foi possível mudar a situação.'
		ROLLBACK
	END
	ELSE IF NOT EXISTS (Select @LCSITLOK From DB_LOKANDO..TBLOCLOK With(nolock) Where @LCSITLOK = 'A' Or @LCSITLOK = 'I' Or @LCSITLOK = 'B')
	BEGIN
		PRINT 'Dados inválidos. Não foi possível trocar a situação do locador.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Update DB_LOKANDO..TBLOCLOK Set LCSITLOK = @LCSITLOK, LCUHRREG = GETDATE() Where LCIDLOCLOK = @LCIDLOCLOK;
		PRINT 'Situação do locador foi trocada com sucesso.'
		COMMIT
	END	
END
GO