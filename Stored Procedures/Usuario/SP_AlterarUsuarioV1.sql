USE DB_LOKANDO 
GO
/****** Object:  StoredProcedure [dbo].[SP_AlterarUsuarioV1]    Script Date: 15/07/2019 07:20:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacques de Lassau>
-- Create date: <15/07/2019>
-- Description:	<Alteração de Usuário>
-- =============================================
CREATE PROCEDURE [dbo].[SP_AlterarUsuarioV1]		
	@USIDUSU int,
	@USSENHALOK varchar(100)
AS
BEGIN 
	BEGIN TRAN
	IF NOT EXISTS (Select USIDUSU From DB_LOKANDO..TBUSULOK With(nolock) Where USIDUSU = @USIDUSU)
	BEGIN			
		PRINT 'Código do usuário inválido. Não foi possível realizar a alteração.'
		ROLLBACK
	END
	ELSE
	BEGIN
		Update DB_LOKANDO..TBUSULOK Set USSENHALOK = @USSENHALOK, USUHRREG = GETDATE() Where USIDUSU = @USIDUSU;
		PRINT 'Usuário foi alterado com sucesso.'
		COMMIT
	END
END
GO



