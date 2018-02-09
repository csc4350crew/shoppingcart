using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using EcommerceApplication.Models;
using System.Data.SqlClient;
using System.Configuration;

namespace EcommerceApplication.DataAccess
{
    public class DALProducts
    {

        public List<Products> GetProductList()
        {
            SqlConnection _con = new SqlConnection(ConfigurationManager.ConnectionStrings["ProductDataBaseConnection"].ConnectionString);
            try
            {
                if (_con.State != System.Data.ConnectionState.Open)
                    _con.Open();
                SqlCommand _cmd = _con.CreateCommand();
                _cmd.CommandText = "Select * From Products";
                SqlDataReader _reader = _cmd.ExecuteReader();
                List<Products> _lstPoducts = new List<Products>();
                while (_reader.Read())
                {
                    Products _Products = new Products();
                    _Products.ProductID =Convert.ToInt32(_reader["ProductID"]);
                    _Products.ProductImage = _reader["ProductImage"].ToString();
                    _Products.ProductName = _reader["ProductName"].ToString();
                    _Products.Price = Convert.ToDecimal(_reader["Price"]);
                    _lstPoducts.Add(_Products);
                }
                return _lstPoducts;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (_con.State != System.Data.ConnectionState.Closed)
                    _con.Close();
            }
        }

    }
}