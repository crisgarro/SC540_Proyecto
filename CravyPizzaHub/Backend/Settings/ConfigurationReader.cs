using Microsoft.Extensions.Configuration;

namespace Backend.Settings
{
    public  class ConfigurationReader
    {
        private IConfiguration Configuration { get; }

        public ConfigurationReader()
        {
            var builder = new ConfigurationBuilder()
                .SetBasePath(System.AppContext.BaseDirectory)
                .AddJsonFile("appsettings.json");

            Configuration = builder.Build();
        }

        public OracleConnectionSettings GetOracleConnectionSettings()
        {
            var oracleConnectionSettings = new OracleConnectionSettings();
            Configuration.GetSection("OracleConnectionSettings").Bind(oracleConnectionSettings);
            return oracleConnectionSettings;
        }
    }
}
