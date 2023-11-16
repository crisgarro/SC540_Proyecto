using Backend.Models;
using Oracle.ManagedDataAccess.Client;
using System.Data;

namespace Backend.Services
{
    public class RewardService
    {
        public async Task<List<RewardModel>> GetAllRewards()
        {
            await using (OracleConnectionManager manager = new())
            {
                var rewards = new List<RewardModel>();

                await using (OracleCommand command = new OracleCommand("GetAllRewards", manager.GetConnection()))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("p_RewardInfo", OracleDbType.RefCursor).Direction = ParameterDirection.Output;

                    await using (OracleDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            RewardModel reward = new RewardModel
                            {
                                RewardID = Convert.ToInt32(reader["RewardID"]),
                                UserID = Convert.ToInt32(reader["UserID"]),
                                Points = Convert.ToInt32(reader["Points"])
                            };

                            rewards.Add(reward);
                        }
                    }

                    return rewards;
                }
            }
        }

        public async Task<int> CreateReward(RewardModel newReward)
        {
            using (OracleConnectionManager manager = new())
            {
                await using (OracleCommand command = new OracleCommand("InsertReward", manager.GetConnection()))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.Add("p_UserID", OracleDbType.Int32).Value = newReward.UserID;
                    command.Parameters.Add("p_Points", OracleDbType.Int32).Value = newReward.Points;


                    command.Parameters.Add("p_RewardID", OracleDbType.Int32).Direction = ParameterDirection.Output;

                    await command.ExecuteNonQueryAsync();

                    return Convert.ToInt32(command.Parameters["p_RewardID"].Value.ToString());
                }
            }
        }

        public async Task<RewardModel> UpdateReward(RewardModel updatedReward)
        {
            using (OracleConnectionManager manager = new())
            {
                await using (OracleCommand command = new OracleCommand("UpdateReward", manager.GetConnection()))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.Add("p_RewardID", OracleDbType.Int32).Value = updatedReward.RewardID;
                    command.Parameters.Add("p_UserID", OracleDbType.Int32).Value = updatedReward.UserID;
                    command.Parameters.Add("p_Points", OracleDbType.Int32).Value = updatedReward.Points;

                    await command.ExecuteNonQueryAsync();
                }
            }

            return updatedReward;
        }


    }
}