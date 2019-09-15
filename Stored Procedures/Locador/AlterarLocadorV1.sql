USE DB_LOKANDO
GO
/****** Object:  StoredProcedure [dbo].[AlterarLocadorV1]    Script Date: 07/07/2019 13:01:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <07/07/2019>
-- Description:	<Alteração de Locador>
-- =============================================
CREATE PROCEDURE [dbo].[AlterarLocadorV1]		
	@LCIDLOCLOK int,	
	@LCRZSLOK varchar(100),
	@LCFANTLOK varchar(100),	
	@LCNMLOK varchar(100),
	@LCLOGLOK varchar(100),
	@LCCIDLOK varchar(100),
	@LCUFLOK varchar(2),
	@LCCEPLOK varchar(10)		
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select LCIDLOCLOK From DB_LOKANDO..TBLOCLOK Where LCIDLOCLOK = @LCIDLOCLOK)
	BEGIN			
		PRINT 'Código do locador inválido. Não foi possível realizar a alteração.'
		ROLLBACK
	END	
	ELSE IF EXISTS (Select LCUFLOK From DB_LOKANDO..TBLOCLOK With(nolock) Where @LCUFLOK <> 2)
	BEGIN
		PRINT 'Estado deve ser preenchido com duas letras. Locador não foi alterado.'
		ROLLBACK
	END
	ELSE IF EXISTS (Select LCCEPLOK From DB_LOKANDO..TBLOCLOK With(nolock) Where LCCEPLOK <> 10)
	BEGIN
		PRINT 'CEP deve ser preenchido no formato correto. Locador não foi alterado.'
		ROLLBACK
	END
	ELSE
	BEGIN
		Update DB_LOKANDO..TBLOCLOK Set LCRZSLOK = @LCRZSLOK, LCFANTLOK = @LCFANTLOK, LCNMLOK = @LCNMLOK, LCLOGLOK = @LCLOGLOK, LCCIDLOK = @LCCIDLOK, LCUFLOK = @LCUFLOK, LCCEPLOK = @LCCEPLOK, LCUHRREG = GETDATE() Where LCIDLOCLOK = @LCIDLOCLOK;
		PRINT 'Locador foi alterado com sucesso.'
		COMMIT
	END	
END
GO