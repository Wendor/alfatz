using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using TestData.Data;
using TestData.Models;

namespace alfaApi.Controllers
{
    public class RoleController : ControllerApiBase
    {
        private readonly TestDataContext _context;
        public RoleController(TestDataContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IEnumerable<Role> List()
        {
            return this._context.Role.FromSqlRaw("exec GetRole").ToArray();
        }

    }
}
