
GO
/****** Object:  StoredProcedure [dbo].[SP_SelecionarClienteV1]    Script Date: 04/08/2019 16:45:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <04/08/2019>
-- Description:	<Selecionar Cliente>
-- =============================================
CREATE PROCEDURE [dbo].[SP_SelecionarClienteIdV1] 
	@CLIDCLLOK int	
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select CLIDCLLOK From DBLOKANDO..TBCLIENTLOK With(nolock) Where CLIDCLLOK = @CLIDCLLOK And CLSITLOK <> 'I')
	BEGIN			
		PRINT 'C�digo do cliente inv�lido. N�o foi poss�vel realizar a consulta.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Select * from  DBLOKANDO..TBCLIENTLOK With(nolock) Where CLIDCLLOK = @CLIDCLLOK;
		PRINT 'Cliente foi selecionado com sucesso.'
		COMMIT
	END
END
GO


GO
/****** Object:  StoredProcedure [dbo].[SP_SelecionarClienteHabilitacaoV1]    Script Date: 01/08/2019 09:10:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <09/09/2019>
-- Description:	<Selecionar Cliente por Habilitacao>
-- =============================================
CREATE PROCEDURE [dbo].[SP_SelecionarClienteHabilitacaoV1]
	@CLHABILLOK varchar(100)
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select CLHABILLOK From DBLOKANDO..TBCLIENTLOK With(nolock) Where CLHABILLOK = @CLHABILLOK And CLSITLOK <> 'I')
	BEGIN			
		PRINT 'Habilita��o do cliente inv�lida. N�o foi poss�vel realizar a consulta.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Select * from  DBLOKANDO..TBCLIENTLOK With(nolock) Where CLHABILLOK = @CLHABILLOK;
		PRINT 'Cliente foi selecionado com sucesso.'
		COMMIT
	END
END
GO


GO
/****** Object:  StoredProcedure [dbo].[SP_SelecionarClienteEmailV1]    Script Date: 01/08/2019 07:16:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <15/07/2019>
-- Description:	<Selecionar Cliente por e-mail>
-- =============================================
CREATE PROCEDURE [dbo].[SP_SelecionarClienteEmailV1] 
	@CLEMAILLOK varchar(100)
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select CLEMAILLOK From DBLOKANDO..TBCLIENTLOK With(nolock) Where CLEMAILLOK = @CLEMAILLOK And CLSITLOK <> 'I')
	BEGIN			
		PRINT 'E-mail do cliente inv�lido. N�o foi poss�vel realizar a consulta.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Select * from  DBLOKANDO..TBCLIENTLOK With(nolock) Where CLEMAILLOK = @CLEMAILLOK;
		PRINT 'Cliente foi selecionado com sucesso.'
		COMMIT
	END
END
GO


GO
/****** Object:  StoredProcedure [dbo].[SP_SelecionarClienteCpfV1]    Script Date: 01/08/2019 09:10:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <09/09/2019>
-- Description:	<Selecionar Cliente por Cpf>
-- =============================================
CREATE PROCEDURE [dbo].SP_SelecionarClienteCpfV1
	@CLCPFLOK varchar(100)
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select CLCPFLOK From DBLOKANDO..TBCLIENTLOK With(nolock) Where CLCPFLOK = @CLCPFLOK And CLSITLOK <> 'I')
	BEGIN			
		PRINT 'Cpf do cliente inv�lido. N�o foi poss�vel realizar a consulta.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Select * from  DBLOKANDO..TBCLIENTLOK With(nolock) Where CLCPFLOK = @CLCPFLOK;
		PRINT 'Cliente foi selecionado com sucesso.'
		COMMIT
	END
END
GO


GO
/****** Object:  StoredProcedure [dbo].[SP_ListarClienteV1]    Script Date: 04/08/2019 16:52:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <04/08/2019>
-- Description:	<Lista de Clientes>
-- =============================================
CREATE PROCEDURE [dbo].[SP_ListarClienteV1]
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select * From DBLOKANDO..TBCLIENTLOK)
	BEGIN			
		PRINT 'N�o foi poss�vel listar clientes. N�o existe nenhum registro na base de dados.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Select * From DBLOKANDO..TBCLIENTLOK Where CLSITLOK <> 'I';
		COMMIT
	END
END
GO


GO
/****** Object:  StoredProcedure [dbo].[SP_ExcluirClienteV1]    Script Date: 04/08/2019 17:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <04/08/2019>
-- Description:	<Exclus�o do Cliente>
-- =============================================
CREATE PROCEDURE [dbo].[SP_ExcluirClienteV1] 
	@CLIDCLLOK int	
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select CLIDCLLOK From DBLOKANDO..TBCLIENTLOK With(nolock) Where CLIDCLLOK = @CLIDCLLOK)
	BEGIN			
		PRINT 'C�digo do cliente inv�lido. N�o foi poss�vel excluir o cliente.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		declare @IDUSUCLI int = (Select CLCODUSLOK From DBLOKANDO..TBCLIENTLOK With(nolock) Where CLIDCLLOK = @CLIDCLLOK);
		Update DBLOKANDO..TBCLIENTLOK Set CLSITLOK = 'I', CLHRREG = GETDATE() Where CLIDCLLOK = @CLIDCLLOK;
		Update DBLOKANDO..TBUSULOK Set USSITLOK = 'I', USUHRREG = GETDATE() Where USIDUSU = @IDUSUCLI;
		PRINT 'Cliente foi exclu�do com sucesso.'
		COMMIT
	END
END
GO


GO

/****** Object:  StoredProcedure [dbo].[SP_CadastrarClienteV1]    Script Date: 15/04/2020 08:45:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <07/07/2019>
-- Description:	<Inclus�o de Novo Cliente>
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
	@CLBAIRROLOK varchar(100),
	@CLCIDLOK varchar(100),
	@CLUFLOK varchar(2),
	@CLCEPLOK varchar(9),
	@CLSITLOK char(1)	
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select USEMAILLOK From DBLOKANDO..TBUSULOK With(nolock) where USEMAILLOK = @CLEMAILLOK)
	BEGIN			
		PRINT 'Acesso Negado! N�o � poss�vel incluir um cliente sem e-mail no sistema!'
		ROLLBACK
	END
	ELSE IF EXISTS (Select CLHABILLOK From DBLOKANDO..TBCLIENTLOK With(nolock) where CLHABILLOK = @CLHABILLOK)
	BEGIN
		PRINT 'J� existe um cliente vinculado a esta habilita��o. Cliente n�o foi inclu�do.'		
		ROLLBACK
	END
	ELSE IF EXISTS (Select CLCPFLOK From DBLOKANDO..TBCLIENTLOK With(nolock) where CLCPFLOK = @CLCPFLOK)
	BEGIN
		PRINT 'J� existe um cliente vinculado a este cpf. Cliente n�o foi inclu�do.'		
		ROLLBACK
	END
	ELSE IF EXISTS (Select CLEMAILLOK From DBLOKANDO..TBCLIENTLOK With(nolock) where CLEMAILLOK = @CLEMAILLOK)
	BEGIN
		PRINT 'J� existe um cliente vinculado a este e-mail. Cliente n�o foi inclu�do.'		
		ROLLBACK
	END	
	ELSE
	BEGIN
		declare @IDUSUCLI int = (Select USIDUSU From DBLOKANDO..TBUSULOK with(nolock) where USEMAILLOK = @CLEMAILLOK);		
		Insert Into TBCLIENTLOK Values (@IDUSUCLI, @CLNOMELOK, @CLHABILLOK, @CLCPFLOK, @CLRGLOK, @CLNASCLOK, @CLEMAILLOK, @CLNMLOK, @CLLOGLOK, @CLBAIRROLOK, @CLCIDLOK, @CLUFLOK, @CLCEPLOK, @CLSITLOK, GETDATE());	
		PRINT 'Cliente foi inclu�do com sucesso.'
		COMMIT
	END	
END
GO


GO
/****** Object:  StoredProcedure [dbo].[SP_AlterarClienteV1]    Script Date: 22/11/2019 07:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <16/07/2019>
-- Description:	<Altera��o de Cliente>
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
	IF NOT EXISTS (Select CLIDCLLOK From DBLOKANDO..TBCLIENTLOK With(nolock) Where CLIDCLLOK = @CLIDCLLOK)
	BEGIN			
		PRINT 'C�digo do cliente inv�lido. N�o foi poss�vel realizar a altera��o.'
		ROLLBACK
	END
	ELSE IF EXISTS (Select CLUFLOK From DBLOKANDO..TBCLIENTLOK With(nolock) Where LEN(@CLUFLOK) <> 2)
	BEGIN
		PRINT 'Estado deve ser preenchido com duas letras. Cliente n�o foi alterado.'
		ROLLBACK
	END				
	ELSE IF EXISTS (Select CLCEPLOK From DBLOKANDO..TBCLIENTLOK With(nolock) Where LEN(@CLCEPLOK) <> 9) 
	BEGIN
		PRINT 'CEP deve ser preenchido no formato correto. Cliente n�o foi alterado.'
		ROLLBACK
	END
	ELSE
	BEGIN
		declare @IDUSUCLI int = (Select CLCODUSLOK From DBLOKANDO..TBCLIENTLOK With(nolock) Where CLIDCLLOK = @CLIDCLLOK);		
		Update DBLOKANDO..TBCLIENTLOK Set CLNOMELOK = @CLNOMELOK, CLRGLOK = @CLRGLOK, CLNASCLOK = @CLNASCLOK, CLNMLOK = @CLNMLOK, CLLOGLOK = @CLLOGLOK, CLBAIRROLOK = @CLBAIRROLOK, CLCIDLOK = @CLCIDLOK, CLUFLOK = @CLUFLOK, CLCEPLOK = @CLCEPLOK, CLSITLOK = @CLSITLOK, CLHRREG = GETDATE() Where CLIDCLLOK = @CLIDCLLOK;
		Update DBLOKANDO..TBUSULOK Set USSITLOK = @CLSITLOK, USUHRREG = GETDATE() Where USIDUSU = @IDUSUCLI;
		PRINT 'Cliente foi alterado com sucesso.'
		COMMIT
	END	
END