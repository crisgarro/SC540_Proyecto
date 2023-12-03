using Backend.Models;
using Oracle.ManagedDataAccess.Client;
using System.Data;

namespace Backend.Services
{
    public class RoleService
    {
        public async Task<List<RolModel>> GetAllRoles()
        {
            List<RolModel> roles = new List<RolModel>();

            using (OracleConnectionManager manager = new())
            {
                await using (OracleCommand command = new OracleCommand("GetAllRoles", manager.GetConnection()))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("p_Result", OracleDbType.RefCursor).Direction = ParameterDirection.Output;

                    await using (OracleDataReader reader = command.ExecuteReader())
                    {
                        while (await reader.ReadAsync())
                        {
                            RolModel role = new RolModel
                            {
                                RoleID = reader.GetInt32(reader.GetOrdinal("RoleID")),
                                RolName = reader.GetString(reader.GetOrdinal("RoleName"))
                            };
                            roles.Add(role);
                        }
                    }
                }
            }

            return roles;
        }

        public async Task<int> CreateRole(RolModel newRole)
        {
            int roleID = 0;
            using (OracleConnectionManager manager = new())
            {
                await using (OracleCommand command = new OracleCommand("InsertRole", manager.GetConnection()))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.Add("p_RoleName", OracleDbType.NVarchar2).Value = newRole.RolName;

                    OracleParameter p_RoleID = new OracleParameter("p_RoleID", OracleDbType.Int32);
                    p_RoleID.Direction = ParameterDirection.Output;
                    command.Parameters.Add(p_RoleID);

                    await command.ExecuteNonQueryAsync();
                    roleID = Convert.ToInt32(p_RoleID.Value.ToString());
                }
            }

            return roleID;
        }

        public async Task<RolModel> UpdateRole(RolModel updatedRole)
        {
            int isUpdated = 0;
            using (OracleConnectionManager manager = new())
            {
                await using (OracleCommand command = new OracleCommand("UpdateRole", manager.GetConnection()))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.Add("p_RoleID", OracleDbType.Int32).Value = updatedRole.RoleID;
                    command.Parameters.Add("p_RoleName", OracleDbType.NVarchar2).Value = updatedRole.RolName;

                    OracleParameter wasUpdated = new OracleParameter("p_WasUpdated", OracleDbType.Int32);
                    wasUpdated.Direction = ParameterDirection.Output;
                    command.Parameters.Add(wasUpdated);

                    await command.ExecuteNonQueryAsync();
                    isUpdated = Convert.ToInt32(wasUpdated.Value.ToString());
                }
            }

            return isUpdated == 1 ? updatedRole : null;
        }

        public async Task<bool> DeleteRole(int roleId)
        {
            int rowsAffected = 0;

            using (OracleConnectionManager manager = new())
            {
                await using (OracleCommand command = new OracleCommand("DeleteRole", manager.GetConnection()))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.Add("p_RoleID", OracleDbType.Int32).Value = roleId;
                    command.Parameters.Add("p_RowsAffected", OracleDbType.Int32).Direction = ParameterDirection.Output;

                    try
                    {
                        await command.ExecuteNonQueryAsync();
                        rowsAffected = Convert.ToInt32(command.Parameters["p_RowsAffected"].Value.ToString());
                    }
                    catch (OracleException ex)
                    {    
                        //Custom Exception from Stored Proc
                        if (ex.Number == 20001)
                        {                            
                            rowsAffected = -1;
                        }
                        else
                        {                            
                            throw;
                        }
                    }
                }
            }

            return rowsAffected > 0;
        }

    }
}
