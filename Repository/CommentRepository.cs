using Microsoft.EntityFrameworkCore;
using NexTrade.Data;
using NexTrade.Interfaces;
using NexTrade.Models;

namespace NexTrade.Repository
{
    public class CommentRepository: ICommentRepository
    {
        private readonly ApplicationDBContext _context;
        public CommentRepository(ApplicationDBContext context)
        {
            _context = context;
        }

        public async Task<List<CommentModel>> GetAllAsync()
        {
            return await _context.Comments.Include(a => a.User).ToListAsync();
        }

        public async Task<CommentModel?> GetByIDAsync(int commentId)
        {
            return await _context.Comments.Include(u => u.User).FirstOrDefaultAsync(c => c.CommentID == commentId);
        }

        
        public async Task<CommentModel> CreateAsync(CommentModel commentModel)
        {
            await _context.Comments.AddAsync(commentModel);
            await _context.SaveChangesAsync();

            return commentModel;
        }

        public async Task<CommentModel?> UpdateAsync(int commentId, CommentModel commentModel)
        {
            var existingComment = await _context.Comments.FindAsync(commentId);

            if (existingComment == null)
            {
                return null;
            }

            existingComment.CommentTitle = commentModel.CommentTitle;
            existingComment.CommentContent = commentModel.CommentContent;

            await _context.SaveChangesAsync();

            return existingComment;
        }

        public async Task<CommentModel?> DeleteAsync(int id)
        {
            var commentModel = await _context.Comments.FirstOrDefaultAsync(c => c.CommentID == id);

            if (commentModel == null)
            {
                return null;
            }

            _context.Comments.Remove(commentModel);
            await _context.SaveChangesAsync();

            return commentModel;
        }

        public async Task<List<CommentModel>?> GetCommentsByUserIDAsync(string userId) 
        {
            return await _context.Comments.Include(c => c.User).Where(c => c.UserID == userId).ToListAsync();
        }
    }
}
