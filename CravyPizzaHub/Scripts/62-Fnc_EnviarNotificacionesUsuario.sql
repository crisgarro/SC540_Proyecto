CREATE OR REPLACE FUNCTION SendNotification(
  p_UserID NUMBER,
  p_Message NVARCHAR2
) RETURN BOOLEAN IS
BEGIN
  -- Enviar una notificación al usuario
  INSERT INTO Notifications (UserID, Message, Timestamp)
  VALUES (p_UserID, p_Message, SYSTIMESTAMP);

  RETURN TRUE;
EXCEPTION
  WHEN OTHERS THEN
    RETURN FALSE;
END SendNotification;
/
