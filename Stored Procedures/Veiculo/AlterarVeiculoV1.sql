USE DB_LOKANDO
GO
/****** Object:  StoredProcedure [dbo].[AlterarVeiculoV1]    Script Date: 17/07/2019 07:33:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <17/07/2019>
-- Description:	<Alteração de Veiculo>
-- =============================================
CREATE PROCEDURE [dbo].[AlterarVeiculoV1]		
	@VCIDLOK int,	
	@VCCOMBLOK varchar(100),
	@VCCORLOK varchar(100),
	@VCVLRDIA decimal,
	@VCAPOLICELOK varchar(100)	
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select VCIDLOK From DB_LOKANDO..TBVEICLOK With(nolock) Where VCIDLOK = @VCIDLOK)
	BEGIN			
		PRINT 'Código do veículo inválido. Não foi possível realizar a alteração.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Update DB_LOKANDO..TBVEICLOK Set VCCOMBLOK = @VCCOMBLOK, VCCORLOK = @VCCORLOK, VCVLRDIA = @VCVLRDIA, VCAPOLICELOK = @VCAPOLICELOK, VCHRREGLOK = GETDATE() Where VCIDLOK = @VCIDLOK;
		PRINT 'Veiculo foi incluído com sucesso.'
		COMMIT
	END	
END
GO


