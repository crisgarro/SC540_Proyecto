using Backend.Models;
using Oracle.ManagedDataAccess.Client;
using Oracle.ManagedDataAccess.Types;
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
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    
                    //Output Parameters
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
                                Phone = reader["Phone"].ToString()
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
                    command.CommandType = System.Data.CommandType.StoredProcedure;

                    // Input Parameters
                    command.Parameters.Add("p_username", OracleDbType.Varchar2).Value = newUser.Username;
                    command.Parameters.Add("p_password", OracleDbType.Varchar2).Value = newUser.Password;
                    command.Parameters.Add("p_email", OracleDbType.Varchar2).Value = newUser.Email;
                    command.Parameters.Add("p_firstName", OracleDbType.Varchar2).Value = newUser.FirstName;
                    command.Parameters.Add("p_lastName", OracleDbType.Varchar2).Value = newUser.LastName;
                    command.Parameters.Add("p_address", OracleDbType.Varchar2).Value = newUser.Address;
                    command.Parameters.Add("p_phone", OracleDbType.Varchar2).Value = newUser.Phone;

                    // Output Parameter
                    command.Parameters.Add("p_userId", OracleDbType.Int32).Direction = ParameterDirection.Output;

                    await command.ExecuteNonQueryAsync();

                    return Convert.ToInt32(command.Parameters["p_userId"].Value.ToString());
                }
            }
        }

        public async Task<UserModel> UpdateUser(UserModel updatedUser)
        {
            using (OracleConnectionManager manager = new())
            {
                await using (OracleCommand command = new OracleCommand("UpdateUser", manager.GetConnection()))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;

                    // Input Parameters
                    command.Parameters.Add("p_userId", OracleDbType.Int32).Value = updatedUser.UserID;
                    command.Parameters.Add("p_username", OracleDbType.Varchar2).Value = updatedUser.Username;
                    command.Parameters.Add("p_password", OracleDbType.Varchar2).Value = updatedUser.Password;
                    command.Parameters.Add("p_email", OracleDbType.Varchar2).Value = updatedUser.Email;
                    command.Parameters.Add("p_firstName", OracleDbType.Varchar2).Value = updatedUser.FirstName;
                    command.Parameters.Add("p_lastName", OracleDbType.Varchar2).Value = updatedUser.LastName;
                    command.Parameters.Add("p_address", OracleDbType.Varchar2).Value = updatedUser.Address;
                    command.Parameters.Add("p_phone", OracleDbType.Varchar2).Value = updatedUser.Phone;

                    // Output parameter for retrieving the updated user record
                    command.Parameters.Add("p_updatedUser", OracleDbType.RefCursor).Direction = ParameterDirection.Output;

                    await command.ExecuteNonQueryAsync();

                    // Retrieve the updated user record from the output parameter
                    UserModel updatedUserData = null;

                    // Check if the output parameter contains data
                    if (command.Parameters["p_updatedUser"].Value != DBNull.Value)
                    {
                        using (OracleDataReader reader = ((OracleRefCursor)command.Parameters["p_updatedUser"].Value).GetDataReader())
                        {
                            if (reader.Read())
                            {
                                updatedUserData = new UserModel
                                {
                                    UserID = reader.GetInt32(reader.GetOrdinal("UserID")),
                                    Username = reader.GetString(reader.GetOrdinal("Username")),
                                    Password = reader.GetString(reader.GetOrdinal("Password")),
                                    Email = reader.GetString(reader.GetOrdinal("Email")),
                                    FirstName = reader.GetString(reader.GetOrdinal("FirstName")),
                                    LastName = reader.GetString(reader.GetOrdinal("LastName")),
                                    Address = reader.GetString(reader.GetOrdinal("Address")),
                                    Phone = reader.GetString(reader.GetOrdinal("Phone"))
                                };
                            }
                        }
                    }

                    return updatedUserData;
                }
            }
        }

    }
}