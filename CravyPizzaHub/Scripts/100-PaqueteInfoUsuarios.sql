CREATE OR REPLACE PACKAGE UserInformation AS
  -- Declaración del primer procedimiento
  PROCEDURE GetAllUsers(p_Users OUT SYS_REFCURSOR);

  -- Declaración del segundo procedimiento
  PROCEDURE GetAllUsersWithRoles(p_Result OUT SYS_REFCURSOR);
END UserInformation;
/

CREATE OR REPLACE PACKAGE BODY UserInformation AS
  -- Implementación del primer procedimiento
  PROCEDURE GetAllUsers(p_Users OUT SYS_REFCURSOR) AS
  BEGIN
    OPEN p_Users FOR
      SELECT
        USERS.USERID,
        USERS.USERNAME,
        USERS.PASSWORD,
        USERS.EMAIL,
        USERS.FIRSTNAME,
        USERS.LASTNAME,
        USERS.ADDRESS,
        USERS.PHONE,
        USERS.ENABLED
      FROM USERS;
  END GetAllUsers;

  -- Implementación del segundo procedimiento
  PROCEDURE GetAllUsersWithRoles(p_Result OUT SYS_REFCURSOR) AS
  BEGIN
    OPEN p_Result FOR
      SELECT
        U.USERID,
        U.USERNAME,
        U.PASSWORD,
        U.EMAIL,
        U.FIRSTNAME,
        U.LASTNAME,
        U.ADDRESS,
        U.PHONE,
        U.ENABLED,
        LISTAGG(R.ROLENAME, ', ') WITHIN GROUP (ORDER BY R.ROLENAME) AS ROLES
      FROM USERS U
      LEFT JOIN USER_ROLES UR ON U.USERID = UR.USERID
      LEFT JOIN ROLES R ON UR.ROLEID = R.ROLEID
      GROUP BY
        U.USERID,
        U.USERNAME,
        U.PASSWORD,
        U.EMAIL,
        U.FIRSTNAME,
        U.LASTNAME,
        U.ADDRESS,
        U.PHONE,
        U.ENABLED;
  END GetAllUsersWithRoles;
END UserInformation;
/
