namespace Backend.Models
{
    public class ReviewModel
    {
        public int ReviewID { get; set; }
        public int UserID { get; set; }
        public int ProductID { get; set; }
        public int Rating { get; set; }
        public string Comments { get; set; }
        public DateTime Timestamp { get; set; }
    }
}
