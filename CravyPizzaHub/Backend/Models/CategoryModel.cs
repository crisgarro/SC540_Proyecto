namespace Backend.Models
{
    public class CategoryModel
    {
        public int CategoryID { get; set; }

        public string CategoryName { get; set; }

        public int Enabled { get; set; }

        public DateTime? DisabledDate { get; set; }  

        public override bool Equals(object obj) => object.Equals(GetHashCode(), obj?.GetHashCode());

        /// <summary>
        /// Overriding GetHashCode is essential for use with Select and Table because they use HashSets internally
        /// </summary>
        public override int GetHashCode() => CategoryName?.GetHashCode() ?? 0;
    }
}