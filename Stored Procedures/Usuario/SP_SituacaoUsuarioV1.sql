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


