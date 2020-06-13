USE [DB_LOKANDO]
GO
/****** Object:  StoredProcedure [dbo].[SP_AlterarClienteV1]    Script Date: 22/11/2019 07:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <16/07/2019>
-- Description:	<Alteração de Cliente>
-- =============================================
CREATE PROCEDURE [dbo].[SP_AlterarClienteV1] 
	@CLIDCLLOK int, 
	@CLNOMELOK varchar(100),	
	@CLRGLOK varchar(20),
	@CLNASCLOK datetime,	
	@CLNMLOK varchar(100),
	@CLLOGLOK varchar(100),
	@CLBAIRROLOK varchar(100),
	@CLCIDLOK varchar(100),
	@CLUFLOK varchar(2),
	@CLCEPLOK varchar(9),
	@CLSITLOK char(1)
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select CLIDCLLOK From DB_LOKANDO..TBCLIENTLOK With(nolock) Where CLIDCLLOK = @CLIDCLLOK)
	BEGIN			
		PRINT 'Código do cliente inválido. Não foi possível realizar a alteração.'
		ROLLBACK
	END
	ELSE IF EXISTS (Select CLUFLOK From DB_LOKANDO..TBCLIENTLOK With(nolock) Where LEN(@CLUFLOK) = 2)
	BEGIN
		PRINT 'Estado deve ser preenchido com duas letras. Cliente não foi alterado.'
		ROLLBACK
	END				
	ELSE IF EXISTS (Select CLCEPLOK From DB_LOKANDO..TBCLIENTLOK With(nolock) Where LEN(@CLCEPLOK) = 9) 
	BEGIN
		PRINT 'CEP deve ser preenchido no formato correto. Cliente não foi alterado.'
		ROLLBACK
	END
	ELSE
	BEGIN
		declare @IDUSUCLI int = (Select CLCODUSLOK From DB_LOKANDO..TBCLIENTLOK With(nolock) Where CLIDCLLOK = @CLIDCLLOK);		
		Update DB_LOKANDO..TBCLIENTLOK Set CLNOMELOK = @CLNOMELOK, CLRGLOK = @CLRGLOK, CLNASCLOK = @CLNASCLOK, CLNMLOK = @CLNMLOK, CLLOGLOK = @CLLOGLOK, CLBAIRROLOK = @CLBAIRROLOK, CLCIDLOK = @CLCIDLOK, CLUFLOK = @CLUFLOK, CLCEPLOK = @CLCEPLOK, CLSITLOK = @CLSITLOK, CLHRREG = GETDATE() Where CLIDCLLOK = @CLIDCLLOK;
		Update DB_LOKANDO..TBUSULOK Set USSITLOK = @CLSITLOK, USUHRREG = GETDATE() Where USIDUSU = @IDUSUCLI;
		PRINT 'Cliente foi alterado com sucesso.'
		COMMIT
	END	
END