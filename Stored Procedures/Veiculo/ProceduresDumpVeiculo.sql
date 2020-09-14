-- =============================================  
-- Author:  <Jacques de Lassau>  
-- Create date: <17/07/2019>  
-- Description: <Alteração de Veiculo>  
-- =============================================  
CREATE PROCEDURE [dbo].[SP_AlterarVeiculoV1] 
	@VCCODLCDLOK int,  
	@VCTPLOK varchar(100),  
	@VCMARCALOK varchar(100),  
	@VCMODELOK varchar(100),  
	@VCPLACALOK varchar(7),   
	@VCCOMBLOK varchar(100),  
	@VCCORLOK varchar(100),  
	@VCANOLOK varchar(4),
	@VCVLRDIA decimal(9,2),   
	@VCSITLOK char(1)   
AS  
BEGIN  
	BEGIN TRAN   
	IF NOT EXISTS (Select VCPLACALOK From DBLOKANDO..TBVEICLOK With(nolock) Where VCPLACALOK = @VCPLACALOK and VCSITLOK <> 'I')  
	BEGIN     
		PRINT 'Placa do veículo inválida. Não foi possível realizar a alteração.'  
		ROLLBACK  
	END   
	ELSE  
	BEGIN  
		Update DBLOKANDO..TBVEICLOK Set VCCODLCDLOK = @VCCODLCDLOK, VCTPLOK = @VCTPLOK, VCMARCALOK = @VCMARCALOK, VCMODELOK = @VCMODELOK, VCCOMBLOK = @VCCOMBLOK, VCCORLOK = @VCCORLOK, VCANOLOK = @VCANOLOK, VCVLRDIA = @VCVLRDIA, VCSITLOK = @VCSITLOK, VCHRREGLOK = GETDATE() Where VCPLACALOK = @VCPLACALOK;  
		PRINT 'Veiculo foi alterado com sucesso.'  
		COMMIT  
	END   
END  


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
	IF NOT EXISTS (Select VCRNVLOK From DBLOKANDO..TBVEICLOK With(nolock) Where VCRNVLOK = @VCRNVLOK And VCSITLOK <> 'I')
	BEGIN			
		PRINT 'Renavam do veículo inválido. Não foi possível realizar a consulta.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Select * from  DBLOKANDO..TBVEICLOK With(nolock) Where VCRNVLOK = @VCRNVLOK;
		PRINT 'Renavam selecionada com sucesso.'
		COMMIT
	END
END
GO


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


GO

/****** Object:  StoredProcedure [dbo].[SP_ListarVeiculoLocadorV1]    Script Date: 24/02/2020 08:59:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <04/08/2019>
-- Description:	<Lista de Veiculos do Locador>
-- =============================================
CREATE PROCEDURE [dbo].[SP_ListarVeiculoLocadorV1]
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select * From DBLOKANDO..TBVEICLOK)
	BEGIN			
		PRINT 'Não foi possível listar veículos. Não existe nenhum registro na base de dados.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Select * From DBLOKANDO..TBVEICLOK 
			INNER JOIN TBLOCLOK ON VCCODLCDLOK = LCIDLOCLOK
		where VCSITLOK <> 'I' order by VCCODLCDLOK desc
		COMMIT
	END
END
GO


GO

/****** Object:  StoredProcedure [dbo].[SP_ListarVeiculoV1]    Script Date: 17/02/2020 14:07:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <04/08/2019>
-- Description:	<Lista de CVeiculos>
-- =============================================
CREATE PROCEDURE [dbo].[SP_ListarVeiculoV1]
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select * From DBLOKANDO..TBVEICLOK)
	BEGIN			
		PRINT 'Não foi possível listar veiculos. Não existe nenhum registro na base de dados.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Select * From DBLOKANDO..TBVEICLOK Where VCSITLOK <> 'I';
		COMMIT
	END
END
GO


GO

/****** Object:  StoredProcedure [dbo].[SP_CadastrarVeiculoV1]    Script Date: 24/02/2020 10:39:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <10/02/2020>
-- Description:	<Inclusão de Novo Veiculo>
-- ============================================= 
CREATE PROCEDURE [dbo].[SP_CadastrarVeiculoV1]	
	@VCCODLCDLOK int,
	@VCTPLOK varchar(100),
	@VCMARCALOK varchar(100),
	@VCMODELOK varchar(100),
	@VCPLACALOK varchar(7),
	@VCRNVLOK varchar(100),
	@VCCOMBLOK varchar(100),
	@VCCORLOK varchar(100),
	@VCANOLOK varchar(4),
	@VCVLRDIA decimal(9,2),	
	@VCSITLOK char(1)
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select LCIDLOCLOK From DBLOKANDO..TBLOCLOK With(nolock) Where LCIDLOCLOK = @VCCODLCDLOK)
	BEGIN			
		PRINT 'Acesso Negado! Não é possível incluir um veículo sem locador no sistema!'
		ROLLBACK
	END
	ELSE IF EXISTS (Select VCPLACALOK From DBLOKANDO..TBVEICLOK With(nolock) Where VCPLACALOK = @VCPLACALOK and VCSITLOK <> 'I')
	BEGIN
		PRINT 'Já existe um Veiculo vinculado a esta placa. Veiculo não foi incluído.'
		ROLLBACK
	END
	ELSE IF EXISTS (Select VCRNVLOK From DBLOKANDO..TBVEICLOK With(nolock) Where VCRNVLOK = @VCRNVLOK and VCSITLOK <> 'I')
	BEGIN
		PRINT 'Já existe um veículo vinculado a este RENAVAM. Veículo não foi incluído.'
		ROLLBACK
	END
	ELSE
	BEGIN		
		Insert Into TBVEICLOK Values (@VCCODLCDLOK, @VCTPLOK, @VCMARCALOK, @VCMODELOK, @VCPLACALOK, @VCRNVLOK, @VCCOMBLOK, @VCCORLOK, @VCANOLOK, @VCVLRDIA, @VCSITLOK, GETDATE());
		PRINT 'Veiculo foi incluído com sucesso.'
		COMMIT
	END	
END
GO

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