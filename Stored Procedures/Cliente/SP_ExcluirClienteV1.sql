USE [DBLOKANDO]
GO
/****** Object:  StoredProcedure [dbo].[SP_ExcluirClienteV1]    Script Date: 04/08/2019 17:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <04/08/2019>
-- Description:	<Exclusão do Cliente>
-- =============================================
CREATE PROCEDURE [dbo].[SP_ExcluirClienteV1] 
	@CLIDCLLOK int	
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select CLIDCLLOK From DBLOKANDO..TBCLIENTLOK With(nolock) Where CLIDCLLOK = @CLIDCLLOK)
	BEGIN			
		PRINT 'Código do cliente inválido. Não foi possível excluir o cliente.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		declare @IDUSUCLI int = (Select CLCODUSLOK From DBLOKANDO..TBCLIENTLOK With(nolock) Where CLIDCLLOK = @CLIDCLLOK);
		Update DBLOKANDO..TBCLIENTLOK Set CLSITLOK = 'I', CLHRREG = GETDATE() Where CLIDCLLOK = @CLIDCLLOK;
		Update DBLOKANDO..TBUSULOK Set USSITLOK = 'I', USUHRREG = GETDATE() Where USIDUSU = @IDUSUCLI;
		PRINT 'Cliente foi excluído com sucesso.'
		COMMIT
	END
END
GO


