USE [DBLOKANDO]
GO

/****** Object:  StoredProcedure [dbo].[SP_SelecionarVeiculoPlacaV1]    Script Date: 11/02/2020 08:00:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <11/02/2020>
-- Description:	<Selecionar Veiculo por Placa>
-- =============================================
CREATE PROCEDURE [dbo].[SP_SelecionarVeiculoPlacaV1] 
	@VCPLACALOK varchar(7)
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select VCPLACALOK From DBLOKANDO..TBVEICLOK With(nolock) Where VCPLACALOK = @VCPLACALOK And VCSITLOK <> 'I')
	BEGIN			
		PRINT 'Placa do veículo inválida. Não foi possível realizar a consulta.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Select * from  DBLOKANDO..TBVEICLOK With(nolock) Where VCPLACALOK = @VCPLACALOK;
		PRINT 'placa selecionada com sucesso.'
		COMMIT
	END
END
GO


