using Backend.Models;
using Oracle.ManagedDataAccess.Client;
using System.Data;

namespace Backend.Services
{
    public class PromotionService
    {
        public async Task<List<PromotionModel>> GetAllPromotions()
        {
            await using (OracleConnectionManager manager = new())
            {
                var promotions = new List<PromotionModel>();

                await using (OracleCommand command = new OracleCommand("GetAllPromotions", manager.GetConnection()))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("p_Cursor", OracleDbType.RefCursor).Direction = ParameterDirection.Output;

                    await using (OracleDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            PromotionModel promotion = new PromotionModel
                            {
                                PromotionID = Convert.ToInt32(reader["PromotionID"]),
                                PromotionName = reader["PromotionName"].ToString(),
                                DiscountAmount = Convert.ToInt32(reader["DiscountAmount"]),
                                StartDate = Convert.ToDateTime(reader["StartDate"]),
                                EndDate = Convert.ToDateTime(reader["EndDate"])
                            };

                            promotions.Add(promotion);
                        }
                    }

                    return promotions;
                }
            }
        }

        public async Task<int> CreatePromotion(PromotionModel newPromotion)
        {

            using (OracleConnectionManager manager = new())
            {

                await using (OracleCommand command = new OracleCommand("InsertPromotion", manager.GetConnection()))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.Add("p_PromotionName", OracleDbType.Varchar2).Value = newPromotion.PromotionName;
                    command.Parameters.Add("p_DiscountAmount", OracleDbType.Decimal).Value = newPromotion.DiscountAmount;
                    command.Parameters.Add("p_StartDate", OracleDbType.Date).Value = newPromotion.StartDate;
                    command.Parameters.Add("p_EndDate", OracleDbType.Date).Value = newPromotion.EndDate;

                    command.Parameters.Add("p_PromotionId", OracleDbType.Int32).Direction = ParameterDirection.Output;

                    await command.ExecuteNonQueryAsync();

                    return Convert.ToInt32(command.Parameters["p_PromotionId"].Value.ToString());
                }
            }

        }

        public async Task<PromotionModel> UpdatePromotion(PromotionModel updatedPromotion)
        {
            using (OracleConnectionManager manager = new())
            {
                await using (OracleCommand command = new OracleCommand("UpdatePromotion", manager.GetConnection()))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.Add("p_PromotionID", OracleDbType.Int32).Value = updatedPromotion.PromotionID;
                    command.Parameters.Add("p_PromotionName", OracleDbType.Varchar2).Value = updatedPromotion.PromotionName;
                    command.Parameters.Add("p_DiscountAmount", OracleDbType.Decimal).Value = updatedPromotion.DiscountAmount;
                    command.Parameters.Add("p_StartDate", OracleDbType.Date).Value = updatedPromotion.StartDate;
                    command.Parameters.Add("p_EndDate", OracleDbType.Date).Value = updatedPromotion.EndDate;

                    await command.ExecuteNonQueryAsync();
                }
            }

            return updatedPromotion;
        }
        public async Task<bool> DeletePromotion(PromotionModel deletedPromotion)
        {
            using (OracleConnectionManager manager = new())
            {
                await using (OracleCommand command = new OracleCommand("DeletePromotion", manager.GetConnection()))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("p_promotionID", OracleDbType.Int32).Value = deletedPromotion.PromotionID;

                    await command.ExecuteNonQueryAsync();
                    return true;
                }
            }
        }
    }
}
