using Backend.Models;
using Oracle.ManagedDataAccess.Client;
using System.Data;

namespace Backend.Services
{
    public class PaymentMethodService
    {
        public async Task<IEnumerable<PaymentMethodModel>> GetAllPaymentMethods()
        {
            List<PaymentMethodModel> paymentMethods = new List<PaymentMethodModel>();

            using (OracleConnectionManager manager = new())
            {
                await using (OracleCommand command = new OracleCommand("GetAllPaymentMethods", manager.GetConnection()))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("p_Result", OracleDbType.RefCursor).Direction = ParameterDirection.Output;

                    await using (OracleDataReader reader = command.ExecuteReader())
                    {
                        while (await reader.ReadAsync())
                        {
                            PaymentMethodModel paymentMethod = new PaymentMethodModel
                            {
                                PaymentMethodID = reader.GetInt32(reader.GetOrdinal("PaymentMethodID")),
                                PaymentMethodName = reader.GetString(reader.GetOrdinal("PaymentMethodName")),
                                Enabled = reader.GetInt32(reader.GetOrdinal("Enabled"))
                            };
                            paymentMethods.Add(paymentMethod);
                        }
                    }
                }
            }

            return paymentMethods;
        }


        public async Task<int> CreatePaymentMethod(PaymentMethodModel newPaymentMethod)
        {
            int paymentMethodID = 0;
            using (OracleConnectionManager manager = new())
            {
                await using (OracleCommand command = new OracleCommand("InsertPaymentMethod", manager.GetConnection()))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.Add("p_PaymentMethodName", OracleDbType.NVarchar2).Value =
                        newPaymentMethod.PaymentMethodName;
                    command.Parameters.Add("p_Enabled", OracleDbType.Int32).Value = newPaymentMethod.Enabled;

                    OracleParameter p_PaymentMethodID = new OracleParameter("p_PaymentMethodID", OracleDbType.Int32);
                    p_PaymentMethodID.Direction = ParameterDirection.Output;
                    command.Parameters.Add(p_PaymentMethodID);

                    await command.ExecuteNonQueryAsync();
                    paymentMethodID = Convert.ToInt32(p_PaymentMethodID.Value.ToString());
                }
            }

            return paymentMethodID;
        }


        public async Task<PaymentMethodModel> UpdatePaymentMethod(PaymentMethodModel updatedPaymentMethod)
        {
            int isUpdated = 0;
            using (OracleConnectionManager manager = new())
            {
                await using (OracleCommand command = new OracleCommand("UpdatePaymentMethod", manager.GetConnection()))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.Add("p_PaymentMethodID", OracleDbType.Int32).Value = updatedPaymentMethod.PaymentMethodID;
                    command.Parameters.Add("p_PaymentMethodName", OracleDbType.NVarchar2).Value = updatedPaymentMethod.PaymentMethodName;
                    command.Parameters.Add("p_Enabled", OracleDbType.Int32).Value = updatedPaymentMethod.Enabled;

                    OracleParameter wasUpdated = new OracleParameter("p_WasUpdated", OracleDbType.Int32);
                    wasUpdated.Direction = ParameterDirection.Output;
                    command.Parameters.Add(wasUpdated);

                    await command.ExecuteNonQueryAsync();
                    isUpdated = Convert.ToInt32(wasUpdated.Value.ToString());
                }
            }

            return isUpdated == 1 ? updatedPaymentMethod : null;
        }


        public async Task<PaymentMethodModel> DisablePaymentMethod(PaymentMethodModel paymentMethodToDisable, bool state)
        {
            int isUpdated = 0;
            using (OracleConnectionManager manager = new())
            {
                await using (OracleCommand command = new OracleCommand("DisablePaymentMethod", manager.GetConnection()))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("p_PaymentMethodID", OracleDbType.Int32).Value =
                        paymentMethodToDisable.PaymentMethodID;
                    command.Parameters.Add("pEnabled", OracleDbType.Int32).Value = state ? 1 : 0;

                    OracleParameter pIsUpdated = new OracleParameter("p_WasChanged", OracleDbType.Int32);
                    pIsUpdated.Direction = ParameterDirection.Output;
                    command.Parameters.Add(pIsUpdated);

                    await command.ExecuteNonQueryAsync();

                    isUpdated = Convert.ToInt32(pIsUpdated.Value.ToString());
                }
            }

            return isUpdated == 1 ? paymentMethodToDisable : null;
        }
    }
}