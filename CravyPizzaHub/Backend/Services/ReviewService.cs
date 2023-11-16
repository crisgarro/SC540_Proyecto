using Backend.Models;
using Oracle.ManagedDataAccess.Client;
using System.Data;

namespace Backend.Services
{
    public class ReviewService
    {
        public async Task<List<ReviewModel>> GetAllReviews()
        {
            await using (OracleConnectionManager manager = new())
            {
                var reviews = new List<ReviewModel>();

                await using (OracleCommand command = new OracleCommand("GetAllReviews", manager.GetConnection()))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("p_Reviews", OracleDbType.RefCursor).Direction = ParameterDirection.Output;

                    await using (OracleDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            ReviewModel review = new ReviewModel
                            {
                                ReviewID = Convert.ToInt32(reader["ReviewID"]),
                                UserID = Convert.ToInt32(reader["UserID"]),
                                ProductID = Convert.ToInt32(reader["ProductID"]),
                                Rating = Convert.ToInt32(reader["Rating"]),
                                Comments = reader["Comments"].ToString(),
                                Timestamp = Convert.ToDateTime(reader["Timestamp"])
                            };

                            reviews.Add(review);
                        }
                    }

                    return reviews;
                }
            }
        }

        public async Task<int> CreateReview(ReviewModel newReview)
        {
            using (OracleConnectionManager manager = new())
            {
                await using (OracleCommand command = new OracleCommand("InsertReview", manager.GetConnection()))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.Add("p_UserID", OracleDbType.Int32).Value = newReview.UserID;
                    command.Parameters.Add("p_ProductID", OracleDbType.Int32).Value = newReview.ProductID;
                    command.Parameters.Add("p_Rating", OracleDbType.Int32).Value = newReview.Rating;
                    command.Parameters.Add("p_Comments", OracleDbType.Varchar2).Value = newReview.Comments;
                    command.Parameters.Add("p_Timestamp", OracleDbType.TimeStamp).Value = newReview.Timestamp;

                    command.Parameters.Add("p_ReviewID", OracleDbType.Int32).Direction = ParameterDirection.Output;

                    await command.ExecuteNonQueryAsync();

                    return Convert.ToInt32(command.Parameters["p_ReviewID"].Value.ToString());
                }
            }
        }

        public async Task<ReviewModel> UpdateReview(ReviewModel updatedReview)
        {
            using (OracleConnectionManager manager = new())
            {
                await using (OracleCommand command = new OracleCommand("UpdateReview", manager.GetConnection()))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.Add("p_ReviewID", OracleDbType.Int32).Value = updatedReview.ReviewID;
                    command.Parameters.Add("p_Rating", OracleDbType.Int32).Value = updatedReview.Rating;
                    command.Parameters.Add("p_Comments", OracleDbType.Varchar2).Value = updatedReview.Comments;

                    await command.ExecuteNonQueryAsync();
                }
            }

            return updatedReview;
        }

        public async Task<bool> DeleteReview(ReviewModel deletedReview)
        {
            using (OracleConnectionManager manager = new())
            {
                await using (OracleCommand command = new OracleCommand("DeleteReview", manager.GetConnection()))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("p_ReviewID", OracleDbType.Int32).Value = deletedReview.ReviewID;

                    await command.ExecuteNonQueryAsync();
                    return true;
                }
            }
        }

    }
}
