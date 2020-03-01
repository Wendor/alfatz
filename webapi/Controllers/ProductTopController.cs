using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using TestData.Data;
using TestData.Models;

namespace webapi.Controllers
{
    public class ProductTopController : ControllerApiBase
    {
        private readonly TestDataContext _context;
        public ProductTopController(TestDataContext context)
        {
            _context = context;
        }

        [HttpGet("{id}")]
        public IEnumerable<ProductTop> Get(int id) {
            return this._context.ProductTop.FromSqlRaw("GetProductTop @variant="+id).ToArray();
        }
    }
}
