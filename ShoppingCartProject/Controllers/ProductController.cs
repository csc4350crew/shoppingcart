using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EcommerceApplication.Controllers
{
    public class ProductController : Controller
    {
        //
        // GET: /Product/

        public ActionResult Index()
        {
            DataAccess.DALProducts _obj = new DataAccess.DALProducts();
            return View(_obj.GetProductList());
        }

    }
}
