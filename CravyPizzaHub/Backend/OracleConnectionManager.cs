using Oracle.ManagedDataAccess.Client;

namespace Backend
{
    internal class OracleConnectionManager
    {
        private readonly string _connectionString;
        private OracleConnection _connection;

        public OracleConnectionManager()
        {
            // Configura la cadena de conexión
            string username = "CravyDev";
            string password = "abcd1234";
            string hostname = "localhost";
            int port = 1521;
            string sid = "ORCLCDB";

            _connectionString = $"User Id={username};Password={password};Data Source=(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST={hostname})(PORT={port}))(CONNECT_DATA=(SID={sid})))";
        }

        public void OpenConnection()
        {
            try
            {
                if (_connection == null)
                {
                    _connection = new OracleConnection(_connectionString);
                }

                if (_connection.State != System.Data.ConnectionState.Open)
                {
                    _connection.Open();
                }
            }
            catch (Exception e)
            {
                Console.Write(e.Message + "\n");
            }
        }

        public void CloseConnection()
        {
            if (_connection != null && _connection.State == System.Data.ConnectionState.Open)
            {
                _connection.Close();
            }
        }

        public OracleConnection GetConnection()
        {
            OpenConnection();
            return _connection;
        }
    }
}
