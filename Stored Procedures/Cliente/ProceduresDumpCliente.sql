
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
		PRINT 'Código do cliente inválido. Não foi possível realizar a consulta.'
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
		PRINT 'Habilitação do cliente inválida. Não foi possível realizar a consulta.'
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
		PRINT 'E-mail do cliente inválido. Não foi possível realizar a consulta.'
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
		PRINT 'Cpf do cliente inválido. Não foi possível realizar a consulta.'
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
		PRINT 'Não foi possível listar clientes. Não existe nenhum registro na base de dados.'
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
-- Description:	<Exclusão do Cliente>
-- =============================================
CREATE PROCEDURE [dbo].[SP_ExcluirClienteV1] 
	@CLIDCLLOK int	
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select CLIDCLLOK From DBLOKANDO..TBCLIENTLOK With(nolock) Where CLIDCLLOK = @CLIDCLLOK)
	BEGIN			
		PRINT 'Código do cliente inválido. Não foi possível excluir o cliente.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		declare @IDUSUCLI int = (Select CLCODUSLOK From DBLOKANDO..TBCLIENTLOK With(nolock) Where CLIDCLLOK = @CLIDCLLOK);
		Update DBLOKANDO..TBCLIENTLOK Set CLSITLOK = 'I', CLHRREG = GETDATE() Where CLIDCLLOK = @CLIDCLLOK;
		Update DBLOKANDO..TBUSULOK Set USSITLOK = 'I', USUHRREG = GETDATE() Where USIDUSU = @IDUSUCLI;
		PRINT 'Cliente foi excluído com sucesso.'
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
		PRINT 'Acesso Negado! Não é possível incluir um cliente sem e-mail no sistema!'
		ROLLBACK
	END
	ELSE IF EXISTS (Select CLHABILLOK From DBLOKANDO..TBCLIENTLOK With(nolock) where CLHABILLOK = @CLHABILLOK)
	BEGIN
		PRINT 'Já existe um cliente vinculado a esta habilitação. Cliente não foi incluído.'		
		ROLLBACK
	END
	ELSE IF EXISTS (Select CLCPFLOK From DBLOKANDO..TBCLIENTLOK With(nolock) where CLCPFLOK = @CLCPFLOK)
	BEGIN
		PRINT 'Já existe um cliente vinculado a este cpf. Cliente não foi incluído.'		
		ROLLBACK
	END
	ELSE IF EXISTS (Select CLEMAILLOK From DBLOKANDO..TBCLIENTLOK With(nolock) where CLEMAILLOK = @CLEMAILLOK)
	BEGIN
		PRINT 'Já existe um cliente vinculado a este e-mail. Cliente não foi incluído.'		
		ROLLBACK
	END	
	ELSE
	BEGIN
		declare @IDUSUCLI int = (Select USIDUSU From DBLOKANDO..TBUSULOK with(nolock) where USEMAILLOK = @CLEMAILLOK);		
		Insert Into TBCLIENTLOK Values (@IDUSUCLI, @CLNOMELOK, @CLHABILLOK, @CLCPFLOK, @CLRGLOK, @CLNASCLOK, @CLEMAILLOK, @CLNMLOK, @CLLOGLOK, @CLBAIRROLOK, @CLCIDLOK, @CLUFLOK, @CLCEPLOK, @CLSITLOK, GETDATE());	
		PRINT 'Cliente foi incluído com sucesso.'
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
	IF NOT EXISTS (Select CLIDCLLOK From DBLOKANDO..TBCLIENTLOK With(nolock) Where CLIDCLLOK = @CLIDCLLOK)
	BEGIN			
		PRINT 'Código do cliente inválido. Não foi possível realizar a alteração.'
		ROLLBACK
	END
	ELSE IF EXISTS (Select CLUFLOK From DBLOKANDO..TBCLIENTLOK With(nolock) Where LEN(@CLUFLOK) <> 2)
	BEGIN
		PRINT 'Estado deve ser preenchido com duas letras. Cliente não foi alterado.'
		ROLLBACK
	END				
	ELSE IF EXISTS (Select CLCEPLOK From DBLOKANDO..TBCLIENTLOK With(nolock) Where LEN(@CLCEPLOK) <> 9) 
	BEGIN
		PRINT 'CEP deve ser preenchido no formato correto. Cliente não foi alterado.'
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