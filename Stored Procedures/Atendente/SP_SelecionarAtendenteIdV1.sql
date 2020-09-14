USE [DBLOKANDO]
GO
/****** Object:  StoredProcedure [dbo].[SP_SelecionarAtendenteIdV1]    Script Date: 01/08/2019 07:16:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <15/07/2019>
-- Description:	<Selecionar Atendente por Id>
-- =============================================
CREATE PROCEDURE [dbo].[SP_SelecionarAtendenteIdV1] 
	@ATIDATLOK int	
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select ATIDATLOK From DBLOKANDO..TBATNDLOK With(nolock) Where ATIDATLOK = @ATIDATLOK And ATSITATLOK <> 'I')
	BEGIN			
		PRINT 'Código do atendente inválido. Não foi possível realizar a consulta.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Select * from  DBLOKANDO..TBATNDLOK With(nolock) Where ATIDATLOK = @ATIDATLOK;
		PRINT 'Atendente foi selecionado com sucesso.'
		COMMIT
	END
END
GO



