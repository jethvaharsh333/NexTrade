using System.ComponentModel.DataAnnotations;

namespace NexTrade.Dtos.Account
{
    public class UpdateUserDto
    {
        [Required]
        public string Name { get; set; }

        [Required]
        public string Email { get; set; }

        [Required]
        public string UserName { get; set; }

        [Required]
        public string PhoneNumber { get; set; }
    }
}
