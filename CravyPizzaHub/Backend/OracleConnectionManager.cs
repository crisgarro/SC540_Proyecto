using System.Data;
using Backend.Settings;
using Microsoft.Extensions.Options;
using Oracle.ManagedDataAccess.Client;

namespace Backend
{
    public class OracleConnectionManager : IDisposable, IAsyncDisposable
    {
        private readonly OracleConnection _connection;

        public OracleConnectionManager(IOptions<OracleConnectionSettings> connectionSettings)
        {
            var settings = connectionSettings.Value;
            var connectionString = $"User Id={settings.UserName};Password={settings.Password};" +
                                   $"Data Source=(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST={settings.HostName})" +
                                   $"(PORT={settings.Port}))(CONNECT_DATA=(SID={settings.SID})))";

            _connection ??= new OracleConnection(connectionString);
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