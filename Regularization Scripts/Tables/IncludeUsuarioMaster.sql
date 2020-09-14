DECLARE @dt datetime = SWITCHOFFSET (CONVERT(datetime, GETDATE()), '-03:00');

INSERT INTO TBUSULOK VALUES  ('atendente-master@yopmail.com','123456','A','A', @dt);
INSERT INTO TBATNDLOK VALUES (1,'Atendente Master','atendente-master@yopmail.com','A',@dt);