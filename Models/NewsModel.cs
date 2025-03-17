using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace NexTrade.Models
{
    [Table("News")]
    public class NewsModel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int NewsID { get; set; }

        [Required]
        [MaxLength(255)]
        public string NewsTitle { get; set; } = string.Empty;

        [Required]
        public string NewsContent { get; set; } = string.Empty;

        [MaxLength(100)]
        public string? NewsSource { get; set; } = string.Empty;

        public DateTime NewsPublishedAt { get; set; } = DateTime.MinValue;

        [ForeignKey("Stock")]
        public int? StockID { get; set; }
        public StockModel? Stock { get; set; }
    }
}
