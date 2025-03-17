using NexTrade.Dtos.Comment;
using NexTrade.Models;

namespace NexTrade.Mappers
{
    public static class CommentMapper
    {
        public static CommentDto ToCommentDto(this CommentModel commentModel)
        {
            return new CommentDto
            {
                CommentID = commentModel.CommentID,
                CommentTitle = commentModel.CommentTitle,
                CommentContent = commentModel.CommentContent,
                CreatedOn = commentModel.CreatedOn,
                CreatedBy = commentModel.User.UserName,
                StockSymbol = commentModel.StockSymbol,
            };
        }

        public static CommentModel ToCommentModel(this CreateContentDto createContentDto, string stockSymbol)
        {
            return new CommentModel
            {
                CommentTitle = createContentDto.CommentTitle,
                CommentContent = createContentDto.CommentContent,
                StockSymbol = stockSymbol,
            };
        }

        public static CommentModel ToCommentModelFromUpdate(this UpdateCommentDto updateCommentDto)
        {
            return new CommentModel
            {
                CommentTitle = updateCommentDto.CommentTitle,
                CommentContent = updateCommentDto.CommentContent,
            };
        }
    }
}