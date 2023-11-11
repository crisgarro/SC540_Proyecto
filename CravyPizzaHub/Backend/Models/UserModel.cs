namespace Backend.Models
{
    public class UserModel
    {
        public int UserID { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Address { get; set; }
        public string Phone { get; set; }
        public DateTime Last_Login { get; set; }
        public bool Require_Change_Password { get; set; }
        public bool Enable { get; set; }
        public DateTime Disabled_Date { get; set; }
    }
}