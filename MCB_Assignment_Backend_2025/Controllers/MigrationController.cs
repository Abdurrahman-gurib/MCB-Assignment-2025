using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;

namespace MCBBackend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MigrationController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        public MigrationController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        // Option 1: Remove or comment out the migration endpoint if not needed.
        /*
        [HttpPost("migrate")]
        public IActionResult MigrateData()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(_configuration.GetConnectionString("DefaultConnection")))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand("sp_MigrateData", conn))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.ExecuteNonQuery();
                    }
                }
                return Ok(new { message = "Migration completed successfully." });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Migration failed", error = ex.Message });
            }
        }
        */

        // Retrieve Suppliers data
        [HttpGet("suppliers")]
        public IActionResult GetSuppliers()
        {
            var suppliers = new List<object>();

            try
            {
                using (SqlConnection conn = new SqlConnection(_configuration.GetConnectionString("DefaultConnection")))
                {
                    conn.Open();
                    string query = @"
                        SELECT SupplierID, SupplierName, SupplierContactName, SupplierAddress, 
                               SupplierTown, SupplierContactNumber1, SupplierContactNumber2, SupplierEmail 
                        FROM dbo.Suppliers";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                suppliers.Add(new
                                {
                                    SupplierID = reader["SupplierID"],
                                    SupplierName = reader["SupplierName"],
                                    SupplierContactName = reader["SupplierContactName"],
                                    SupplierAddress = reader["SupplierAddress"],
                                    SupplierTown = reader["SupplierTown"],
                                    SupplierContactNumber1 = reader["SupplierContactNumber1"],
                                    SupplierContactNumber2 = reader["SupplierContactNumber2"],
                                    SupplierEmail = reader["SupplierEmail"]
                                });
                            }
                        }
                    }
                }
                return Ok(suppliers);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Failed to retrieve suppliers", error = ex.Message });
            }
        }

        // Retrieve Orders data
        [HttpGet("orders")]
        public IActionResult GetOrders()
        {
            var orders = new List<object>();

            try
            {
                using (SqlConnection conn = new SqlConnection(_configuration.GetConnectionString("DefaultConnection")))
                {
                    conn.Open();
                    string query = @"
                        SELECT o.OrderID, o.OriginalOrderRef, o.OrderDate, o.OrderTotalAmount, 
                               o.OrderDescription, o.OrderStatus, s.SupplierName
                        FROM dbo.Orders o 
                        LEFT JOIN dbo.Suppliers s ON o.SupplierID = s.SupplierID";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                orders.Add(new
                                {
                                    OrderID = reader["OrderID"],
                                    OriginalOrderRef = reader["OriginalOrderRef"],
                                    OrderDate = reader["OrderDate"],
                                    OrderTotalAmount = reader["OrderTotalAmount"],
                                    OrderDescription = reader["OrderDescription"],
                                    OrderStatus = reader["OrderStatus"],
                                    SupplierName = reader["SupplierName"]
                                });
                            }
                        }
                    }
                }
                return Ok(orders);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Failed to retrieve orders", error = ex.Message });
            }
        }

        // Retrieve Invoices data
        [HttpGet("invoices")]
        public IActionResult GetInvoices()
        {
            var invoices = new List<object>();

            try
            {
                using (SqlConnection conn = new SqlConnection(_configuration.GetConnectionString("DefaultConnection")))
                {
                    conn.Open();
                    string query = @"
                        SELECT InvoiceID, OrderID, InvoiceReference, InvoiceDate, InvoiceStatus, 
                               InvoiceHoldReason, InvoiceAmount, InvoiceDescription
                        FROM dbo.Invoices";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                invoices.Add(new
                                {
                                    InvoiceID = reader["InvoiceID"],
                                    OrderID = reader["OrderID"],
                                    InvoiceReference = reader["InvoiceReference"],
                                    InvoiceDate = reader["InvoiceDate"],
                                    InvoiceStatus = reader["InvoiceStatus"],
                                    InvoiceHoldReason = reader["InvoiceHoldReason"],
                                    InvoiceAmount = reader["InvoiceAmount"],
                                    InvoiceDescription = reader["InvoiceDescription"]
                                });
                            }
                        }
                    }
                }
                return Ok(invoices);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Failed to retrieve invoices", error = ex.Message });
            }
        }
    }
}
