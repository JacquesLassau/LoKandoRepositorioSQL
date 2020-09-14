USE [DBLOKANDO]
GO
/****** Object:  StoredProcedure [dbo].[SP_SelecionarUsuarioEmailV1]    Script Date: 01/08/2019 07:16:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <15/07/2019>
-- Description:	<Selecionar Usuario por e-mail>
-- =============================================
CREATE PROCEDURE [dbo].[SP_SelecionarUsuarioEmailV1]	
	@USEMAILLOK varchar(100)
AS
BEGIN
	BEGIN TRAN 
	IF NOT EXISTS (Select USEMAILLOK From DBLOKANDO..TBUSULOK With(nolock) Where USEMAILLOK = @USEMAILLOK And USSITLOK <> 'I')
	BEGIN			
		PRINT 'E-mail do atendente inválido. Não foi possível realizar a consulta.'
		ROLLBACK
	END	
	ELSE
	BEGIN
		Select * from  DBLOKANDO..TBUSULOK With(nolock) Where USEMAILLOK = @USEMAILLOK;
		PRINT 'Atendente foi selecionado com sucesso.'
		COMMIT
	END
END
GO



