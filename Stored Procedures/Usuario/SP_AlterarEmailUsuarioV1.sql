USE [DB_LOKANDO]
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
	IF NOT EXISTS (Select USEMAILLOK From DB_LOKANDO..TBUSULOK With(nolock) Where USEMAILLOK = @EmailUsuario And USSITLOK <> 'I')
	BEGIN			
		PRINT 'Acesso Negado! Não é possível alterar um usuário sem e-mail no sistema!'
		ROLLBACK
	END	
	ELSE
	BEGIN
		declare @USUIDUSU int = (Select USIDUSU From DB_LOKANDO..TBUSULOK With(nolock) Where USEMAILLOK = @EmailUsuario);
		declare @USTPUSULOK char = (Select USTPUSULOK From DB_LOKANDO..TBUSULOK With(nolock) Where USEMAILLOK = @EmailUsuario);
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