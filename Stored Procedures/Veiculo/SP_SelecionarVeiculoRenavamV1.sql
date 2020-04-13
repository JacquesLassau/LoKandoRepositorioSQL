USE [DB_LOKANDO]
GO

/****** Object:  StoredProcedure [dbo].[SP_SelecionarVeiculoRenavamV1]    Script Date: 17/02/2020 08:05:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <11/02/2020>
-- Description:	<Selecionar Veiculo por Renavam>
-- =============================================
CREATE PROCEDURE [dbo].[SP_SelecionarVeiculoRenavamV1] 
	@VCRNVLOK varchar(100)
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select VCRNVLOK From DB_LOKANDO..TBVEICLOK With(nolock) Where VCRNVLOK = @VCRNVLOK And VCSITLOK <> 'I')
	BEGIN			
		PRINT 'Renavam do veículo inválido. Não foi possível realizar a consulta.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Select * from  DB_LOKANDO..TBVEICLOK With(nolock) Where VCRNVLOK = @VCRNVLOK;
		PRINT 'Renavam selecionada com sucesso.'
		COMMIT
	END
END
GO


