using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Identity;

namespace NexTrade.Models
{
    [Table("Users")]
    public class UserModel: IdentityUser
    {
        public bool BiometricEnabled { get; set; } = false;

        [Column(TypeName = "varchar(50)")]
        public String? Name { get; set; }

        public DateTime CreatedAt { get; set; }
        public DateTime ModifiedAt { get; set; }

        public List<PortfolioModel> Portfolios { get; set; } = new List<PortfolioModel>();
        public List<WatchlistModel> Watchlists { get; set; } = new List<WatchlistModel>();
    }
}
