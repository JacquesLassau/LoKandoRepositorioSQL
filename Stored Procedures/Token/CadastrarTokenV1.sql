USE DB_LOKANDO 
GO
/****** Object:  StoredProcedure [dbo].[CadastrarTokenV1]    Script Date: 11/07/2019 07:41:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <07/07/2019>
-- Description:	<Inclusão de Novo Token>
-- =============================================
CREATE PROCEDURE [dbo].[CadastrarTokenV1]		
	@TOKENLOK varchar(100),	
	@TKORIGEMLOK varchar(100),
	@TKDESTINOLOK varchar(100),
	@TKDTUTILLOK datetime,	
	@TKUTILUSULOK int ,	
	@TKRTNLOK varchar(8000),
	@TKVALIDLOK datetime
AS
BEGIN
	BEGIN TRAN
	declare @DTHRSYS datetime = GETDATE();
	IF (@TKVALIDLOK < @DTHRSYS)
	BEGIN			
		PRINT 'Validade do token não pode ser menor que a data do sistema. Token está vencido e não foi incluído'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Insert Into TBTOKENLOK Values (@TOKENLOK, GETDATE(), @TKORIGEMLOK, @TKDESTINOLOK, @TKDTUTILLOK, @TKUTILUSULOK, @TKRTNLOK, @TKVALIDLOK);
		PRINT 'Token foi incluído com sucesso.'
		COMMIT
	END	
END
GO
