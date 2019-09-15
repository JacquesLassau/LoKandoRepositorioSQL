USE [DB_LOKANDO]
GO
/****** Object:  StoredProcedure [dbo].[SP_SelecionarClienteEmailV1]    Script Date: 01/08/2019 07:16:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <15/07/2019>
-- Description:	<Selecionar Cliente por e-mail>
-- =============================================
CREATE PROCEDURE [dbo].[SP_SelecionarClienteEmailV1] 
	@CLEMAILLOK varchar(100)
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select CLEMAILLOK From DB_LOKANDO..TBCLIENTLOK With(nolock) Where CLEMAILLOK = @CLEMAILLOK And CLSITLOK <> 'I')
	BEGIN			
		PRINT 'E-mail do cliente inválido. Não foi possível realizar a consulta.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Select * from  DB_LOKANDO..TBCLIENTLOK With(nolock) Where CLEMAILLOK = @CLEMAILLOK;
		PRINT 'Cliente foi selecionado com sucesso.'
		COMMIT
	END
END
GO


