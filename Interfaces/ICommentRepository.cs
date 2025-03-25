using NexTrade.Models;
using System.Globalization;

namespace NexTrade.Interfaces
{
    public interface ICommentRepository
    {
        Task<List<CommentModel>> GetAllAsync();

        Task<CommentModel?> GetByIDAsync(int commentId);

        Task<List<CommentModel>?> GetCommentsByUserIDAsync(string userId);

        Task<CommentModel> CreateAsync(CommentModel commentModel);

        Task<CommentModel?> UpdateAsync(int commentId, CommentModel commentModel);

        Task<CommentModel?> DeleteAsync(int id);
    }
}
