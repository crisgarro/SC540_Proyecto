namespace Backend.Models
{
    public class UserRoleModel
    {
        public int UserRoleId { get; set; }

        public int UserId { get; set; }

        public int RoleId { get; set; }

        public string UserName{ get; set; }

        public string RolName { get; set; }

        public override bool Equals(object obj) => object.Equals(GetHashCode(), obj?.GetHashCode());

        /// <summary>
        /// Overriding GetHashCode is essential for use with Select and Table because they use HashSets internally
        /// </summary>
        public override int GetHashCode() => $"{UserId}-{RoleId}".GetHashCode();

    }
}
