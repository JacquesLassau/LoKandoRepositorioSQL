
GO

/****** Object:  StoredProcedure [dbo].[SP_ListarClienteV1]    Script Date: 28/01/2020 08:23:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <04/08/2019>
-- Description:	<Lista de Clientes>
-- =============================================
CREATE PROCEDURE [dbo].[SP_ListarLocadorV1]
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select * From DBLOKANDO..TBLOCLOK)
	BEGIN			
		PRINT 'N�o foi poss�vel listar locadores. N�o existe nenhum registro na base de dados.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Select * From DBLOKANDO..TBLOCLOK Where LCSITLOK <> 'I';
		COMMIT
	END
END
GO


GO

/****** Object:  StoredProcedure [dbo].[SP_SelecionarLocadorEmailV1]    Script Date: 27/12/2019 08:09:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <27/12/2019>
-- Description:	<Selecionar Locador por e-mail>
-- =============================================
CREATE PROCEDURE [dbo].[SP_SelecionarLocadorEmailV1] 
	@LCEMAILLOK varchar(100)
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select LCEMAILLOK From DBLOKANDO..TBLOCLOK With(nolock) Where LCEMAILLOK = @LCEMAILLOK And LCSITLOK <> 'I')
	BEGIN			
		PRINT 'E-mail do locador inv�lido. N�o foi poss�vel realizar a consulta.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Select * from  DBLOKANDO..TBLOCLOK With(nolock) Where LCEMAILLOK = @LCEMAILLOK;
		PRINT 'Locador foi selecionado com sucesso.'
		COMMIT
	END
END
GO


GO

/****** Object:  StoredProcedure [dbo].[SP_SelecionarLocadorIdV1]    Script Date: 28/01/2020 07:40:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <27/12/2019>
-- Description:	<Selecionar Locador por C�digo>
-- =============================================
CREATE PROCEDURE [dbo].[SP_SelecionarLocadorIdV1] 
	@LCIDLOCLOK int
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select LCIDLOCLOK From DBLOKANDO..TBLOCLOK With(nolock) Where LCIDLOCLOK = @LCIDLOCLOK And LCSITLOK <> 'I')
	BEGIN			
		PRINT 'C�digo do locador inv�lido. N�o foi poss�vel realizar a consulta.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Select * from  DBLOKANDO..TBLOCLOK With(nolock) Where LCIDLOCLOK = @LCIDLOCLOK;
		PRINT 'Locador foi selecionado com sucesso.'
		COMMIT
	END
END
GO


GO

/****** Object:  StoredProcedure [dbo].[SP_SelecionarLocadorDocV1]    Script Date: 13/01/2020 07:54:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <27/12/2019>
-- Description:	<Selecionar Locador por documento>
-- =============================================
CREATE PROCEDURE [dbo].[SP_SelecionarLocadorDocV1] 
	@LCPFPJLOK varchar(100)
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select LCPFPJLOK From DBLOKANDO..TBLOCLOK With(nolock) Where LCPFPJLOK = @LCPFPJLOK And LCSITLOK <> 'I')
	BEGIN			
		PRINT 'Documento do locador inv�lido. N�o foi poss�vel realizar a consulta.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Select * from  DBLOKANDO..TBLOCLOK With(nolock) Where LCPFPJLOK = @LCPFPJLOK;
		PRINT 'Locador foi selecionado com sucesso.'
		COMMIT
	END
END
GO


GO

/****** Object:  StoredProcedure [dbo].[SP_ExcluirLocadorV1]    Script Date: 14/04/2020 08:57:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO  
  
-- =============================================  
-- Author:  <Jacques de Lassau>  
-- Create date: <04/08/2019>  
-- Description: <Exclus�o de Locador>  
-- =============================================  
CREATE PROCEDURE [dbo].[SP_ExcluirLocadorV1] 
 @LCIDLOCLOK int   
AS  
BEGIN  
 BEGIN TRAN   
 IF NOT EXISTS (Select LCIDLOCLOK From DBLOKANDO..TBLOCLOK With(nolock) Where LCIDLOCLOK = @LCIDLOCLOK)  
 BEGIN     
  PRINT 'C�digo do locador inv�lido. N�o foi poss�vel excluir o cliente.'  
  ROLLBACK  
 END   
 ELSE  
 BEGIN  
  declare @IDUSULOC int = (Select LCIDLOCLOK From DBLOKANDO..TBLOCLOK With(nolock) Where LCIDLOCLOK = @LCIDLOCLOK);  
  Update DBLOKANDO..TBLOCLOK  Set LCSITLOK = 'I', LCUHRREG  = GETDATE()  Where LCIDLOCLOK  = @LCIDLOCLOK;  
  Update DBLOKANDO..TBUSULOK  Set USSITLOK = 'I', USUHRREG  = GETDATE()  Where USIDUSU     = @IDUSULOC;  
  Update DBLOKANDO..TBVEICLOK Set VCSITLOK = 'I', VCHRREGLOK = GETDATE() Where VCCODLCDLOK = @LCIDLOCLOK;
  PRINT 'Locador foi exclu�do com sucesso.'  
  COMMIT  
 END  
END  


GO

/****** Object:  StoredProcedure [dbo].[SP_AlterarLocadorV1]    Script Date: 14/04/2020 08:59:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <29/01/2020>
-- Description:	<Altera��o de Locador>
-- =============================================
CREATE PROCEDURE [dbo].[SP_AlterarLocadorV1]
	@LCIDLOCLOK int,	
	@LCRZSLOK varchar(100),
	@LCFANTLOK varchar(100),	
	@LCNMLOK varchar(100),
	@LCLOGLOK varchar(100),
	@LCBAIRROLOK varchar(100),
	@LCCIDLOK varchar(100),
	@LCUFLOK varchar(2),
	@LCCEPLOK varchar(10),	
	@LCSITLOK char(1)	
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select LCIDLOCLOK From DBLOKANDO..TBLOCLOK With(nolock) Where LCIDLOCLOK = @LCIDLOCLOK)
	BEGIN			
		PRINT 'C�digo do locador inv�lido. N�o foi poss�vel realizar a altera��o.'
		ROLLBACK
	END
	ELSE IF EXISTS (Select LCUFLOK From DBLOKANDO..TBLOCLOK With(nolock) Where LEN(@LCUFLOK) <> 2)
	BEGIN
		PRINT 'Estado deve ser preenchido com duas letras. Locador n�o foi alterado.'
		ROLLBACK
	END				
	ELSE IF EXISTS (Select LCCEPLOK From DBLOKANDO..TBLOCLOK With(nolock) Where LEN(@LCCEPLOK) <> 9) 
	BEGIN
		PRINT 'CEP deve ser preenchido no formato correto. Locador n�o foi alterado.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		declare @IDUSULOC int = (Select LCCODUSLOK From DBLOKANDO..TBLOCLOK With(nolock) Where LCIDLOCLOK = @LCIDLOCLOK);		
		Update DBLOKANDO..TBLOCLOK Set LCRZSLOK = @LCRZSLOK, LCFANTLOK = @LCFANTLOK, LCNMLOK = @LCNMLOK, LCLOGLOK = @LCLOGLOK, LCBAIRROLOK = @LCBAIRROLOK, LCCIDLOK = @LCCIDLOK, LCUFLOK = @LCUFLOK, LCCEPLOK = @LCCEPLOK, LCSITLOK = @LCSITLOK, LCUHRREG = GETDATE() Where LCIDLOCLOK = @LCIDLOCLOK;
		Update DBLOKANDO..TBUSULOK Set USSITLOK = @LCSITLOK, USUHRREG = GETDATE() Where USIDUSU = @IDUSULOC;		
		PRINT 'Locador foi alterado com sucesso.'
		COMMIT
	END	
END
GO


GO

/****** Object:  StoredProcedure [dbo].[SP_CadastrarLocadorV1]    Script Date: 14/04/2020 08:57:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <07/01/2020>
-- Description:	<Inclus�o de Novo Locador>
-- =============================================
CREATE PROCEDURE [dbo].[SP_CadastrarLocadorV1]
	@LCEMAILLOK varchar (100),
	@LCRZSLOK varchar(100),
	@LCFANTLOK varchar(100),
	@LCPFPJLOK varchar(18),
	@LCNMLOK varchar(100),
	@LCLOGLOK varchar(100),
	@LCBAIRROLOK varchar(100),
	@LCCIDLOK varchar(100),
	@LCUFLOK varchar(2),
	@LCCEPLOK varchar(10),	
	@LCSITLOK char(1)	
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select USEMAILLOK From DBLOKANDO..TBUSULOK With(nolock) Where USEMAILLOK = @LCEMAILLOK)
	BEGIN			
		PRINT 'Acesso Negado! N�o � poss�vel incluir um locador sem usu�rio no sistema!'
		ROLLBACK
	END
	ELSE IF EXISTS (Select LCPFPJLOK From DBLOKANDO..TBLOCLOK With(nolock) Where LCPFPJLOK = @LCPFPJLOK)
	BEGIN
		PRINT 'J� existe um locador vinculado a este cpf ou cnpj. Locador n�o foi inclu�do.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		declare @IDUSULOC int = (Select USIDUSU From DBLOKANDO..TBUSULOK With(nolock) Where USEMAILLOK = @LCEMAILLOK);		
		Insert Into TBLOCLOK Values (@IDUSULOC, @LCEMAILLOK, @LCRZSLOK, @LCFANTLOK, @LCPFPJLOK, @LCNMLOK, @LCLOGLOK, @LCBAIRROLOK, @LCCIDLOK, @LCUFLOK, @LCCEPLOK, @LCSITLOK, GETDATE());
		PRINT 'Locador foi inclu�do com sucesso.'
		COMMIT
	END	
END
GO