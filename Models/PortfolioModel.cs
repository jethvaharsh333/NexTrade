using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace NexTrade.Models
{
    [Table("Portfolios")]
    public class PortfolioModel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int PortfolioID { get; set; }

        public DateTime InvestmentDate { get; set; }

        public double InvestmentPrice { get; set; }

        public double Quantity { get; set; }

        [ForeignKey("User")]
        public string UserID { get; set; }
        public UserModel User { get; set; }


        [ForeignKey("Stock")]
        public int StockID { get; set; }

        public StockModel Stock { get; set; }

        public DateTime AddedAt { get; set; }
    }
}