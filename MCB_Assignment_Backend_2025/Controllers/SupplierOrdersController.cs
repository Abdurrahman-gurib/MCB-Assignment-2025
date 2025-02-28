using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System.Data;
using System.Collections.Generic;

namespace MCBBackend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SupplierOrdersController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        public SupplierOrdersController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        // GET: api/SupplierOrders/summary
        [HttpGet("summary")]
        public IActionResult GetSupplierOrdersSummary()
        {
            DataTable dt = new DataTable();
            string connectionString = _configuration.GetConnectionString("DefaultConnection");

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                // Use the stored procedure sp_ReportSupplierOrdersByMonth
                using (SqlCommand cmd = new SqlCommand("sp_ReportSupplierOrdersByMonth", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }

            // Convert DataTable rows to a list of dictionaries for JSON serialization
            var result = new List<Dictionary<string, object>>();
            foreach (DataRow row in dt.Rows)
            {
                var dict = new Dictionary<string, object>();
                foreach (DataColumn col in dt.Columns)
                {
                    // Optionally, check for DBNull values and convert them to a dash (-)
                    object value = row[col] is DBNull ? "-" : row[col];
                    dict[col.ColumnName] = value;
                }
                result.Add(dict);
            }

            return Ok(result);
        }
    }
}
