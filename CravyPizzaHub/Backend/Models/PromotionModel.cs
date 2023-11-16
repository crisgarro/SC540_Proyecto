namespace Backend.Models
{
    public class PromotionModel
    {
        public int PromotionID { get; set; }
        public string PromotionName { get; set; }
        public Decimal DiscountAmount { get; set; }
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
    }
}