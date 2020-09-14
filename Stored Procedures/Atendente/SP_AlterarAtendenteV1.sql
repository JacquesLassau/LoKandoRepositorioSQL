USE [DBLOKANDO]
GO
/****** Object:  StoredProcedure [dbo].[SP_AlterarAtendenteV1]    Script Date: 31/07/2019 06:29:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <15/07/2019>
-- Description:	<Alteração de Atendente>
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
		PRINT 'Código do atendente inválido. Não foi possível realizar a alteração.'
		ROLLBACK
	END
	ELSE IF NOT EXISTS (Select @ATSITATLOK From DBLOKANDO..TBATNDLOK With(nolock) Where @ATSITATLOK = 'A' Or @ATSITATLOK = 'I' Or @ATSITATLOK = 'B')
	BEGIN
		PRINT 'Dados inválidos. Não foi possível alterar o atendente.'
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


