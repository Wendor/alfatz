using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using TestData.Data;

namespace alfaApi.Controllers
{
    public class UserRoleController : ControllerApiBase
    {
        private readonly TestDataContext _context;
        public UserRoleController(TestDataContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IEnumerable<int> Get()
        {
            return this._context.Role
                .FromSqlRaw("exec GetUserRole @user=1")
                .Select(e => e.Id)
                .ToArray();
        }

        [HttpPut]
        public int Put(int[] roles)
        {

            int[] roleVariants = this._context.Role
                .FromSqlRaw("exec GetRole")
                .Select(e => e.Id)
                .ToArray();

            DataTable idList = new DataTable();
            idList.TableName = "IdListType";
            idList.Columns.Add("Id", typeof(int));

            foreach (int i in roles)
            {
                if (roleVariants.Contains(i))
                {
                    idList.Rows.Add(i);
                }
            }

            SqlParameter rolesParam = new SqlParameter("roles", SqlDbType.Structured);
            rolesParam.TypeName = idList.TableName;
            rolesParam.Value = idList;

            SqlParameter userParam = new SqlParameter("@user", 1);

            return _context.Database
                .ExecuteSqlRaw(
                    "exec SetUserRole @user, @roles",
                    new[] { userParam, rolesParam }
                );
        }
    }
}
