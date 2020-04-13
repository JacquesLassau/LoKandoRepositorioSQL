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
 @VCVLRDIA decimal(9,2),   
 @VCSITLOK char(1)   
AS  
BEGIN  
 BEGIN TRAN   
 IF NOT EXISTS (Select VCPLACALOK From DB_LOKANDO..TBVEICLOK With(nolock) Where VCPLACALOK = @VCPLACALOK and VCSITLOK <> 'I')  
 BEGIN     
  PRINT 'Placa do veículo inválida. Não foi possível realizar a alteração.'  
  ROLLBACK  
 END   
 ELSE  
 BEGIN  
  Update DB_LOKANDO..TBVEICLOK Set VCCODLCDLOK = @VCCODLCDLOK, VCTPLOK = @VCTPLOK, VCMARCALOK = @VCMARCALOK, VCMODELOK = @VCMODELOK, VCCOMBLOK = @VCCOMBLOK, VCCORLOK = @VCCORLOK, VCVLRDIA = @VCVLRDIA, VCSITLOK = @VCSITLOK, VCHRREGLOK = GETDATE() Where VCPLACALOK = @VCPLACALOK;  
  PRINT 'Veiculo foi alterado com sucesso.'  
  COMMIT  
 END   
END  