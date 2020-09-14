USE [DBLOKANDO]
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


