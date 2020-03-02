using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using TestData.Data;
using TestData.Models;

namespace alfaApi.Controllers
{
    public class ReportController : ControllerApiBase
    {
        private readonly TestDataContext _context;
        public ReportController(TestDataContext context)
        {
            _context = context;
        }

        [HttpGet()]
        public IEnumerable<Report> List()
        {
            // Получаем список возможных отчетов
            return this._context.Report.FromSqlRaw("GetReport").ToArray();
        }
    }
}
