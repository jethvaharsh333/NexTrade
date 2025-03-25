using System.ComponentModel.DataAnnotations;

namespace NexTrade.Dtos.Account
{
    public class LoginDto
    {
        [Required]
        public string Identifier { get; set; }
        //public string? Email { get; set; }

        [Required]
        public string Password { get; set; }
    }
}
