USE [DB_LOKANDO]
GO
/****** Object:  StoredProcedure [dbo].[SP_ExcluirAtendenteV1]    Script Date: 01/08/2019 08:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <15/07/2019>
-- Description:	<Exclusão do Atendente>
-- =============================================
CREATE PROCEDURE [dbo].[SP_ExcluirAtendenteV1] 
	@ATIDATLOK int	
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select ATIDATLOK From DB_LOKANDO..TBATNDLOK With(nolock) Where ATIDATLOK = @ATIDATLOK)
	BEGIN			
		PRINT 'Código do atendente inválido. Não foi possível excluir o atendente.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		declare @IDUSUATEND int = (Select ATUSUATLOK From DB_LOKANDO..TBATNDLOK With(nolock) Where ATIDATLOK = @ATIDATLOK);
		Update DB_LOKANDO..TBATNDLOK Set ATSITATLOK = 'I', ATHRREG = GETDATE() Where ATIDATLOK = @ATIDATLOK;
		Update DB_LOKANDO..TBUSULOK Set USSITLOK = 'I', USUHRREG = GETDATE() Where USIDUSU = @IDUSUATEND;
		PRINT 'Atendente foi excluído com sucesso.'
		COMMIT
	END
END
GO


