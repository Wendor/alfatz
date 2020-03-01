using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using TestData.Data;
using TestData.Models;

namespace webapi.Controllers
{
    public class RoleController : ControllerApiBase
    {
        private readonly TestDataContext _context;
        public RoleController(TestDataContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IEnumerable<int> Get() {
            return this._context.Role
                .FromSqlRaw("exec GetRole")
                .Select(e => e.Id)
                .ToArray();
        }

        [HttpPut]
        public int Put(int[] roles) {

            int[] roleVariants = this._context.RoleVariant
                .FromSqlRaw("exec GetRoleVariant")
                .Select(e=>e.Id)
                .ToArray();

            DataTable dataTable = new DataTable();
            dataTable.TableName = "RoleType";
            dataTable.Columns.Add("Id", typeof(int));

            foreach(int i  in roles) {
                if(roleVariants.Contains(i)) {
                    dataTable.Rows.Add(i);
                }
            }

            SqlParameter parameter = new SqlParameter("roles", SqlDbType.Structured);
            parameter.TypeName = dataTable.TableName;
            parameter.Value = dataTable;

            return _context.Database.ExecuteSqlRaw("exec SetRole @roles", parameter);
        }
    }
}
