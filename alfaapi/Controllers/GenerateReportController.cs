using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using TestData.Data;
using TestData.Models;

namespace alfaApi.Controllers
{
    public class GenerateReportController : ControllerApiBase
    {
        private readonly TestDataContext _context;
        public GenerateReportController(TestDataContext context)
        {
            _context = context;
        }

        [HttpGet("{id}")]
        public IEnumerable<GeneratedReport> Get(int id)
        {
            // Получаем роли пользователя
            int[] allowedReports = this._context.Role
                .FromSqlRaw("exec GetUserRole @user=1")
                .Select(e => e.Id)
                .ToArray();

            // Проверяем, разрешен ли пользователю данный отчет
            if (!allowedReports.Contains(id))
            {
                return new List<GeneratedReport>();
            }

            // Генерируем отчет
            return this._context.GeneratedReport
                .FromSqlRaw("exec GenerateReport @variant=" + id)
                .ToArray();
        }
    }
}
