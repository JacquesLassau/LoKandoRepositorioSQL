
GO
/****** Object:  StoredProcedure [dbo].[SP_AlterarAtendenteV1]    Script Date: 31/07/2019 06:29:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <15/07/2019>
-- Description:	<Altera��o de Atendente>
-- =============================================
CREATE PROCEDURE [dbo].[SP_AlterarAtendenteV1]	
	@ATIDATLOK int,
	@ATNOMELOK varchar(100),
	@ATSITATLOK char(1)
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select ATIDATLOK From DBLOKANDO..TBATNDLOK With(nolock) Where ATIDATLOK = @ATIDATLOK)
	BEGIN			
		PRINT 'C�digo do atendente inv�lido. N�o foi poss�vel realizar a altera��o.'
		ROLLBACK
	END
	ELSE IF NOT EXISTS (Select @ATSITATLOK From DBLOKANDO..TBATNDLOK With(nolock) Where @ATSITATLOK = 'A' Or @ATSITATLOK = 'I' Or @ATSITATLOK = 'B')
	BEGIN
		PRINT 'Dados inv�lidos. N�o foi poss�vel alterar o atendente.'
		ROLLBACK
	END
	ELSE
	BEGIN
		declare @IDUSUATEND int = (Select ATUSUATLOK From DBLOKANDO..TBATNDLOK With(nolock) Where ATIDATLOK = @ATIDATLOK);		 		
		Update DBLOKANDO..TBATNDLOK Set ATNOMELOK = @ATNOMELOK, ATSITATLOK = @ATSITATLOK, ATHRREG = GETDATE() Where ATIDATLOK = @ATIDATLOK;
		Update DBLOKANDO..TBUSULOK Set USSITLOK = @ATSITATLOK, USUHRREG = GETDATE() Where USIDUSU = @IDUSUATEND;
		PRINT 'Atendente foi alterado com sucesso.'
		COMMIT
	END
END
GO

GO
/****** Object:  StoredProcedure [dbo].[SP_SelecionarAtendenteIdV1]    Script Date: 01/08/2019 07:16:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <15/07/2019>
-- Description:	<Selecionar Atendente por Id>
-- =============================================
CREATE PROCEDURE [dbo].[SP_SelecionarAtendenteIdV1] 
	@ATIDATLOK int	
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select ATIDATLOK From DBLOKANDO..TBATNDLOK With(nolock) Where ATIDATLOK = @ATIDATLOK And ATSITATLOK <> 'I')
	BEGIN			
		PRINT 'C�digo do atendente inv�lido. N�o foi poss�vel realizar a consulta.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Select * from  DBLOKANDO..TBATNDLOK With(nolock) Where ATIDATLOK = @ATIDATLOK;
		PRINT 'Atendente foi selecionado com sucesso.'
		COMMIT
	END
END
GO

GO
/****** Object:  StoredProcedure [dbo].[SP_CadastrarAtendenteV1]    Script Date: 31/07/2019 05:48:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <07/07/2019>
-- Description:	<Inclus�o de Novo Atendente>
-- =============================================
CREATE PROCEDURE [dbo].[SP_CadastrarAtendenteV1]	
	@ATNOMELOK varchar(100),
	@ATEMAILLOK varchar(100),
	@ATSITATLOK	char(1)	
AS
BEGIN
	BEGIN TRAN	
	IF NOT EXISTS (Select USEMAILLOK From DBLOKANDO..TBUSULOK With(nolock) Where USEMAILLOK = @ATEMAILLOK)
	BEGIN			
		PRINT 'Acesso Negado! N�o � poss�vel incluir um atendente sem e-mail no sistema!'
		ROLLBACK
	END
	ELSE IF EXISTS (Select ATEMAILLOK From DBLOKANDO..TBATNDLOK With(nolock) Where ATEMAILLOK = @ATEMAILLOK And ATSITATLOK <> 'I')
	BEGIN
		PRINT 'J� existe um atendente vinculado a este e-mail. Atendente n�o foi inclu�do.'		
		ROLLBACK
	END
	ELSE
	BEGIN
		declare @IDUSUATEND int = (Select USIDUSU From DBLOKANDO..TBUSULOK With(nolock) Where USEMAILLOK = @ATEMAILLOK);		 		
		Insert Into DBLOKANDO..TBATNDLOK Values (@IDUSUATEND, @ATNOMELOK, @ATEMAILLOK, @ATSITATLOK, GETDATE());
		PRINT 'Atendente foi inclu�do com sucesso.'
		COMMIT
	END
END
GO

GO
/****** Object:  StoredProcedure [dbo].[SP_ExcluirAtendenteV1]    Script Date: 01/08/2019 08:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <15/07/2019>
-- Description:	<Exclus�o do Atendente>
-- =============================================
CREATE PROCEDURE [dbo].[SP_ExcluirAtendenteV1] 
	@ATIDATLOK int	
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select ATIDATLOK From DBLOKANDO..TBATNDLOK With(nolock) Where ATIDATLOK = @ATIDATLOK)
	BEGIN			
		PRINT 'C�digo do atendente inv�lido. N�o foi poss�vel excluir o atendente.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		declare @IDUSUATEND int = (Select ATUSUATLOK From DBLOKANDO..TBATNDLOK With(nolock) Where ATIDATLOK = @ATIDATLOK);
		Update DBLOKANDO..TBATNDLOK Set ATSITATLOK = 'I', ATHRREG = GETDATE() Where ATIDATLOK = @ATIDATLOK;
		Update DBLOKANDO..TBUSULOK Set USSITLOK = 'I', USUHRREG = GETDATE() Where USIDUSU = @IDUSUATEND;
		PRINT 'Atendente foi exclu�do com sucesso.'
		COMMIT
	END
END
GO

GO
/****** Object:  StoredProcedure [dbo].[SP_ListarAtendenteV1]    Script Date: 31/07/2019 05:50:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <23/07/2019>
-- Description:	<Lista de Atendente>
-- =============================================
CREATE PROCEDURE [dbo].[SP_ListarAtendenteV1]	
AS
BEGIN												
	BEGIN TRAN 
	IF NOT EXISTS (Select * From DBLOKANDO..TBATNDLOK)
	BEGIN			
		PRINT 'N�o foi poss�vel listar atendentes. N�o existe nenhum registro na base de dados.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Select * From DBLOKANDO..TBATNDLOK Where ATSITATLOK <> 'I';
		COMMIT
	END
END
GO

GO
/****** Object:  StoredProcedure [dbo].[SP_SelecionarAtendenteEmailV1]    Script Date: 01/08/2019 07:16:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <15/07/2019>
-- Description:	<Selecionar Atendente por e-mail>
-- =============================================
CREATE PROCEDURE [dbo].[SP_SelecionarAtendenteEmailV1] 
	@ATEMAILLOK varchar(100)
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select ATEMAILLOK From DBLOKANDO..TBATNDLOK With(nolock) Where ATEMAILLOK = @ATEMAILLOK And ATSITATLOK <> 'I')
	BEGIN			
		PRINT 'E-mail do atendente inv�lido. N�o foi poss�vel realizar a consulta.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Select * from DBLOKANDO..TBATNDLOK With(nolock) Where ATEMAILLOK = @ATEMAILLOK;
		PRINT 'Atendente foi selecionado com sucesso.'
		COMMIT
	END
END
GO
