using Backend.Models;
using Oracle.ManagedDataAccess.Client;
using System.Data;

namespace Backend.Services
{
    public class UserService
    {
        public async Task<List<UserModel>> GetAllUsers()
        {
            await using (OracleConnectionManager manager = new())
            {
                var users = new List<UserModel>();

                await using (OracleCommand command = new OracleCommand("GetAllUsers", manager.GetConnection()))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("p_users", OracleDbType.RefCursor).Direction = ParameterDirection.Output;

                    await using (OracleDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            UserModel user = new UserModel
                            {
                                UserID = Convert.ToInt32(reader["UserID"]),
                                Username = reader["Username"].ToString(),
                                Password = reader["Password"].ToString(),
                                Email = reader["Email"].ToString(),
                                FirstName = reader["FirstName"].ToString(),
                                LastName = reader["LastName"].ToString(),
                                Address = reader["Address"].ToString(),
                                Phone = reader["Phone"].ToString(),
                                Enable= Convert.ToBoolean(Convert.ToInt32(reader["Enable"]))
                            };

                            users.Add(user);
                        }
                    }

                    return users;
                }
            }
        }

        public async Task<int> CreateUser(UserModel newUser)
        {
            using (OracleConnectionManager manager = new())
            {
                await using (OracleCommand command = new OracleCommand("InsertUser", manager.GetConnection()))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.Add("p_username", OracleDbType.Varchar2).Value = newUser.Username;
                    command.Parameters.Add("p_password", OracleDbType.Varchar2).Value = newUser.Password;
                    command.Parameters.Add("p_email", OracleDbType.Varchar2).Value = newUser.Email;
                    command.Parameters.Add("p_firstName", OracleDbType.Varchar2).Value = newUser.FirstName;
                    command.Parameters.Add("p_lastName", OracleDbType.Varchar2).Value = newUser.LastName;
                    command.Parameters.Add("p_address", OracleDbType.Varchar2).Value = newUser.Address;
                    command.Parameters.Add("p_phone", OracleDbType.Varchar2).Value = newUser.Phone;

                    command.Parameters.Add("p_userId", OracleDbType.Int32).Direction = ParameterDirection.Output;

                    await command.ExecuteNonQueryAsync();

                    return Convert.ToInt32(command.Parameters["p_userId"].Value.ToString());
                }
            }
        }

        public async Task<UserModel> UpdateUser(UserModel updatedUser)
        {
            int isUpdated = 0;
            using (OracleConnectionManager manager = new())
            {
                await using (OracleCommand command = new OracleCommand("UpdateUser", manager.GetConnection()))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.Add("pUserID", OracleDbType.Int32).Value = updatedUser.UserID;
                    command.Parameters.Add("pUsername", OracleDbType.Varchar2).Value = updatedUser.Username;
                    command.Parameters.Add("pPassword", OracleDbType.Varchar2).Value = updatedUser.Password;
                    command.Parameters.Add("pEmail", OracleDbType.Varchar2).Value = updatedUser.Email;
                    command.Parameters.Add("pFirstName", OracleDbType.Varchar2).Value = updatedUser.FirstName;
                    command.Parameters.Add("pLastName", OracleDbType.Varchar2).Value = updatedUser.LastName;
                    command.Parameters.Add("pAddress", OracleDbType.Varchar2).Value = updatedUser.Address;
                    command.Parameters.Add("pPhone", OracleDbType.Varchar2).Value = updatedUser.Phone;

                    OracleParameter pIsUpdated = new OracleParameter("pIsUpdated", OracleDbType.Int32);
                    pIsUpdated.Direction = ParameterDirection.Output;
                    command.Parameters.Add(pIsUpdated);

                    await command.ExecuteNonQueryAsync();
                    isUpdated = Convert.ToInt32(pIsUpdated.Value.ToString());
                }
            }

            return isUpdated == 1 ? updatedUser : null;
        }

        public async Task<UserModel> DisableUser(UserModel userToDisable, bool state)
        {
            int isUpdated = 0;
            using (OracleConnectionManager manager = new())
            {
                await using (OracleCommand command = new OracleCommand("DisableUser", manager.GetConnection()))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("pUserID", OracleDbType.Int32).Value = userToDisable.UserID;
                    command.Parameters.Add("pEnable", OracleDbType.Int32).Value = state ? 1 : 0;

                    OracleParameter pIsUpdated = new OracleParameter("pIsUpdated", OracleDbType.Int32);
                    pIsUpdated.Direction = ParameterDirection.Output;
                    command.Parameters.Add(pIsUpdated);

                    await command.ExecuteNonQueryAsync();

                    isUpdated = Convert.ToInt32(pIsUpdated.Value.ToString());
                }
            }

            return isUpdated == 1 ? userToDisable : null;
        }
    }
}