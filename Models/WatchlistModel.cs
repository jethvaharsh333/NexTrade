using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace NexTrade.Models
{
    [Table("Watchlists")]
    public class WatchlistModel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int WatchlistID { get; set; }


        [ForeignKey("User")]
        public string UserID { get; set; }
        public UserModel User { get; set; }


        [ForeignKey("Stock")]
        public int StockID { get; set; }
        public StockModel Stock { get; set; }


        public decimal? AlertPrice { get; set; }
        public DateTime CreatedAt { get; set; } = DateTime.Now;
    }
}
