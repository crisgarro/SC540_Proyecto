﻿namespace Backend.Models
{
    public class ProductModel
    {
        public int ProductID { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public int Price { get; set; }
        public int Stockquantity { get; set; }
        public int CategoryId { get; set; }
    }
}