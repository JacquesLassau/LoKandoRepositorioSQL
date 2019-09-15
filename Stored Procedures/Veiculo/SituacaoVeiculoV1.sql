USE DB_LOKANDO
GO
/****** Object:  StoredProcedure [dbo].[SituacaoVeiculoV1]    Script Date: 17/07/2019 07:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <17/07/2019>
-- Description:	<Alternar Situação do Veiculo>
-- =============================================
CREATE PROCEDURE [dbo].[SituacaoVeiculoV1]		
	@VCIDLOK int,	
	@VCSITLOK char(1)
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select VCIDLOK From DB_LOKANDO..TBVEICLOK With(nolock) Where VCIDLOK = @VCIDLOK)
	BEGIN			
		PRINT 'Código do veiculo inválido. Não foi possível mudar a situação.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Update DB_LOKANDO..TBVEICLOK Set VCSITLOK = @VCSITLOK, VCHRREGLOK = GETDATE() Where VCIDLOK = @VCIDLOK;
		PRINT 'Situação do veículo foi trocada com sucesso.'
		COMMIT
	END	
END
GO