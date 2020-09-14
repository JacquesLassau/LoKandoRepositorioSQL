USE [DBLOKANDO]
GO
/****** Object:  StoredProcedure [dbo].[SP_SelecionarClienteV1]    Script Date: 04/08/2019 16:45:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <04/08/2019>
-- Description:	<Selecionar Cliente>
-- =============================================
CREATE PROCEDURE [dbo].[SP_SelecionarClienteIdV1] 
	@CLIDCLLOK int	
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select CLIDCLLOK From DBLOKANDO..TBCLIENTLOK With(nolock) Where CLIDCLLOK = @CLIDCLLOK And CLSITLOK <> 'I')
	BEGIN			
		PRINT 'Código do cliente inválido. Não foi possível realizar a consulta.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Select * from  DBLOKANDO..TBCLIENTLOK With(nolock) Where CLIDCLLOK = @CLIDCLLOK;
		PRINT 'Cliente foi selecionado com sucesso.'
		COMMIT
	END
END
GO