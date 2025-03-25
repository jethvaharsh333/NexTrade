using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using NexTrade.Models;

namespace NexTrade.Data
{
    public class ApplicationDBContext: IdentityDbContext<UserModel>
    {
        public ApplicationDBContext(DbContextOptions<ApplicationDBContext> dbContextOptions): base(dbContextOptions)
        {
            
        }

        //public DbSet<UserModel> Users { get; set; }
        public DbSet<StockModel> Stocks { get; set; }
        public DbSet<PortfolioModel> Portfolios { get; set; }
        public DbSet<WatchlistModel> Watchlists { get; set; }
        public DbSet<CommentModel> Comments { get; set; }
        public DbSet<NewsModel> News { get; set; }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);

            builder.Entity<UserModel>()
                .Property(u => u.CreatedAt)
                .HasDefaultValueSql("GETUTCDATE()");

            builder.Entity<UserModel>()
                .Property(u => u.ModifiedAt)
                .HasDefaultValueSql("GETUTCDATE()");

            builder.Entity<PortfolioModel>()
                .Property(u => u.AddedAt)
                .HasDefaultValueSql("GETUTCDATE()");

            //builder.Entity<PortfolioModel>(x => x.HasKey(p => new { p.UserID, p.StockID }));

            //builder.Entity<PortfolioModel>()
            //    .HasOne(u => u.User)
            //    .WithMany(u => u.Portfolios)
            //    .HasForeignKey(p => p.UserID);

            //builder.Entity<PortfolioModel>()
            //    .HasOne(u => u.Stock)
            //    .WithMany(u => u.Portfolios)
            //    .HasForeignKey(p => p.StockID);

            List<IdentityRole> roles = new List<IdentityRole>
            {
                new IdentityRole
                {
                    Id = "1d4f656b-32fd-4c94-91dc-4f5b9d1eb1c7",
                    Name = "Admin",
                    NormalizedName = "ADMIN"
                },
                new IdentityRole
                {
                    Id = "2a94cbbb-1f3a-4d77-913b-fc208a173546",
                    Name = "User",
                    NormalizedName = "USER"
                },
            };

            builder.Entity<IdentityRole>().HasData(roles);
        }
    }
}