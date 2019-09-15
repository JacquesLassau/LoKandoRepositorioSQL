USE [DB_LOKANDO]
GO
/****** Object:  StoredProcedure [dbo].[SP_SelecionarClienteHabilitacaoV1]    Script Date: 01/08/2019 09:10:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <09/09/2019>
-- Description:	<Selecionar Cliente por Habilitacao>
-- =============================================
CREATE PROCEDURE [dbo].[SP_SelecionarClienteHabilitacaoV1]
	@CLHABILLOK varchar(100)
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select CLHABILLOK From DB_LOKANDO..TBCLIENTLOK With(nolock) Where CLHABILLOK = @CLHABILLOK And CLSITLOK <> 'I')
	BEGIN			
		PRINT 'Habilitação do cliente inválida. Não foi possível realizar a consulta.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Select * from  DB_LOKANDO..TBCLIENTLOK With(nolock) Where CLHABILLOK = @CLHABILLOK;
		PRINT 'Cliente foi selecionado com sucesso.'
		COMMIT
	END
END
GO


