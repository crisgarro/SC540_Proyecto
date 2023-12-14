CREATE OR REPLACE PACKAGE UserReviewsInformation AS
  -- Declaración del primer procedimiento
  PROCEDURE GetAllUsers(p_Users OUT SYS_REFCURSOR);

  -- Declaración del segundo procedimiento
  PROCEDURE GetAllReviewsWithUserFlag(p_Review OUT SYS_REFCURSOR);
END UserReviewsInformation;
/

CREATE OR REPLACE PACKAGE BODY UserReviewsInformation AS
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
  PROCEDURE GetAllReviewsWithUserFlag(p_Review OUT SYS_REFCURSOR) AS
  BEGIN
    OPEN p_Review FOR
      SELECT
        PR.*,
        CASE
          WHEN U.USERID IS NOT NULL THEN 'Sí'
          ELSE 'No'
        END AS "Hizo Review"
      FROM PRODUCT_REVIEWS PR
      LEFT JOIN USERS U ON PR.USERID = U.USERID;
  END GetAllReviewsWithUserFlag;
END UserReviewsInformation;
/
