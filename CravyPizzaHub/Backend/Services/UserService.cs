using Backend.Interfaces;
using Backend.Models;
using Oracle.ManagedDataAccess.Client;
using Backend.Settings;
using System.Data;
using Microsoft.Extensions.Options;

namespace Backend.Services
{
    public class UserService
    {
        private readonly IOptions<OracleConnectionSettings> _connectionSettings;

        public UserService(IOptions<OracleConnectionSettings> connectionSettings)
        {
            _connectionSettings = connectionSettings;
        }

        public async Task<UserModel?> GetUser()
        {
            await using OracleConnectionManager manager = new OracleConnectionManager(_connectionSettings);
            var users = new List<UserModel>();

            await using (OracleCommand command = new OracleCommand("GetAllUsers", manager.GetConnection()))
            {
                command.CommandType = System.Data.CommandType.StoredProcedure;

                // Agregar parametros necesarios
                // command.Parameters.Add("parameterName", OracleDbType.DataType).Value = value;
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

                return users.FirstOrDefault();
            }
        }
    }
}