USE [DB_LOKANDO]
GO

/****** Object:  StoredProcedure [dbo].[SP_AlterarLocadorV1]    Script Date: 29/01/2020 08:07:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <29/01/2020>
-- Description:	<Alteração de Locador>
-- =============================================
CREATE PROCEDURE [dbo].[SP_AlterarLocadorV1]
	@LCIDLOCLOK int,	
	@LCRZSLOK varchar(100),
	@LCFANTLOK varchar(100),	
	@LCNMLOK varchar(100),
	@LCLOGLOK varchar(100),
	@LCCIDLOK varchar(100),
	@LCUFLOK varchar(2),
	@LCCEPLOK varchar(10),	
	@LCSITLOK char(1)	
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select LCIDLOCLOK From DB_LOKANDO..TBLOCLOK With(nolock) Where LCIDLOCLOK = @LCIDLOCLOK)
	BEGIN			
		PRINT 'Código do locador inválido. Não foi possível realizar a alteração.'
		ROLLBACK
	END
	ELSE IF NOT EXISTS (Select LCUFLOK From DB_LOKANDO..TBLOCLOK With(nolock) Where LEN(@LCUFLOK) = 2)
	BEGIN
		PRINT 'Estado deve ser preenchido com duas letras. Locador não foi alterado.'
		ROLLBACK
	END				
	ELSE IF NOT EXISTS (Select LCCEPLOK From DB_LOKANDO..TBLOCLOK With(nolock) Where LEN(@LCCEPLOK) = 9) 
	BEGIN
		PRINT 'CEP deve ser preenchido no formato correto. Locador não foi alterado.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		declare @IDUSULOC int = (Select LCCODUSLOK From DB_LOKANDO..TBLOCLOK With(nolock) Where LCIDLOCLOK = @LCIDLOCLOK);		
		Update DB_LOKANDO..TBLOCLOK Set LCRZSLOK = @LCRZSLOK, LCFANTLOK = @LCFANTLOK, LCNMLOK = @LCNMLOK, LCLOGLOK = @LCLOGLOK, LCCIDLOK = @LCCIDLOK, LCUFLOK = @LCUFLOK, LCCEPLOK = @LCCEPLOK, LCSITLOK = @LCSITLOK, LCUHRREG = GETDATE() Where LCIDLOCLOK = @LCIDLOCLOK;
		Update DB_LOKANDO..TBUSULOK Set USSITLOK = @LCSITLOK, USUHRREG = GETDATE() Where USIDUSU = @IDUSULOC;		
		PRINT 'Locador foi alterado com sucesso.'
		COMMIT
	END	
END
GO


