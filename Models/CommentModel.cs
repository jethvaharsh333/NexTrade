using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace NexTrade.Models
{
    [Table("Comments")]
    public class CommentModel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int CommentID { get; set; }

        [Required]
        [MaxLength(50)]
        public string CommentTitle { get; set; } = string.Empty;

        [Required]
        [MaxLength(250)]
        public string CommentContent { get; set; } = string.Empty;
        public DateTime CreatedOn { get; set; } = DateTime.Now;

        //[ForeignKey("Stock")]
        public string StockSymbol { get; set; }
        //public int? StockID { get; set; }
        public StockModel? Stock { get; set; }

        [ForeignKey("User")]
        public string UserID { get; set; }  
        public UserModel User { get; set; }
    }
}
