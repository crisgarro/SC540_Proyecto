namespace Backend.Models
{
    public class RolModel
    {
        public int RoleID { get; set; }

        public string RolName { get; set; }

        public override bool Equals(object obj) => object.Equals(GetHashCode(), obj?.GetHashCode());

        /// <summary>
        /// Overriding GetHashCode is essential for use with Select and Table because they use HashSets internally
        /// </summary>
        public override int GetHashCode() => RolName?.GetHashCode() ?? 0;

        public override string ToString()
        {
            return RolName;
        }
    }
}