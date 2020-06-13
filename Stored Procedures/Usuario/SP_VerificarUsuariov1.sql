USE [DB_LOKANDO]
GO

/****** Object:  StoredProcedure [dbo].[SP_SelecionarUsuarioEmailV1]    Script Date: 13/06/2020 15:10:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <15/07/2019>
-- Description:	<Selecionar Usuario por e-mail>
-- =============================================
CREATE PROCEDURE [dbo].[SP_VerificarUsuarioV1]	
	@USEMAILLOK varchar(100),
	@USSENHALOK varchar(100)
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select USEMAILLOK,USSENHALOK From DB_LOKANDO..TBUSULOK With(nolock) Where USEMAILLOK = @USEMAILLOK And USSENHALOK = @USSENHALOK And USTPUSULOK = 'A')
	BEGIN			
		PRINT 'E-mail ou senha inválido.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Select USEMAILLOK,USSENHALOK From DB_LOKANDO..TBUSULOK With(nolock) Where USEMAILLOK = @USEMAILLOK And USSENHALOK = @USSENHALOK And USTPUSULOK = 'A'
		PRINT 'Atendente foi selecionado com sucesso.'
		COMMIT
	END
END
GO


