using Backend.Models;
using Oracle.ManagedDataAccess.Client;
using System.Data;

namespace Backend.Services
{
    public class UserRoleService
    {
        public async Task<IEnumerable<UserRoleModel>> GetAllUserRoles()
        {
            List<UserRoleModel> userRoles = new List<UserRoleModel>();

            using (OracleConnectionManager manager = new())
            {
                await using (OracleCommand command = new OracleCommand("GetAllUserRoles", manager.GetConnection()))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("p_Result", OracleDbType.RefCursor).Direction = ParameterDirection.Output;

                    await using (OracleDataReader reader = command.ExecuteReader())
                    {
                        while (await reader.ReadAsync())
                        {
                            UserRoleModel userRole = new UserRoleModel
                            {
                                UserRoleId = reader.GetInt32(reader.GetOrdinal("User_RoleId")),
                                UserId = reader.GetInt32(reader.GetOrdinal("UserId")),
                                RoleId = reader.GetInt32(reader.GetOrdinal("RoleId")),
                                UserName = reader.GetString(reader.GetOrdinal("UserName")),
                                RolName = reader.GetString(reader.GetOrdinal("RoleName"))
                            };
                            userRoles.Add(userRole);
                        }
                    }
                }
            }

            return userRoles;
        }



        public async Task<int> AssignUserRol(UserRoleModel newUserRole)
        {
            int userRoleId = 0;
            using (OracleConnectionManager manager = new())
            {
                await using (OracleCommand command = new OracleCommand("AssignRole", manager.GetConnection()))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.Add("p_UserID", OracleDbType.Int32).Value = newUserRole.UserId;
                    command.Parameters.Add("p_RoleID", OracleDbType.Int32).Value = newUserRole.RoleId;

                    OracleParameter p_UserRoleID = new OracleParameter("p_UserRoleID", OracleDbType.Int32);
                    p_UserRoleID.Direction = ParameterDirection.Output;
                    command.Parameters.Add(p_UserRoleID);

                    await command.ExecuteNonQueryAsync();
                    userRoleId = Convert.ToInt32(p_UserRoleID.Value.ToString());
                }
            }

            return userRoleId;
        }

        public async Task<bool> RevokeUserRol(int userRoleId)
        {
            int rowsAffected = 0;

            using (OracleConnectionManager manager = new())
            {
                await using (OracleCommand command = new OracleCommand("RevokeRole", manager.GetConnection()))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.Add("p_UserRoleID", OracleDbType.Int32).Value = userRoleId;
                    command.Parameters.Add("p_RowsAffected", OracleDbType.Int32).Direction = ParameterDirection.Output;

                    try
                    {
                        await command.ExecuteNonQueryAsync();
                        rowsAffected = Convert.ToInt32(command.Parameters["p_RowsAffected"].Value.ToString());
                    }
                    catch (OracleException ex)
                    {
                        rowsAffected = -1;
                    }
                }
            }

            return rowsAffected > 0;
        }
    }
}
