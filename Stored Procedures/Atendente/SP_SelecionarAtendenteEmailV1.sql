USE [DBLOKANDO]
GO
/****** Object:  StoredProcedure [dbo].[SP_SelecionarAtendenteEmailV1]    Script Date: 01/08/2019 07:16:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <15/07/2019>
-- Description:	<Selecionar Atendente por e-mail>
-- =============================================
CREATE PROCEDURE [dbo].[SP_SelecionarAtendenteEmailV1] 
	@ATEMAILLOK varchar(100)
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select ATEMAILLOK From DBLOKANDO..TBATNDLOK With(nolock) Where ATEMAILLOK = @ATEMAILLOK And ATSITATLOK <> 'I')
	BEGIN			
		PRINT 'E-mail do atendente inv�lido. N�o foi poss�vel realizar a consulta.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Select * from DBLOKANDO..TBATNDLOK With(nolock) Where ATEMAILLOK = @ATEMAILLOK;
		PRINT 'Atendente foi selecionado com sucesso.'
		COMMIT
	END
END
GO
