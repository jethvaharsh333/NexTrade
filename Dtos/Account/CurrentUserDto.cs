using System.ComponentModel.DataAnnotations;

namespace NexTrade.Dtos.Account
{
    public class CurrentUserDto
    {
        public string UserName { get; set; }
        public string Email { get; set; }
        public string? Name { get; set; }
        public string? PhoneNumber { get; set; }
    }
}
