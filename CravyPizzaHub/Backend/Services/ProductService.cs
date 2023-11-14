using Backend.Models;
using Oracle.ManagedDataAccess.Client;
using System.Data;

namespace Backend.Services
{
    public class ProductService
    {
        public async Task<List<ProductModel>> GetAllProducts()
        {
            await using (OracleConnectionManager manager = new())
            {
                var products = new List<ProductModel>();

                await using (OracleCommand command = new OracleCommand("GetAllProducts", manager.GetConnection()))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("p_products", OracleDbType.RefCursor).Direction = ParameterDirection.Output;

                    await using (OracleDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            ProductModel product = new ProductModel
                            {
                                ProductID = Convert.ToInt32(reader["ProductID"]),
                                Name = reader["Name"].ToString(),
                                Description = reader["Description"].ToString(),
                                Price = Convert.ToInt32(reader["Price"]),
                                Stockquantity = Convert.ToInt32(reader["Stockquantity"]),
                                CategoryId = Convert.ToInt32(reader["CategoryId"])
                            };

                            products.Add(product);
                        }
                    }

                    return products;
                }
            }
        }

        public async Task<int> CreateProduct(ProductModel newProduct)
        {
            using (OracleConnectionManager manager = new())
            {
                await using (OracleCommand command = new OracleCommand("InsertProduct", manager.GetConnection()))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.Add("p_name", OracleDbType.Varchar2).Value = newProduct.Name;
                    command.Parameters.Add("p_description", OracleDbType.Varchar2).Value = newProduct.Description;
                    command.Parameters.Add("p_price", OracleDbType.Varchar2).Value = newProduct.Price;
                    command.Parameters.Add("p_stockquantity", OracleDbType.Varchar2).Value = newProduct.Stockquantity;
                    command.Parameters.Add("p_categoryId", OracleDbType.Int32).Value = newProduct.CategoryId;

                    command.Parameters.Add("p_productId", OracleDbType.Int32).Direction = ParameterDirection.Output;

                    await command.ExecuteNonQueryAsync();

                    return Convert.ToInt32(command.Parameters["p_productId"].Value.ToString());
                }
            }
        }

        public async Task<ProductModel> UpdateProduct(ProductModel updatedProduct)
        {
            int isUpdated = 0;
            using (OracleConnectionManager manager = new())
            {
                await using (OracleCommand command = new OracleCommand("updatedProduct", manager.GetConnection()))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.Add("pProductID", OracleDbType.Int32).Value = updatedProduct.ProductID;
                    command.Parameters.Add("pName", OracleDbType.Varchar2).Value = updatedProduct.Name;
                    command.Parameters.Add("pDescription", OracleDbType.Varchar2).Value = updatedProduct.Description;
                    command.Parameters.Add("pPrice", OracleDbType.Varchar2).Value = updatedProduct.Price;
                    command.Parameters.Add("pStockQuantity", OracleDbType.Varchar2).Value = updatedProduct.Stockquantity;
                    command.Parameters.Add("pCategoryId", OracleDbType.Int32).Value = updatedProduct.CategoryId;

                    OracleParameter pIsUpdated = new OracleParameter("pIsUpdated", OracleDbType.Int32);
                    pIsUpdated.Direction = ParameterDirection.Output;
                    command.Parameters.Add(pIsUpdated);

                    await command.ExecuteNonQueryAsync();
                    isUpdated = Convert.ToInt32(pIsUpdated.Value.ToString());
                }
            }

            return isUpdated == 1 ? updatedProduct : null;
        }

    }
}