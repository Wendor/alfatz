using TestData.Models;
using Microsoft.EntityFrameworkCore;

namespace TestData.Data
{
  public class TestDataContext : DbContext
  {
    public TestDataContext(DbContextOptions<TestDataContext> options) : base(options)
    {
    }

    public DbSet<GeneratedReport> GeneratedReport { get; set; }
    public DbSet<Report> Report { get; set; }
    public DbSet<Role> Role { get; set; }
    public DbSet<UserRole> UserRole { get; set; }
  }
}
