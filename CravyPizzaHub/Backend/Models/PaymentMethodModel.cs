namespace Backend.Models
{
    public class PaymentMethodModel
    {
        public int PaymentMethodID { get; set; }

        public string PaymentMethodName { get; set; }

        public int Enabled { get; set; }


        public override bool Equals(object obj) => object.Equals(GetHashCode(), obj?.GetHashCode());

        /// <summary>
        /// Overriding GetHashCode is essential for use with Select and Table because they use HashSets internally
        /// </summary>
        public override int GetHashCode() => PaymentMethodName?.GetHashCode() ?? 0;
    }
}