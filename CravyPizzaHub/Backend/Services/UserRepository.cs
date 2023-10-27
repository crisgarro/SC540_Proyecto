using Backend.Models;
using Oracle.ManagedDataAccess.Client;
using System.Data;

namespace Backend.Services
{
    public class UserRepository
    {
        private readonly OracleConnection _connection;

        public UserRepository(OracleConnection connection)
        {
            _connection = connection;
        }

        public List<UserModel> GetAllUsers()
        {
            try
            {
                List<UserModel> users = new List<UserModel>();

                using (OracleCommand command = new OracleCommand("GetAllUsers", _connection))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;

                    // Add any input parameters if needed
                    // command.Parameters.Add("parameterName", OracleDbType.DataType).Value = value;
                    command.Parameters.Add("p_users", OracleDbType.RefCursor).Direction = ParameterDirection.Output;

                    using (OracleDataReader reader = command.ExecuteReader())
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
                }
                _connection.Close();

                return users;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}