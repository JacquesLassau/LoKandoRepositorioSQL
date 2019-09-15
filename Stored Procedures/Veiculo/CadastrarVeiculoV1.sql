USE DB_LOKANDO
GO
/****** Object:  StoredProcedure [dbo].[CadastrarVeiculoV1]    Script Date: 17/07/2019 07:08:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <17/07/2019>
-- Description:	<Inclusão de Novo Veiculo>
-- =============================================
CREATE PROCEDURE [dbo].[CadastrarVeiculoV1]		
	@VCCODLCDLOK int,
	@VCTPLOK varchar(100),
	@VCMARCALOK varchar(100),
	@VCMODELOK varchar(100),
	@VCPLACALOK varchar(7),
	@VCRNVLOK varchar(100),
	@VCCOMBLOK varchar(100),
	@VCCORLOK varchar(100),
	@VCVLRDIA decimal,
	@VCAPOLICELOK varchar(100),
	@VCSITLOK char(1)
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select LCIDLOCLOK From DB_LOKANDO..TBLOCLOK With(nolock) Where LCIDLOCLOK = @VCCODLCDLOK)
	BEGIN			
		PRINT 'Acesso Negado! Não é possível incluir um veículo sem locador no sistema!'
		ROLLBACK
	END
	ELSE IF EXISTS (Select VCPLACALOK From DB_LOKANDO..TBVEICLOK With(nolock) Where VCPLACALOK = @VCPLACALOK)
	BEGIN
		PRINT 'Já existe um Veiculo vinculado a esta placa. Veiculo não foi incluído.'
		ROLLBACK
	END
	ELSE IF EXISTS (Select VCRNVLOK From DB_LOKANDO..TBVEICLOK With(nolock) Where VCRNVLOK = @VCRNVLOK)
	BEGIN
		PRINT 'Já existe um veículo vinculado a este RENAVAM. Veículo não foi incluído.'
		ROLLBACK
	END
	ELSE
	BEGIN
		Insert Into TBVEICLOK Values (@VCCODLCDLOK, @VCTPLOK, @VCMARCALOK, @VCMODELOK, @VCPLACALOK, @VCRNVLOK, @VCCOMBLOK, @VCCORLOK, @VCVLRDIA, @VCAPOLICELOK, @VCSITLOK, GETDATE());
		PRINT 'Veiculo foi incluído com sucesso.'
		COMMIT
	END	
END
GO


