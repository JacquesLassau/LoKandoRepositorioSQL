USE [DB_LOKANDO]
GO
/****** Object:  StoredProcedure [dbo].[SP_SelecionarClienteCpfV1]    Script Date: 01/08/2019 09:10:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <09/09/2019>
-- Description:	<Selecionar Cliente por Cpf>
-- =============================================
CREATE PROCEDURE [dbo].SP_SelecionarClienteCpfV1
	@CLCPFLOK varchar(100)
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select CLCPFLOK From DB_LOKANDO..TBCLIENTLOK With(nolock) Where CLCPFLOK = @CLCPFLOK And CLSITLOK <> 'I')
	BEGIN			
		PRINT 'Cpf do cliente inválido. Não foi possível realizar a consulta.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Select * from  DB_LOKANDO..TBCLIENTLOK With(nolock) Where CLCPFLOK = @CLCPFLOK;
		PRINT 'Cliente foi selecionado com sucesso.'
		COMMIT
	END
END
GO


