USE DBLOKANDO
GO
/****** Object:  StoredProcedure [dbo].[SP_ExcluirVeiculoV1]    Script Date: 17/07/2019 07:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <17/07/2019>
-- Description:	<Exclusão do Veiculo>
-- =============================================
CREATE PROCEDURE [dbo].[SP_ExcluirVeiculoV1]		
	@VCPLACALOK varchar(7)
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select VCPLACALOK From DBLOKANDO..TBVEICLOK With(nolock) Where VCPLACALOK = @VCPLACALOK and VCSITLOK <> 'I')
	BEGIN			
		PRINT 'Placa do veiculo não existe. Não foi possível mudar a situação.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Update DBLOKANDO..TBVEICLOK Set VCSITLOK = 'I', VCHRREGLOK = GETDATE() Where VCPLACALOK = @VCPLACALOK;
		PRINT 'Veículo excluído com sucesso.'
		COMMIT
	END	
END
GO