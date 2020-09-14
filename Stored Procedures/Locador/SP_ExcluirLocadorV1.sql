USE [DBLOKANDO]
GO

/****** Object:  StoredProcedure [dbo].[SP_ExcluirLocadorV1]    Script Date: 14/04/2020 08:57:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO  
  
-- =============================================  
-- Author:  <Jacques de Lassau>  
-- Create date: <04/08/2019>  
-- Description: <Exclusão de Locador>  
-- =============================================  
CREATE PROCEDURE [dbo].[SP_ExcluirLocadorV1] 
 @LCIDLOCLOK int   
AS  
BEGIN  
 BEGIN TRAN   
 IF NOT EXISTS (Select LCIDLOCLOK From DBLOKANDO..TBLOCLOK With(nolock) Where LCIDLOCLOK = @LCIDLOCLOK)  
 BEGIN     
  PRINT 'Código do locador inválido. Não foi possível excluir o cliente.'  
  ROLLBACK  
 END   
 ELSE  
 BEGIN  
  declare @IDUSULOC int = (Select LCIDLOCLOK From DBLOKANDO..TBLOCLOK With(nolock) Where LCIDLOCLOK = @LCIDLOCLOK);  
  Update DBLOKANDO..TBLOCLOK  Set LCSITLOK = 'I', LCUHRREG  = GETDATE()  Where LCIDLOCLOK  = @LCIDLOCLOK;  
  Update DBLOKANDO..TBUSULOK  Set USSITLOK = 'I', USUHRREG  = GETDATE()  Where USIDUSU     = @IDUSULOC;  
  Update DBLOKANDO..TBVEICLOK Set VCSITLOK = 'I', VCHRREGLOK = GETDATE() Where VCCODLCDLOK = @LCIDLOCLOK;
  PRINT 'Locador foi excluído com sucesso.'  
  COMMIT  
 END  
END  

