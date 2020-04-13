  
  
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
 IF NOT EXISTS (Select LCIDLOCLOK From DB_LOKANDO..TBLOCLOK With(nolock) Where LCIDLOCLOK = @LCIDLOCLOK)  
 BEGIN     
  PRINT 'C�digo do locador inv�lido. N�o foi poss�vel excluir o cliente.'  
  ROLLBACK  
 END   
 ELSE  
 BEGIN  
  declare @IDUSULOC int = (Select LCIDLOCLOK From DB_LOKANDO..TBLOCLOK With(nolock) Where LCIDLOCLOK = @LCIDLOCLOK);  
  Update DB_LOKANDO..TBLOCLOK  Set LCSITLOK = 'I', LCUHRREG  = GETDATE()  Where LCIDLOCLOK  = @LCIDLOCLOK;  
  Update DB_LOKANDO..TBUSULOK  Set USSITLOK = 'I', USUHRREG  = GETDATE()  Where USIDUSU     = @IDUSULOC;  
  Update DB_LOKANDO..TBVEICLOK Set VCSITLOK = 'I', VCHRREGLOK = GETDATE() Where VCCODLCDLOK = @LCIDLOCLOK;
  PRINT 'Locador foi exclu�do com sucesso.'  
  COMMIT  
 END  
END  