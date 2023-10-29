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
    }
}