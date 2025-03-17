using NexTrade.Dtos.Comment;

namespace NexTrade.Dtos.Stock
{
    public class StockDto
    {
        public int StockID { get; set; }    

        public string StockName { get; set; } = string.Empty;

        public string StockSymbol { get; set; } = string.Empty;

        public DateTime DateOfListing { get; set; }

        public int FaceValue { get; set; }

        public string? StockImage { get; set; } = string.Empty;

        public string? Industry { get; set; } = string.Empty;

        public List<CommentDto> Comments { get; set; }
    }
}
