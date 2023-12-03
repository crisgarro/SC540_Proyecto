using Backend.Models;
using Oracle.ManagedDataAccess.Client;
using System.Data;

namespace Backend.Services
{
    public class CategoryService
    {
        public async Task<IEnumerable<CategoryModel>> GetAllCategories()
        {
            List<CategoryModel> categories = new List<CategoryModel>();

            using (OracleConnectionManager manager = new())
            {
                await using (OracleCommand command = new OracleCommand("GetAllCategories", manager.GetConnection()))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("p_Result", OracleDbType.RefCursor).Direction = ParameterDirection.Output;

                    await using (OracleDataReader reader = command.ExecuteReader())
                    {
                        while (await reader.ReadAsync())
                        {
                            CategoryModel category = new CategoryModel
                            {
                                CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID")),
                                CategoryName = reader.GetString(reader.GetOrdinal("CategoryName")),
                                Enabled = reader.GetInt32(reader.GetOrdinal("Enabled"))
                            };

                            categories.Add(category);
                        }
                    }
                }
            }

            return categories;
        }

        public async Task<int> CreateCategory(CategoryModel newCategory)
        {
            int categoryID = 0;
            using (OracleConnectionManager manager = new())
            {
                await using (OracleCommand command = new OracleCommand("InsertCategory", manager.GetConnection()))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.Add("p_CategoryName", OracleDbType.NVarchar2).Value = newCategory.CategoryName;
                    command.Parameters.Add("p_Enabled", OracleDbType.Int32).Value = newCategory.Enabled;

                    OracleParameter p_CategoryID = new OracleParameter("p_CategoryID", OracleDbType.Int32);
                    p_CategoryID.Direction = ParameterDirection.Output;
                    command.Parameters.Add(p_CategoryID);

                    await command.ExecuteNonQueryAsync();
                    categoryID = Convert.ToInt32(p_CategoryID.Value.ToString());
                }
            }

            return categoryID;
        }

        public async Task<CategoryModel> UpdateCategory(CategoryModel updatedCategory)
        {
            int isUpdated = 0;
            using (OracleConnectionManager manager = new())
            {
                await using (OracleCommand command = new OracleCommand("UpdateCategory", manager.GetConnection()))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.Add("p_CategoryID", OracleDbType.Int32).Value = updatedCategory.CategoryID;
                    command.Parameters.Add("p_CategoryName", OracleDbType.NVarchar2).Value = updatedCategory.CategoryName;
                    command.Parameters.Add("p_Enabled", OracleDbType.Int32).Value = updatedCategory.Enabled;

                    await command.ExecuteNonQueryAsync();

                    isUpdated = command.ExecuteNonQuery();
                }
            }

            return isUpdated > 0 ? updatedCategory : null;
        }


        public async Task<CategoryModel> DisableCategory(CategoryModel categoryToDisable, bool state)
        {
            int isUpdated = 0;
            using (OracleConnectionManager manager = new())
            {
                await using (OracleCommand command = new OracleCommand("DisableCategory", manager.GetConnection()))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("p_CategoryID", OracleDbType.Int32).Value = categoryToDisable.CategoryID;
                    command.Parameters.Add("pEnabled", OracleDbType.Int32).Value = state ? 1 : 0;

                    OracleParameter pIsUpdated = new OracleParameter("p_WasChanged", OracleDbType.Int32);
                    pIsUpdated.Direction = ParameterDirection.Output;
                    command.Parameters.Add(pIsUpdated);

                    await command.ExecuteNonQueryAsync();
                    isUpdated = Convert.ToInt32(pIsUpdated.Value.ToString());
                }
            }

            return isUpdated == 1 ? categoryToDisable : null;
        }
    }
}
