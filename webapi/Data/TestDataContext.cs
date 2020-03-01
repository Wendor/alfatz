using TestData.Models;
using Microsoft.EntityFrameworkCore;

namespace TestData.Data
{
  public class TestDataContext : DbContext
  {
    public TestDataContext(DbContextOptions<TestDataContext> options) : base(options)
    {
    }

    public DbSet<ProductTop> ProductTop { get; set; }
    public DbSet<ProductTopVariant> ProductTopVariant { get; set; }
    public DbSet<RoleVariant> RoleVariant { get; set; }
    public DbSet<Role> Role { get; set; }
  }
}
