using Backend.Models;
using Oracle.ManagedDataAccess.Client;
using Oracle.ManagedDataAccess.Types;
using System.Data;
using System.Globalization;

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
                                StartDate = DateTime.ParseExact(reader["StartDate"].ToString(), "dd/MM/yyyy", CultureInfo.InvariantCulture),
                                EndDate = DateTime.ParseExact(reader["EndDate"].ToString(), "dd/MM/yyyy", CultureInfo.InvariantCulture),
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
                    command.Parameters.Add("p_DiscountAmount", OracleDbType.Decimal).Value = new OracleDecimal(newPromotion.DiscountAmount);
                    command.Parameters.Add("p_StartDate", OracleDbType.Varchar2).Value = newPromotion.StartDate;
                    command.Parameters.Add("p_EndDate", OracleDbType.Varchar2).Value = newPromotion.EndDate;

                    command.Parameters.Add("p_PromotionId", OracleDbType.Int32).Direction = ParameterDirection.Output;

                    await command.ExecuteNonQueryAsync();

                    return Convert.ToInt32(command.Parameters["p_PromotionId"].Value.ToString());
                }
            }

        }

        public async Task<PromotionModel> UpdatePromotion(PromotionModel updatedPromotion)
        {
            int isUpdated = 0;
            using (OracleConnectionManager manager = new())
            {
                await using (OracleCommand command = new OracleCommand("updatedPromotion", manager.GetConnection()))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("p_PromotionID", OracleDbType.Int32).Value = updatedPromotion.PromotionID;
                    command.Parameters.Add("p_PromotionName", OracleDbType.Varchar2).Value = updatedPromotion.PromotionName;
                    command.Parameters.Add("p_DiscountAmount", OracleDbType.Decimal).Value = new OracleDecimal(updatedPromotion.DiscountAmount);
                    command.Parameters.Add("p_StartDate", OracleDbType.Varchar2).Value = updatedPromotion.StartDate;
                    command.Parameters.Add("p_EndDate", OracleDbType.Varchar2).Value = updatedPromotion.EndDate;

                    OracleParameter pIsUpdated = new OracleParameter("pIsUpdated", OracleDbType.Int32);
                    pIsUpdated.Direction = ParameterDirection.Output;
                    command.Parameters.Add(pIsUpdated);

                    await command.ExecuteNonQueryAsync();
                    isUpdated = Convert.ToInt32(pIsUpdated.Value.ToString());
                }
            }

            return isUpdated == 1 ? updatedPromotion : null;
        }

    }
}