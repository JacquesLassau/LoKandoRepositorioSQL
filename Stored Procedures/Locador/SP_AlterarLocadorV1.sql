USE [DBLOKANDO]
GO

/****** Object:  StoredProcedure [dbo].[SP_AlterarLocadorV1]    Script Date: 14/04/2020 08:59:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <29/01/2020>
-- Description:	<Altera��o de Locador>
-- =============================================
CREATE PROCEDURE [dbo].[SP_AlterarLocadorV1]
	@LCIDLOCLOK int,	
	@LCRZSLOK varchar(100),
	@LCFANTLOK varchar(100),	
	@LCNMLOK varchar(100),
	@LCLOGLOK varchar(100),
	@LCBAIRROLOK varchar(100),
	@LCCIDLOK varchar(100),
	@LCUFLOK varchar(2),
	@LCCEPLOK varchar(10),	
	@LCSITLOK char(1)	
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select LCIDLOCLOK From DBLOKANDO..TBLOCLOK With(nolock) Where LCIDLOCLOK = @LCIDLOCLOK)
	BEGIN			
		PRINT 'C�digo do locador inv�lido. N�o foi poss�vel realizar a altera��o.'
		ROLLBACK
	END
	ELSE IF EXISTS (Select LCUFLOK From DBLOKANDO..TBLOCLOK With(nolock) Where LEN(@LCUFLOK) <> 2)
	BEGIN
		PRINT 'Estado deve ser preenchido com duas letras. Locador n�o foi alterado.'
		ROLLBACK
	END				
	ELSE IF EXISTS (Select LCCEPLOK From DBLOKANDO..TBLOCLOK With(nolock) Where LEN(@LCCEPLOK) <> 9) 
	BEGIN
		PRINT 'CEP deve ser preenchido no formato correto. Locador n�o foi alterado.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		declare @IDUSULOC int = (Select LCCODUSLOK From DBLOKANDO..TBLOCLOK With(nolock) Where LCIDLOCLOK = @LCIDLOCLOK);		
		Update DBLOKANDO..TBLOCLOK Set LCRZSLOK = @LCRZSLOK, LCFANTLOK = @LCFANTLOK, LCNMLOK = @LCNMLOK, LCLOGLOK = @LCLOGLOK, LCBAIRROLOK = @LCBAIRROLOK, LCCIDLOK = @LCCIDLOK, LCUFLOK = @LCUFLOK, LCCEPLOK = @LCCEPLOK, LCSITLOK = @LCSITLOK, LCUHRREG = GETDATE() Where LCIDLOCLOK = @LCIDLOCLOK;
		Update DBLOKANDO..TBUSULOK Set USSITLOK = @LCSITLOK, USUHRREG = GETDATE() Where USIDUSU = @IDUSULOC;		
		PRINT 'Locador foi alterado com sucesso.'
		COMMIT
	END	
END
GO


