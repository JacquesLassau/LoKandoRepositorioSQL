USE [DBLOKANDO]
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