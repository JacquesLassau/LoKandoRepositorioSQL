USE [DBLOKANDO]
GO

/****** Object:  StoredProcedure [dbo].[SP_CadastrarLocadorV1]    Script Date: 14/04/2020 08:57:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <07/01/2020>
-- Description:	<Inclusão de Novo Locador>
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
		PRINT 'Acesso Negado! Não é possível incluir um locador sem usuário no sistema!'
		ROLLBACK
	END
	ELSE IF EXISTS (Select LCPFPJLOK From DBLOKANDO..TBLOCLOK With(nolock) Where LCPFPJLOK = @LCPFPJLOK)
	BEGIN
		PRINT 'Já existe um locador vinculado a este cpf ou cnpj. Locador não foi incluído.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		declare @IDUSULOC int = (Select USIDUSU From DBLOKANDO..TBUSULOK With(nolock) Where USEMAILLOK = @LCEMAILLOK);		
		Insert Into TBLOCLOK Values (@IDUSULOC, @LCEMAILLOK, @LCRZSLOK, @LCFANTLOK, @LCPFPJLOK, @LCNMLOK, @LCLOGLOK, @LCBAIRROLOK, @LCCIDLOK, @LCUFLOK, @LCCEPLOK, @LCSITLOK, GETDATE());
		PRINT 'Locador foi incluído com sucesso.'
		COMMIT
	END	
END
GO