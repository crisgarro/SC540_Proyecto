using Backend.Models;

namespace Backend.Services
{
    public class UserService
    {
        public static async Task<UserModel?> GetUser()
        {
            OracleConnectionManager manager = new OracleConnectionManager();
            UserRepository userRepository = new UserRepository(manager.GetConnection());

            List<UserModel> users = userRepository.GetAllUsers();

            // You can return the first user as an example
            return users.FirstOrDefault();
        }
    }
}