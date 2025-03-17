using System.ComponentModel.DataAnnotations;

namespace NexTrade.Dtos.Account
{
    public class UpdateUserPassword
    {
        [Required]
        public string CurrentPassword { get; set; }

        [Required]
        public string NewPassword { get; set; }

        [Compare("NewPassword", ErrorMessage = "Password and Confirm Password must match.")]
        public string ConfirmPassword { get; set; }
    }
}
