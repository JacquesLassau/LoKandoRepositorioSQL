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