using System.Data;
using Backend.Settings;
using Oracle.ManagedDataAccess.Client;

namespace Backend
{
    public class OracleConnectionManager : IDisposable, IAsyncDisposable
    {
        private readonly OracleConnection _connection;
        private readonly ConfigurationReader _configReader = new();

        public OracleConnectionManager()
        {
            var settings = LoadSettings();

            var connectionString = $"User Id={settings.UserName};Password={settings.Password};" +
                                   $"Data Source=(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST={settings.HostName})" +
                                   $"(PORT={settings.Port}))(CONNECT_DATA=(SID={settings.SID})))";

            _connection ??= new OracleConnection(connectionString);
        }

        private OracleConnectionSettings LoadSettings()
        {
            return _configReader.GetOracleConnectionSettings();
        }

        public OracleConnection GetConnection()
        {
            _connection.Open();
            return _connection;
        }

        public void Dispose()
        {
            CheckConnectionOpen();
            _connection.Dispose();
        }

        public async ValueTask DisposeAsync()
        {
            CheckConnectionOpen();
            await _connection.DisposeAsync();
        }

        private void CheckConnectionOpen()
        {
            if (_connection.State == ConnectionState.Open)
            {
                _connection.Close();
            }
        }
    }
}