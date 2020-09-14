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