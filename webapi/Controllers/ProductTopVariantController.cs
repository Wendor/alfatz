using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using TestData.Data;
using TestData.Models;

namespace webapi.Controllers
{
    public class ProductTopVariantController : ControllerApiBase
    {
        private readonly TestDataContext _context;
        public ProductTopVariantController(TestDataContext context)
        {
            _context = context;
        }

        [HttpGet()]
        public IEnumerable<ProductTopVariant> List() {
            return this._context.ProductTopVariant.FromSqlRaw("GetProductTopVariant").ToArray();
        }
    }
}
