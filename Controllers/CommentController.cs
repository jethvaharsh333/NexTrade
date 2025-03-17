using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using NexTrade.Dtos.Comment;
using NexTrade.Extensions;
using NexTrade.Interfaces;
using NexTrade.Interfaces.Stock;
using NexTrade.Mappers;
using NexTrade.Models;
using System.Xml.Linq;

namespace NexTrade.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CommentController : ControllerBase
    {
        private readonly ICommentRepository _commentRepository;
        private readonly IStockRepository _stockRepository;
        private readonly UserManager<UserModel> _userManager;
        public CommentController(ICommentRepository commentRepository, IStockRepository stockRepository, UserManager<UserModel> userManager)
        {
            _commentRepository = commentRepository;
            _stockRepository = stockRepository;
            _userManager = userManager;
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var comments = await _commentRepository.GetAllAsync();
            var commentDto = comments.Select(s => s.ToCommentDto());
            return Ok(commentDto);
        }

        [HttpGet("{commentId}")]
        public async Task<IActionResult> GetById([FromRoute] int commentId)
        {
            var comment = await _commentRepository.GetByIDAsync(commentId);

            if (comment == null)
            {
                return NotFound();
            }

            return Ok(comment.ToCommentDto());
        }

        [HttpGet("get-comments-by-userid")]
        public async Task<IActionResult> GetCommentsByUserId()
        {
            var username = User.GetUserName();
            var appUser = await _userManager.FindByNameAsync(username);

            var userComments = await _commentRepository.GetCommentsByUserIDAsync(appUser.Id);

            if (userComments == null)
            {
                return NotFound();
            }

            var commentDto = userComments.Select(s => s.ToCommentDto());

            return Ok(commentDto);
        }

        [HttpPost("{stockSymbol}")]
        public async Task<IActionResult> Create([FromRoute] string stockSymbol, [FromBody] CreateContentDto createContentDto)
        {
            if(!await _stockRepository.IsStockExist(stockSymbol))
            {
                return BadRequest("Stock doesn't exist.");
            }

            var username = User.GetUserName();
            var appUser = await _userManager.FindByNameAsync(username);

            var commentModel = createContentDto.ToCommentModel(stockSymbol);
            commentModel.UserID = appUser.Id;
            await _commentRepository.CreateAsync(commentModel);

            return CreatedAtAction(nameof(GetById), new { commentId = commentModel.CommentID }, commentModel.ToCommentDto());
        }

        [HttpPut("{commentId}")]
        public async Task<IActionResult> Update([FromRoute] int commentId, [FromBody] UpdateCommentDto updateContentDto)
        {
            try
            {
                var username = User.GetUserName();
            var appUser = await _userManager.FindByNameAsync(username);

            var commentModel = await _commentRepository.GetByIDAsync(commentId);

            if (commentModel == null)
            {
                return NotFound("Comment not found.");
            }

            // Check if the logged-in user is the owner of the comment
            if (commentModel.UserID != appUser.Id)
            {
                return Unauthorized("You can only update your own comments.");
            }


            var updatedcommentModel = await _commentRepository.UpdateAsync(commentId, updateContentDto.ToCommentModelFromUpdate());
            
            if(updatedcommentModel == null)
            {
                return NotFound("Comment not found.");
            }

            return Ok(updatedcommentModel.ToCommentDto());
            }
            catch (Exception e)
            {
                return StatusCode(500, new { error = e.Message });
            }
        }

        [HttpDelete]
        [Route("{commentId}")]
        public async Task<IActionResult> Delete([FromRoute]int commentId) 
        {

            var username = User.GetUserName();
            var appUser = await _userManager.FindByNameAsync(username);

            var commentModel = await _commentRepository.GetByIDAsync(commentId);

            if (commentModel == null)
            {
                return NotFound("Comment does not exist.");
            }

            // Check if the logged-in user is the owner of the comment
            if (commentModel.UserID != appUser.Id)
            {
                return Unauthorized("You can only delete your own comments.");
            }

            var deletedcommentModel = await _commentRepository.DeleteAsync(commentId);

            if(deletedcommentModel == null)
            {
                return NotFound("Comment does not exist.");
            }

            return Ok("Comment deleted");
        }
    }
}
