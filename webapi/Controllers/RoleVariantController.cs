using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using TestData.Data;
using TestData.Models;

namespace webapi.Controllers
{
    public class RoleVariantController : ControllerApiBase
    {
        private readonly TestDataContext _context;
        public RoleVariantController(TestDataContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IEnumerable<RoleVariant> List() {
            return this._context.RoleVariant.FromSqlRaw("exec GetRoleVariant").ToArray();
        }

    }
}
