USE DB_LOKANDO
GO
/****** Object:  StoredProcedure [dbo].[SP_CadastrarClienteV1]    Script Date: 09/07/2019 07:21:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <07/07/2019>
-- Description:	<Inclusão de Novo Cliente>
-- =============================================
CREATE PROCEDURE [dbo].[SP_CadastrarClienteV1]	
	@CLNOMELOK varchar(100),
	@CLHABILLOK varchar(100),
	@CLCPFLOK varchar(14),
	@CLRGLOK varchar(20),
	@CLNASCLOK datetime,
	@CLEMAILLOK varchar(100),
	@CLNMLOK varchar(100),
	@CLLOGLOK varchar(100),
	@CLCIDLOK varchar(100),
	@CLUFLOK varchar(2),
	@CLCEPLOK varchar(9),
	@CLSITLOK char(1)	
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select USEMAILLOK From DB_LOKANDO..TBUSULOK With(nolock) where USEMAILLOK = @CLEMAILLOK)
	BEGIN			
		PRINT 'Acesso Negado! Não é possível incluir um cliente sem e-mail no sistema!'
		ROLLBACK
	END
	ELSE IF EXISTS (Select CLHABILLOK From DB_LOKANDO..TBCLIENTLOK With(nolock) where CLHABILLOK = @CLHABILLOK)
	BEGIN
		PRINT 'Já existe um cliente vinculado a esta habilitação. Cliente não foi incluído.'		
		ROLLBACK
	END
	ELSE IF EXISTS (Select CLCPFLOK From DB_LOKANDO..TBCLIENTLOK With(nolock) where CLCPFLOK = @CLCPFLOK)
	BEGIN
		PRINT 'Já existe um cliente vinculado a este cpf. Cliente não foi incluído.'		
		ROLLBACK
	END
	ELSE IF EXISTS (Select CLEMAILLOK From DB_LOKANDO..TBCLIENTLOK With(nolock) where CLEMAILLOK = @CLEMAILLOK)
	BEGIN
		PRINT 'Já existe um cliente vinculado a este e-mail. Cliente não foi incluído.'		
		ROLLBACK
	END	
	ELSE
	BEGIN
		declare @IDUSUCLI int = (Select USIDUSU From DB_LOKANDO..TBUSULOK with(nolock) where USEMAILLOK = @CLEMAILLOK);		
		Insert Into TBCLIENTLOK Values (@IDUSUCLI, @CLNOMELOK, @CLHABILLOK, @CLCPFLOK, @CLRGLOK, @CLNASCLOK, @CLEMAILLOK, @CLNMLOK, @CLLOGLOK, @CLCIDLOK, @CLUFLOK, @CLCEPLOK, @CLSITLOK, GETDATE());	
		PRINT 'Cliente foi incluído com sucesso.'
		COMMIT
	END	
END
GO