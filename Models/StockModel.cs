using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace NexTrade.Models
{
    [Table("Stocks")]
    public class StockModel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int StockID { get; set; }

        [Required]
        [MaxLength(100)]
        public string StockName { get; set; } = string.Empty;

        [Required]
        //[Key]
        [MaxLength(10)]
        public string StockSymbol { get; set; } = string.Empty;

        public DateTime DateOfListing { get; set; }

        public int FaceValue { get; set; }

        [MaxLength(255)]
        public string? StockImage { get; set; } = string.Empty;

        public string? Industry { get; set; } = string.Empty;

        public List<CommentModel> Comments { get; set; } = new List<CommentModel>();

        public List<PortfolioModel> Portfolios { get; set; } = new List<PortfolioModel>();

        public List<WatchlistModel> Watchlists { get; set; } = new List<WatchlistModel>();

        public List<NewsModel> News { get; set; } = new List<NewsModel>();
    }
}
