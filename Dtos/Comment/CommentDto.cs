namespace NexTrade.Dtos.Comment
{
    public class CommentDto
    {
        public int CommentID { get; set; }
        public string CommentTitle { get; set; } = string.Empty;
        public string CommentContent { get; set; } = string.Empty;
        public DateTime CreatedOn { get; set; } = DateTime.Now;
        public string StockSymbol { get; set; }
        public string CreatedBy {  get; set; } = string.Empty;
    }
}
