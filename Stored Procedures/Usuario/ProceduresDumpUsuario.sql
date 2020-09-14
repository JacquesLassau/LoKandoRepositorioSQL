USE DBLOKANDO 
GO
/****** Object:  StoredProcedure [dbo].[SP_SituacaoUsuarioV1]    Script Date: 15/07/2019 07:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <15/07/2019>
-- Description:	<Situacao do Usuário>
-- =============================================
CREATE PROCEDURE [dbo].[SP_SituacaoUsuarioV1]		
	@USIDUSU int,
	@USSITLOK char(1)
AS
BEGIN 
	BEGIN TRAN
	IF NOT EXISTS (Select USIDUSU From DBLOKANDO..TBUSULOK With(nolock) Where USIDUSU = @USIDUSU)
	BEGIN			
		PRINT 'Código do usuário inválido. Não foi possível mudar a situação.'
		ROLLBACK
	END	
	ELSE IF NOT EXISTS (Select @USSITLOK From DBLOKANDO..TBUSULOK With(nolock) Where @USSITLOK = 'A' Or @USSITLOK = 'I' Or @USSITLOK = 'B')
	BEGIN
		PRINT 'Dados inválidos. Não foi possível trocar a situação do usuário.'
		ROLLBACK
	END
	ELSE
	BEGIN
		Update DBLOKANDO..TBUSULOK Set USSITLOK = @USSITLOK, USUHRREG = GETDATE() Where USIDUSU = @USIDUSU;
		PRINT 'Situação do usuário foi trocada com sucesso.'
		COMMIT
	END
END
GO


GO
/****** Object:  StoredProcedure [dbo].[SP_SelecionarUsuarioEmailV1]    Script Date: 01/08/2019 07:16:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <15/07/2019>
-- Description:	<Selecionar Usuario por e-mail>
-- =============================================
CREATE PROCEDURE [dbo].[SP_SelecionarUsuarioEmailV1]	
	@USEMAILLOK varchar(100)
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select USEMAILLOK From DBLOKANDO..TBUSULOK With(nolock) Where USEMAILLOK = @USEMAILLOK And USSITLOK <> 'I')
	BEGIN			
		PRINT 'E-mail do atendente inválido. Não foi possível realizar a consulta.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Select * from  DBLOKANDO..TBUSULOK With(nolock) Where USEMAILLOK = @USEMAILLOK;
		PRINT 'Atendente foi selecionado com sucesso.'
		COMMIT
	END
END
GO

USE DBLOKANDO 
GO
/****** Object:  StoredProcedure [dbo].[SP_CadastrarUsuarioV1]    Script Date: 07/07/2019 12:41:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <07/07/2019>
-- Description:	<Inclusão de Novo Usuário>
-- =============================================
CREATE PROCEDURE [dbo].[SP_CadastrarUsuarioV1]		
	@USEMAILLOK varchar(100),
	@USSENHALOK varchar(100),
	@USTPUSULOK char(1),
	@USSITLOK char(1)		
AS
BEGIN 
	BEGIN TRAN
	IF EXISTS (Select USEMAILLOK From DBLOKANDO..TBUSULOK With(nolock) Where USEMAILLOK = @USEMAILLOK)
	BEGIN			
		PRINT 'Já existe um usuário vinculado a este e-mail. Usuário não foi incluído.'
		ROLLBACK
	END
	ELSE
	BEGIN
		Insert Into DBLOKANDO..TBUSULOK Values (@USEMAILLOK, @USSENHALOK, @USTPUSULOK, @USSITLOK, GETDATE());
		PRINT 'Usuário foi incluído com sucesso.'
		COMMIT
	END
END
GO

USE DBLOKANDO 
GO
/****** Object:  StoredProcedure [dbo].[SP_AlterarUsuarioV1]    Script Date: 15/07/2019 07:20:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <15/07/2019>
-- Description:	<Alteração de Usuário>
-- =============================================
CREATE PROCEDURE [dbo].[SP_AlterarUsuarioV1]		
	@USIDUSU int,
	@USSENHALOK varchar(100)
AS
BEGIN 
	BEGIN TRAN
	IF NOT EXISTS (Select USIDUSU From DBLOKANDO..TBUSULOK With(nolock) Where USIDUSU = @USIDUSU)
	BEGIN			
		PRINT 'Código do usuário inválido. Não foi possível realizar a alteração.'
		ROLLBACK
	END
	ELSE
	BEGIN
		Update DBLOKANDO..TBUSULOK Set USSENHALOK = @USSENHALOK, USUHRREG = GETDATE() Where USIDUSU = @USIDUSU;
		PRINT 'Usuário foi alterado com sucesso.'
		COMMIT
	END
END
GO


GO
/****** Object:  StoredProcedure [dbo].[SP_AlterarSenhaUsuarioV1]    Script Date: 13/07/2020 14:32:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <13/07/2020>
-- Description:	<Alterar senha de usuário>
-- =============================================
CREATE PROCEDURE [dbo].[SP_AlterarSenhaUsuarioV1]	
	@EmailUsuario varchar(100),
	@SenhaUsuario varchar(100),
	@NovaSenhaUsuario varchar(100)
AS
BEGIN
	BEGIN TRAN	
	IF NOT EXISTS (Select USEMAILLOK From DBLOKANDO..TBUSULOK With(nolock) Where USEMAILLOK = @EmailUsuario And USSENHALOK = @SenhaUsuario And USSITLOK <> 'I')
	BEGIN			
		PRINT 'Acesso Negado! Não é possível alterar um usuário sem e-mail no sistema!'
		ROLLBACK
	END	
	ELSE
	BEGIN
		UPDATE TBUSULOK Set USSENHALOK = @NovaSenhaUsuario Where USEMAILLOK = @EmailUsuario;
		PRINT 'Senha do usuário alterada com sucesso!'
		COMMIT
	END
END
GO


GO
/****** Object:  StoredProcedure [dbo].[SP_AlterarEmailUsuarioV1]    Script Date: 13/07/2020 07:48:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <13/07/2020>
-- Description:	<Alterar Email de usuário>
-- =============================================
CREATE PROCEDURE [dbo].[SP_AlterarEmailUsuarioV1]	
	@EmailUsuario varchar(100),
	@NovoEmailUsuario varchar(100)	
AS
BEGIN
	BEGIN TRAN	
	IF NOT EXISTS (Select USEMAILLOK From DBLOKANDO..TBUSULOK With(nolock) Where USEMAILLOK = @EmailUsuario And USSITLOK <> 'I')
	BEGIN			
		PRINT 'Acesso Negado! Não é possível alterar um usuário sem e-mail no sistema!'
		ROLLBACK
	END	
	ELSE
	BEGIN
		declare @USUIDUSU int = (Select USIDUSU From DBLOKANDO..TBUSULOK With(nolock) Where USEMAILLOK = @EmailUsuario);
		declare @USTPUSULOK char = (Select USTPUSULOK From DBLOKANDO..TBUSULOK With(nolock) Where USEMAILLOK = @EmailUsuario);
		IF (@USTPUSULOK = 'A')
		BEGIN			
			UPDATE TBUSULOK Set USEMAILLOK = @NovoEmailUsuario Where USIDUSU = @USUIDUSU;
			UPDATE TBATNDLOK Set ATEMAILLOK = @NovoEmailUsuario Where ATUSUATLOK = @USUIDUSU;
			PRINT 'Email alterado com sucesso.'
			COMMIT
		END
		ELSE IF (@USTPUSULOK = 'L')
		BEGIN
			UPDATE TBUSULOK Set USEMAILLOK = @NovoEmailUsuario Where USIDUSU = @USUIDUSU;
			UPDATE TBLOCLOK Set LCEMAILLOK = @NovoEmailUsuario Where LCCODUSLOK = @USUIDUSU;
			PRINT 'Email alterado com sucesso.'	
			COMMIT
		END
		ELSE IF (@USTPUSULOK = 'C')
		BEGIN
			UPDATE TBUSULOK Set USEMAILLOK = @NovoEmailUsuario Where USIDUSU = @USUIDUSU;
			UPDATE TBCLIENTLOK Set CLEMAILLOK = @NovoEmailUsuario Where CLCODUSLOK = @USUIDUSU;	
			PRINT 'Email alterado com sucesso.'
			COMMIT
		END
		ELSE
		BEGIN			
			PRINT 'Ocorreu um problema na alteração de email.'
			ROLLBACK
		END
	END
END
GO

USE DBLOKANDO
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <14/06/2020>
-- Description:	<Verificar acesso de Usuario por e-mail e senha>
-- ============================================= 
CREATE PROCEDURE [dbo].[SP_AcessoUsuarioV1]
	@USEMAILLOK varchar(100),
	@USSENHALOK varchar(100)
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select USEMAILLOK,USSENHALOK From DBLOKANDO..TBUSULOK With(nolock) Where USEMAILLOK = @USEMAILLOK And USSENHALOK = @USSENHALOK And USTPUSULOK = 'A' And USSITLOK = 'A')
	BEGIN			
		PRINT 'E-mail ou senha inválido.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Select USEMAILLOK,USSENHALOK From DBLOKANDO..TBUSULOK With(nolock) Where USEMAILLOK = @USEMAILLOK And USSENHALOK = @USSENHALOK And USTPUSULOK = 'A' And USSITLOK = 'A'
		COMMIT
	END
END
GO